# Day 17 - Flutter Supabase Integration

## Overview

Day 17 focused on integrating **Supabase** into Flutter — project setup, authentication (email/password, magic link, Google OAuth), database CRUD with Row Level Security, and real-time subscriptions. The app, `supabase_flutter_app`, was backed by a Supabase project (`flutter-internship-app`) using the `supabase_flutter` package, with tables and security policies configured directly via the Supabase SQL Editor and Dashboard rather than a CLI.

## Learning Objectives

* Setup Supabase in Flutter
* Implement Supabase Auth
* Use Supabase database
* Real-time features

## Topics Covered

### Supabase Project Setup

* Creating a Supabase project and locating the **Project URL** (`Settings → General` or `Settings → Data API`) and **anon/publishable key** (`Settings → API Keys`)
* Supabase's newer dashboard naming: **Publishable key** is the current name for the legacy **anon key**; **Secret key** is the current name for the legacy **service_role key**. A "Legacy anon, service_role API keys" tab exists for older `supabase_flutter` versions expecting the old JWT-style anon key
* Installing via `flutter pub add supabase_flutter`

### Supabase Initialization

* `Supabase.initialize(url: ..., anonKey: ...)` inside an async `main()`, called before `runApp()`
* `supabaseUrl` must be the **base project URL only** (e.g. `https://xxxx.supabase.co`) — no path suffix, no trailing slash. Appending `/rest/v1/` manually caused all auth/database requests to resolve to an invalid, doubled path

### Authentication

* `signUp()` and `signInWithPassword()` for email/password auth
* `signInWithOtp()` for magic link authentication
* `signInWithOAuth(OAuthProvider.google, redirectTo: ...)` for Google OAuth
* `signOut()`
* `AuthGate` widget using `onAuthStateChange` (`StreamBuilder<AuthState>`) to auto-route between `LoginScreen` and `HomeScreen` — no manual navigation calls needed after sign-in/sign-out

### Google OAuth Configuration

* Google Cloud Console OAuth Client must be created as **Web application** type, not Android — the flow routes through Supabase's own server-side callback, not a native Android SDK integration
* Authorized redirect URI required in Google Cloud Console: `https://<project-ref>.supabase.co/auth/v1/callback`
* Supabase Dashboard → `Authentication → Providers → Google` — Client ID/Secret entered here
* Supabase Dashboard → `Authentication → URL Configuration → Redirect URLs` — app deep link (`io.supabase.flutterapp://login-callback/`) must be explicitly added, otherwise Supabase falls back to the default Site URL
* `AndroidManifest.xml` requires an additional `<intent-filter>` on the main activity (`action.VIEW`, `category.DEFAULT` + `category.BROWSABLE`, `data android:scheme="io.supabase.flutterapp" android:host="login-callback"`) so the OS routes the redirect back into the app instead of a browser

### Database (CRUD + RLS)

* Tables created via SQL Editor: `profiles` (one-to-one with `auth.users`), `tasks` and `notifications` (one-to-many, linked via `user_id`)
* `gen_random_uuid()` for auto-generated primary keys
* Insert (`.insert()`), query (`.select().eq().order()`), update (`.update().eq()`), delete (`.delete().eq()`) via `supabase_flutter`'s query builder
* `.upsert()` used for the profile save, since a profile row may or may not already exist for a given user
* `.maybeSingle()` used instead of `.single()` when loading a profile, since a brand-new account has no row yet and `.single()` would throw
* Row Level Security: enabled per table, with `using`/`with check` policies restricting each user to rows matching `auth.uid()`. RLS is deny-by-default once enabled — no policy means no access, even for a table with data
* Testing RLS from the Table Editor while logged in as the project owner bypasses RLS (admin role) — real verification requires testing through the app as a normal auth user

### Real-Time Subscriptions

* `.stream(primaryKey: ['id'])` on the `notifications` table, filtered with `.eq('user_id', ...)`
* `StreamBuilder` in the UI layer — automatically rebuilds on new data and automatically cancels its subscription on widget disposal, no manual subscribe/unsubscribe code needed
* Realtime must be enabled for the table under `Database → Replication` for the stream to receive changes
* Real-time scoped only to `notifications`; the `tasks` CRUD screen intentionally uses one-off queries + manual reload instead of `.stream()`, since real-time was a separate, distinct task item from general CRUD

## Application Built

### `supabase_flutter_app`

## Features

* Email/password sign-up and sign-in, with Supabase error messages surfaced in the UI
* Magic link sign-in via `signInWithOtp`
* Google OAuth sign-in, routed through Supabase's callback and back into the app via a registered deep link
* `AuthGate` widget using `onAuthStateChange` to auto-route between Login and Home
* Task list screen with full CRUD (add, toggle done, delete), scoped to the logged-in user via RLS
* Notifications screen with live updates via Supabase real-time streams
* Profile screen storing and editing the user's full name against the `profiles` table
* Sign-out clears session and auto-routes back to Login via the same stream

## Concepts Learned

### The Supabase URL must be the bare project domain — services append their own path

Hardcoding `/rest/v1/` onto `supabaseUrl` because that's the REST endpoint path caused every request — not just database calls — to fail with a 404 "Invalid path," since `Supabase.initialize()` appends the correct sub-path (`/rest/v1/`, `/auth/v1/`, etc.) internally per service. The fix was reducing the URL to just `https://<project-ref>.supabase.co`.

### Dashboard key names changed, but the underlying auth model didn't

Supabase's current dashboard shows "Publishable key" and "Secret key" instead of the older "anon" and "service_role" labels. Functionally identical — publishable/anon is safe for client apps under RLS, secret/service_role is not. The presence of a "Legacy" tab exists specifically so older SDK versions expecting the old key format aren't broken by the rename.

### OAuth "application type" depends on where the redirect actually lands, not what platform the app runs on

Even though the app is Android/Flutter, the Google Cloud OAuth client had to be **Web application** type, because the OAuth redirect target is Supabase's server-side callback URL, not a native Android intent. An Android-type client would have required a package name + SHA-1 fingerprint for a different integration pattern (native Google Sign-In SDK) that `signInWithOAuth()` doesn't use.

### A missing deep link registration silently redirects to `localhost`, not an obvious auth error

After Google auth succeeded, the app opened `localhost:3000` (Supabase's default Site URL) instead of returning to the app — because the redirect URL wasn't in Supabase's allow-list, so it fell back to Site URL. This needed two separate fixes: adding the redirect URL under Supabase's `Authentication → URL Configuration`, and adding a matching `<intent-filter>` in `AndroidManifest.xml` so Android itself knows to hand that URI scheme back to the app.

### Rate limits on auth emails are expected platform behavior, not a bug

Repeated sign-up/magic-link testing against multiple throwaway emails in a short window triggered `email rate limit exceeded` (429, `over_email_send_rate_limit`) — a free-tier throttle on Supabase's end, unrelated to any code issue. Resolved by waiting for the limit to reset and switching to sign-in (which sends no email) for further testing in the meantime.

### RLS policies determine query results silently — an empty result isn't always a bug

With RLS enabled and no matching policy, a query returns an empty list rather than an error, which can look identical to "no data exists yet" or "the query is wrong." Confirming this needed manually inserting a test row in the dashboard with the correct `user_id` and checking whether it surfaced through the app's own logged-in session — testing as the project owner in the dashboard doesn't exercise RLS at all.

## Important Issues Encountered

**Root causes, in the order they surfaced:**
1. `supabaseUrl` incorrectly set to `.../rest/v1/` instead of the bare project domain, causing all requests to 404
2. Clipboard confusion between a Google OAuth Client Secret (`GOCSPX-...`) and the Supabase publishable/anon key, surfacing as "No API key found in request"
3. Google Cloud OAuth client created without clarity on Web vs Android application type
4. Missing redirect URL in Supabase's `Authentication → URL Configuration`, causing OAuth to redirect to `localhost:3000` instead of back into the app
5. Missing `<intent-filter>` for the custom URI scheme in `AndroidManifest.xml`, needed alongside the Supabase-side redirect URL fix
6. Supabase auth email rate limit hit from repeated sign-up/magic-link testing across multiple test accounts

Resolution: each issue was isolated and fixed independently (URL correction, key re-verification, OAuth client type correction, redirect URL + manifest intent-filter added together, rate limit resolved by waiting and switching to sign-in for further testing) rather than requiring a project rebuild.

## Current Verification Status

Auth (email/password, magic link), database CRUD, RLS, and real-time notifications were each tested individually as they were built. **A single end-to-end run covering the full flow — sign-up through Google OAuth sign-in through profile save through task CRUD through live notification — has not yet been recorded in one session.** Confirm the checklist below before treating Day 17 as complete.

## Final Verification Checklist

* [ ] `flutter clean && flutter pub get && flutter run` completes with no compile errors
* [ ] Sign up with email/password → confirmation email received → account appears in `Authentication → Users`
* [ ] Sign in with email/password → `AuthGate` auto-routes to Home screen
* [ ] Magic link sign-in works end-to-end (email received, link logs the user in)
* [ ] Google OAuth sign-in redirects back into the app (not to `localhost`) and lands on Home
* [ ] Sign out → auto-routes back to Login screen
* [ ] Profile screen: entering a name and saving updates the `profiles` table correctly
* [ ] Tasks screen: add, mark done, and delete all reflect correctly in the `tasks` table
* [ ] A task/profile row created under one test account is not visible when logged in as a different account (RLS confirmed working, not just enabled)
* [ ] Notifications screen updates live when a row is inserted manually via the dashboard, with no manual refresh
* [ ] `Database → Replication` shows `notifications` enabled for realtime
* [ ] Only one Google OAuth redirect URI is registered per environment (no leftover `localhost` entries added unnecessarily)

## Repository Structure

```text
Day 17/
│
├── supabase_flutter_app/
│   ├── lib/
│   │   ├── main.dart
│   │   ├── auth/
│   │   │   ├── auth_gate.dart
│   │   │   ├── login_screen.dart
│   │   │   └── signup_screen.dart
│   │   ├── home/
│   │   │   ├── home_screen.dart
│   │   │   ├── tasks_screen.dart
│   │   │   ├── notifications_screen.dart
│   │   │   └── profile_screen.dart
│   │   └── services/
│   │       ├── task_service.dart
│   │       └── notification_service.dart
│   ├── android/
│   │   └── app/
│   │       └── src/main/AndroidManifest.xml
│   ├── pubspec.yaml
│   └── README.md
└── README.md
```

## Screenshots

> _Add screenshots here once the verification checklist above is completed._

| Screen | Screenshot |
|---|---|
| Login screen |<img width="339" height="747" alt="image" src="https://github.com/user-attachments/assets/d49f8fb8-2194-4f31-849f-28df647ddb25" />
 |
| Sign up screen |<img width="337" height="744" alt="image" src="https://github.com/user-attachments/assets/da0e74e8-3a29-419e-b212-03d9f11d9997" />
 |
| Home screen | <img width="340" height="758" alt="image" src="https://github.com/user-attachments/assets/05bedacf-3f61-411a-abb7-49847b789adc" />
 |
| Tasks (CRUD) screen |<img width="341" height="743" alt="image" src="https://github.com/user-attachments/assets/529be1af-ab68-4714-8b7c-49d14f16af1d" />
 |
| Notifications (real-time) screen | <img width="340" height="753" alt="image" src="https://github.com/user-attachments/assets/2cb88517-d13a-40b5-a686-80f81b01a6b5" />
 |
| Profile screen |<img width="342" height="738" alt="image" src="https://github.com/user-attachments/assets/991e59b4-fc5a-4633-907f-e1584af44b33" />
 |
| Supabase Dashboard — Authentication → Users | <img width="1919" height="906" alt="image" src="https://github.com/user-attachments/assets/d69dc555-9c9b-44e6-a73b-e6be5b4943c9" />
 |
| Supabase Dashboard — Table Editor (tasks / notifications) | <img width="1910" height="896" alt="image" src="https://github.com/user-attachments/assets/1c41732a-2fc2-4b06-8e59-2575de9297e4" />
|

## Resources

Supabase Flutter Documentation:
https://supabase.com/docs/guides/getting-started/flutter

supabase_flutter Package:
https://pub.dev/packages/supabase_flutter

Row Level Security Guide:
https://supabase.com/docs/guides/auth/row-level-security

## YouTube Search Terms

* Supabase Flutter tutorial
* Supabase authentication Flutter
* Supabase database Flutter
* Flutter Supabase complete guide

## Recommended Channels

* The Flutter Way
* Reso Coder
* Supabase Official

## Conclusion

Day 17 covered Supabase integration end-to-end — authentication (email/password, magic link, Google OAuth), database CRUD with Row Level Security, and real-time subscriptions. Unlike Day 16, the core blockers weren't project-naming or Gradle-config issues, but configuration mismatches across three separate surfaces that all had to agree: the Flutter app's initialization URL, Google Cloud Console's OAuth client settings, and Supabase's own redirect URL allow-list. None of these were Supabase or Flutter bugs — each was a specific, fixable misconfiguration (a wrong path suffix, a mismatched key, a missing redirect entry, a missing manifest intent-filter). The main lesson carried over from Day 16 still holds: an opaque failure (a 404, a redirect to `localhost`, "no API key found") is almost always traceable to one small, identifiable setting, not a framework-level failure. Final end-to-end verification against the checklist above is still pending.
