## Day 21 — Flutter Packages and GetX

## Overview

Day 21 focused on **popular Flutter packages** — GetX, Freezed, Go Router, Dio and Hive — plus four utility packages (`intl`, `url_launcher`, `share_plus`, `connectivity_plus`). One app (`packages_app`) uses all 9 packages together. It loads posts from JSONPlaceholder, lets the user save favorites offline, and has a Tools page for the utility packages. A separate standalone GetX demo shows GetX state management, navigation and dependency injection.

## Learning Objectives

* Explore popular Flutter packages
* Learn GetX framework
* Use utility packages
* Implement common features

## Topics Covered

### Package Setup

* Installed `get`, `freezed_annotation`, `json_annotation`, `go_router`, `dio`, `hive`, `hive_flutter`, `intl`, `url_launcher`, `share_plus` and `connectivity_plus`
* Installed dev tools for code generation: `freezed`, `json_serializable`, `go_router_builder`, `build_runner`
* `hive_flutter` was added because plain `hive` needs it to find a storage folder on a phone
* Tutorials watched: about 3 hours (GetX, Dio and Hive, Freezed and Go Router)

### Package 1: GetX

* **State management** — `.obs` values with `Obx` rebuild only the widget that reads the value
* **Navigation** — `Get.toNamed` and `Get.back`, shown in the standalone demo
* **Dependency injection** — `Get.put` creates a controller once, `Get.find` gets the same one from any screen
* **When to use GetX** — small and medium apps, prototypes, learning projects. Be careful in large long-term apps because of slow maintenance and because it mixes state, navigation and DI in one package

### Package 2: Freezed

* **Immutable classes** — `Post` cannot be changed; `copyWith` makes a new copy
* **Union types** — `PostsState` is exactly one of loading, success or error, and the compiler checks that all three are handled
* **JSON serialization** — `Post.fromJson` and `post.toJson()` are generated

### Package 3: Go Router

* **Declarative routing** — all routes are declared in one list (`$appRoutes`)
* **Deep linking** — the path `/post/3` opens Post 3 from outside the app
* **Typed routes** — `PostDetailRoute(id: 3).push(context)` uses a real `int`, with no path strings to mistype

### Package 4: Dio

* **Interceptors** — log every request, response and error, and add a header to every request
* **File downloads** — `dio.download` saves a file and reports received bytes
* **Request cancellation** — `CancelToken` stops a running download
* **Better than `http`** — interceptors, downloads, cancellation and shared timeouts are built in

### Package 5: Hive

* **Box concept** — a named container of key-value pairs; the `favorites` box holds saved posts
* **CRUD** — create and update with `put`, read with `values`, delete with `delete`
* **Fast and lightweight vs SQLite** — no SQL and no setup, but no joins or filters either

### Utility Packages

* `intl` — same date shown in English and Malayalam, plus a rupee amount with Indian grouping
* `url_launcher` — opens a website in the phone browser
* `share_plus` — opens the share sheet from a post
* `connectivity_plus` — shows an offline banner and an Online/Offline status

## Application Built

### packages_app (Posts app using 9 packages)

## Features

* `HomePage` — post list from the API, heart icon to favorite a post, offline banner
* `PostDetailPage` — full post with a Share button, reachable by deep link
* `FavoritesPage` — Hive favorites with edit title and delete
* `ToolsPage` — `intl`, `url_launcher`, connectivity status, and Dio download with Cancel
* Standalone GetX demo — counter with GetX state, GetX navigation and dependency injection

## Concepts Learned

### GetX and Go Router both control navigation

Using both for navigation in one app causes conflicts. In the final app, Go Router handles navigation and GetX handles state and dependency injection only. GetX navigation is shown in the standalone demo.

### Freezed and Go Router typed routes need generated code

Nothing compiles until `build_runner` creates the `.freezed.dart`, `.g.dart` and `routes.g.dart` files.

### Connectivity is not the same as internet access

`connectivity_plus` reports whether the phone is on Wi-Fi, mobile data or offline. A Wi-Fi network with no internet still counts as connected.

### Dio cancellation is proven by the app state, not the console

The console showed the download request but no cancel line. The Tools page status changing to `Cancelled` is the evidence used.

## Important Issues Encountered

**Root cause, in the order it surfaced:**
1. Red errors in `posts_state.dart`, `post.dart` and `routes.dart` — the generated files did not exist yet. Fixed by running `dart run build_runner build --delete-conflicting-outputs`.
2. The app kept showing the Step 1 counter screen — the run target was still `main_getx_demo.dart`, and hot reload does not change the entry point. Fixed by selecting `main.dart` and restarting the app.
3. Unclear whether cancellation worked — the console showed no cancel line, so the download was retested and the status `Cancelled` appeared in the app.

## Current Verification Status

Tested on the Pixel 7 API 34 emulator.

**Confirmed with a screenshot or console output:**
* Freezed — console printed `a.title=A, b.title=Changed` and `equal? true`
* Dio and interceptor — console printed `-->` and `<--` lines for the requests
* Post list loaded from the API
* Hive favorites list showing saved posts
* `intl` — English date, Malayalam date and `₹12,34,567.50`
* Dio download — file saved as `photos.json`
* `connectivity_plus` — status showed Online

**Confirmed by manual test, no saved screenshot yet:**
* Hive edit, delete, and favorites surviving a full app restart
* Go Router deep link `myapp://packages/post/3`
* Dio request cancellation (status `Cancelled`)
* `url_launcher` opening the browser
* `share_plus` opening the share sheet
* Offline banner in airplane mode

## Final Verification Checklist

### Learning Objectives
* [x] Explore popular Flutter packages
* [x] Learn GetX framework
* [x] Use utility packages
* [x] Implement common features

### Watch
* [x] Package tutorials (3 hours) — user-reported complete, not independently verifiable

### Package 1: GetX
* [x] Install `get` package
* [x] State management with GetX
* [x] Navigation with GetX
* [x] Dependency injection
* [x] When to use GetX

### Package 2: Freezed
* [x] Install `freezed` package
* [x] Generate immutable classes
* [x] Union types
* [x] JSON serialization

### Package 3: Go Router
* [x] Install `go_router`
* [x] Declarative routing
* [x] Deep linking
* [x] Typed routes

### Package 4: Dio
* [x] Install `dio`
* [x] Interceptors
* [x] File downloads
* [x] Request cancellation
* [x] Better than `http` package

### Package 5: Hive
* [x] Install `hive`
* [x] Box concept
* [x] CRUD operations
* [x] Fast and lightweight vs SQLite

### Utility Packages
* [x] `intl` — internationalization
* [x] `url_launcher` — open URLs
* [x] `share_plus` — share content
* [x] `connectivity_plus` — network status

### Build App
* [x] Use 3+ packages in one app
* [x] Demonstrate each package
* [x] Compare with alternatives

### Deliverables
* [x] App using multiple packages
* [x] GetX example
* [x] Dio HTTP client
* [x] Hive database example
* [x] Package comparison document written (`COMPARISON.md`)
* [x] README with package recommendations written

## Package Recommendations

| Package | Recommended when | Avoid or use an alternative when |
|---|---|---|
| `get` | Small and medium apps, prototypes, learning | Large long-term apps (slow maintenance, mixes many jobs) |
| `freezed` | Several data classes, union states, JSON | One or two tiny classes |
| `go_router` | Many screens, deep links, typed parameters | An app with 2–3 screens and no deep links |
| `dio` | Interceptors, downloads, cancellation | One or two simple GET calls (`http` is enough) |
| `hive` | Favorites, settings, small caches | Related or searchable data (use SQLite); Hive is no longer actively developed and its fork `hive_ce` is maintained |
| `intl` | Showing dates, numbers or currency to users in different regions | — |
| `url_launcher` | Opening links, calls or email | — |
| `share_plus` | Any share button | — |
| `connectivity_plus` | Showing offline state | Proving the internet works (it only reports the connection type) |

See `COMPARISON.md` for the full comparison with alternatives.

## Setup

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run -t lib/main.dart
```

Run the standalone GetX demo:

```bash
flutter run -t lib/getx_demo/main_getx_demo.dart
```

Test the deep link (Android):

```bash
adb shell am start -a android.intent.action.VIEW -d "myapp://packages/post/3"
```

## Repository Structure

```text
 21/
│
├── lib/
│   ├── main.dart
│   ├── routes.dart
│   ├── routes.g.dart
│   ├── controllers/
│   │   ├── download_controller.dart
│   │   ├── favorites_controller.dart
│   │   ├── network_controller.dart
│   │   └── posts_controller.dart
│   ├── getx_demo/
│   │   ├── counter_controller.dart
│   │   ├── home_page.dart
│   │   ├── main_getx_demo.dart
│   │   └── second_page.dart
│   ├── models/
│   │   ├── post.dart
│   │   └── posts_state.dart
│   ├── pages/
│   │   ├── favorites_page.dart
│   │   ├── home_page.dart
│   │   ├── post_detail_page.dart
│   │   └── tools_page.dart
│   └── services/
│       └── dio_client.dart
├── android/app/src/main/AndroidManifest.xml
├── pubspec.yaml
├── COMPARISON.md
└── README.md
```

Generated files (`*.freezed.dart`, `*.g.dart`) are also in `lib/` and can be recreated with `build_runner`.

## Resources

* https://pub.dev/packages/get
* https://pub.dev/packages/freezed
* https://pub.dev/packages/go_router
* https://pub.dev/packages/dio
* https://pub.dev/packages/hive
* https://pub.dev/packages/intl
* https://pub.dev/packages/url_launcher
* https://pub.dev/packages/share_plus
* https://pub.dev/packages/connectivity_plus

## YouTube Search Terms

* Flutter GetX tutorial
* Best Flutter packages 2024
* Flutter useful packages
* GetX state management
* Flutter package recommendations

## Recommended Channels

* The Flutter Way
* Reso Coder
* Marcus Ng

## Conclusion

 21 covered five popular Flutter packages (GetX, Freezed, Go Router, Dio, Hive) and four utility packages (`intl`, `url_launcher`, `share_plus`, `connectivity_plus`), all used together in one app. Go Router handles navigation and GetX handles state and dependency injection, because using both for navigation conflicts. The main lessons were that generated code must exist before anything compiles, that a running app is not proof that a feature works, and that a cancelled Dio request is proven by the app state rather than the console. Every package was tested on the emulator; the items in the second verification list still need saved screenshots before submission.
