# Package Comparison

## Summary table

| Package | Alternative compared | Use the package when | Use the alternative when |
|---|---|---|---|
| GetX (`get`) | `setState` (built into Flutter) | State is shared across many screens; you want easy dependency injection | State belongs to one widget only |
| Freezed (`freezed`) | Hand-written classes | Many data classes; you need copyWith, equality, JSON, union types | One or two tiny classes |
| Go Router (`go_router`) | `Navigator.push` (built into Flutter) | Many screens, deep links, typed params | An app with 2-3 screens and no deep links |
| Dio (`dio`) | `http` package | Interceptors, downloads with progress, cancellation, timeouts | One or two simple GET calls |
| Hive (`hive`) | SQLite (`sqflite`) | Simple key-value data, fast setup, no SQL | Related data, joins, filters, sorting |

## GetX vs setState
- setState only rebuilds one widget and its state cannot be reached from other screens.
- GetX controllers can be found from any screen with Get.find, and Obx rebuilds only the widgets that read a changed value.
- Risk: GetX combines state, navigation and dependency injection in one package, and its maintenance has been slow. Prefer it for small and medium apps and learning projects.
- In this app GetX is used for state and dependency injection only. Navigation is handled by go_router because using both for navigation causes conflicts.

## Freezed vs hand-written classes
- A hand-written class needs constructor, ==, hashCode, copyWith, toString and fromJson/toJson written by hand.
- Freezed generates all of these and adds union types (loading / success / error) that the compiler checks.
- Cost: needs build_runner and generated files, and adds build time.

## Go Router vs Navigator.push
- Navigator.push works well for simple flows but has no URL or path system.
- go_router declares all routes in one place, supports deep links (myapp://packages/post/3), and typed routes remove path-string mistakes.
- Cost: typed routes need go_router_builder and generated code.

## Dio vs http
| Feature | Dio | http |
|---|---|---|
| Interceptors | Built in | Not available |
| File download with progress | dio.download | Write it yourself |
| Cancel a request | CancelToken | Not available |
| Base URL and timeouts | Set once in BaseOptions | Repeat on every call |
| Size and simplicity | Larger | Smaller, simpler |

## Hive vs SQLite
| Feature | Hive | SQLite |
|---|---|---|
| Data shape | Key-value boxes | Tables with rows and columns |
| Setup | Open a box and use it | Create tables, write SQL |
| Queries | Loop through values in Dart | WHERE, ORDER BY, JOIN |
| Relations between data | Not supported | Supported |
| Best for | Favorites, settings, small caches | Structured, related, searchable data |
- Note: Hive is no longer actively developed. Its fork hive_ce is the maintained option.

## Utility packages
- intl: formats dates and numbers per locale.
- url_launcher: opens links outside the app.
- share_plus: opens the system share sheet.
- connectivity_plus: reports Wi-Fi / mobile / offline. It does not prove the internet works.
