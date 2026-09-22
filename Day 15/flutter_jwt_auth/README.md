# Day 15 - Flutter JWT Authentication

## Overview

Day 15 focused on implementing **JWT-based authentication** in Flutter — login, registration, secure token storage, protected routes, and auto-login on app restart. A new app (`flutter_jwt_auth`) was built with a Splash → Login/Register → Home flow, backed by `flutter_secure_storage` for token persistence and a custom `ApiService` handling authenticated requests with a refresh-token retry pattern.

DummyJSON was used as the backend for this task, since no production API was specified in the task brief.

## Learning Objectives

* Understand JWT authentication
* Setup API integration
* Handle authentication flow
* Store tokens securely

## Topics Covered

### JWT Fundamentals

* JWT structure: `header.payload.signature` (signed, not encrypted)
* Access token vs refresh token — short-lived vs long-lived
* Why tokens must go in secure storage, not SharedPreferences
* Full auth flow: login → store tokens → attach token to requests → refresh on expiry → logout clears tokens

### API Client

* `ApiService` class with base URL configuration
* Header management (`Content-Type`, `Authorization: Bearer <token>`)
* Centralized error handling via a custom `ApiException`
* Interceptor-style pattern: `_sendWithAuth()` wraps authenticated calls, catches 401, calls `/auth/refresh`, retries once

### Authentication Logic

* `login()` — calls `/auth/login`, stores `accessToken` + `refreshToken`
* `register()` — calls `/auth/register` with client-side form validation
* `isLoggedIn()` — checks for a stored access token
* `logout()` — deletes both tokens from secure storage

### Screens

* Splash screen — checks auth state on launch, routes to Login or Home
* Login screen — email/password fields, error display, loading state
* Register screen — form validation (name, email format, password length)
* Home screen — protected route, logout action in AppBar

## Application Built

### `flutter_jwt_auth`

## Features

* Login against a live API (DummyJSON), with real JWTs (verified signature structure, `iat`/`exp` claims)
* Secure token storage via `flutter_secure_storage`
* Splash-screen auth check with auto-login on app restart
* Logout clears both tokens and returns to Login
* Authenticated request wrapper with automatic refresh-token retry on 401
* Registration screen with full client-side validation

## Concepts Learned

### JWTs are signed, not encrypted

Decoding the DummyJSON access token's payload showed the raw user data (`id`, `username`, `email`, `iat`, `exp`) in plain, readable base64 — confirming a JWT protects against tampering (via signature), not against reading.

### PowerShell curl is not real curl

`curl` in PowerShell is aliased to `Invoke-WebRequest`, which doesn't accept bash-style flags (`-X`, `-H`, `-d`) or line continuations (`\`). Used `Invoke-RestMethod` instead to test the raw API before wiring it into Flutter — testing the endpoint directly first (before touching app code) caught the field-name assumptions early.

### A mock API can silently redefine "done"

Assumed `/auth/register` existed because it was a natural pairing with `/auth/login`. It doesn't — DummyJSON's auth module only exposes `/auth/login`, `/auth/me`, and `/auth/refresh`. Calling `/auth/register` returns `"Access Token is required"`, meaning it's a protected route, not a public signup endpoint. This wasn't discoverable by guessing — it took checking the actual DummyJSON docs.

## Important Issue Encountered

**Task requires "Register API call" + "Auto-login after register." DummyJSON cannot fulfill this.**

Root cause: DummyJSON has no public registration endpoint. `/auth/register` is protected and returns an error instead of tokens; `/users/add` (the only user-creation endpoint that exists) doesn't return `accessToken`/`refreshToken` at all, since it doesn't actually persist a new account.

Resolution: registration UI and validation were built and tested against the form logic only (empty name, invalid email, short password all correctly block submission). The live API call and "auto-login after register" behavior are implemented in code but structurally cannot succeed against this mock API — there's no token to auto-login with. This is a limitation of the test API, not a bug in the implementation, and would work unmodified against a real backend that returns tokens on registration.

## Current Verification Status

Login, kill-and-reopen auto-login, logout, and wrong-password error handling were reported as tested and working. These were **not independently re-verified step-by-step in this conversation** — confirm the checklist below yourself before treating Day 15 as fully closed, particularly the refresh-token retry, which has not been exercised at all (it requires a genuinely expired token to trigger, which wasn't forced during testing).

## Final Verification Checklist

* [ ] Run `flutter pub get`
* [ ] Fresh install (no stored tokens) → app opens on Splash → routes to Login
* [ ] Log in with `emilys` / `emilyspass` → navigates to Home
* [ ] Try a wrong password → error message displays, no navigation
* [ ] Force-close the app (not just background it) and reopen → Splash → straight to Home, no login prompt
* [ ] Tap logout → returns to Login
* [ ] Force-close and reopen after logout → Splash → routes to Login (not Home)
* [ ] Register screen: submit empty fields → validation errors show, no API call made
* [ ] Register screen: submit invalid email → validation error shows
* [ ] Register screen: submit valid data → API call attempted, fails with "Access Token is required" (expected, documented above)
* [ ] Refresh-token logic — not yet tested; would require forcing an access token to expire (e.g. via `expiresInMins: 1` on login) and confirming a subsequent authenticated call triggers `/auth/refresh` and retries successfully

## Repository Structure

```text
Day 15/
│
├── flutter_jwt_auth/
│   ├── lib/
│   │   ├── main.dart
│   │   ├── services/
│   │   │   ├── api_service.dart
│   │   │   └── auth_service.dart
│   │   └── screens/
│   │       ├── splash_screen.dart
│   │       ├── login_screen.dart
│   │       ├── register_screen.dart
│   │       └── home_screen.dart
│   ├── pubspec.yaml
│   └── README.md
└── README.md
```

## Resources

DummyJSON Auth Documentation:
https://dummyjson.com/docs/auth

flutter_secure_storage Package:
https://pub.dev/packages/flutter_secure_storage

## YouTube Search Terms

* Flutter authentication tutorial
* JWT authentication Flutter
* Flutter login system
* API integration Flutter
* Flutter secure storage

## Recommended Channels

* Reso Coder
* The Flutter Way
* Marcus Ng

## Conclusion

Day 15 provided practical experience with JWT authentication in Flutter — token structure, secure storage, an authenticated-request wrapper with refresh-retry logic, and a full Splash → Login/Register → Home flow.

The module also surfaced a real constraint worth remembering: a task's requirements can outrun what a chosen mock API actually supports. DummyJSON's missing public register endpoint made "auto-login after register" structurally impossible to demonstrate live, which is a limitation of the test environment, not the implementation — and it's the kind of gap that's only found by checking a dependency's actual docs rather than assuming symmetry (login exists, so register must too). Final end-to-end re-verification against the checklist above is still pending.
