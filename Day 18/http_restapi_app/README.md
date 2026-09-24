# Day 18 - Flutter REST API Integration

## Overview

Day 18 focused on **REST API integration** in Flutter — making HTTP requests, parsing JSON, handling errors, and managing loading states. The app, `rest_api_app`, consumes three public APIs (JSONPlaceholder, REST Countries, OpenWeatherMap) using the `http` package, with all requests, JSON models, and error handling built manually (no `json_serializable`, no state management library).

## Learning Objectives

* Make HTTP requests
* Handle JSON data
* Parse API responses
* Error handling
* Loading states

## Topics Covered

### Package Setup

* Installed `http` package via `pubspec.yaml` (`http: ^1.2.0`)
* `json_serializable` intentionally skipped — marked optional in the task, and manual `fromJson`/`toJson` was sufficient for this scope

### HTTP Methods

* GET — fetch posts list, fetch posts filtered by query parameter (`userId`), fetch countries, fetch weather
* POST — create a post
* PUT — full update of a post
* PATCH — partial update of a post
* DELETE — delete a post
* Headers (`Content-Type: application/json`) and query parameters (`Uri.replace(queryParameters: ...)`) used across requests

### JSON Handling

* `Post`, `UserModel`, and `WeatherModel` classes, each with `fromJson`/`toJson`
* Nested JSON parsing:
  * `UserModel.address` — nested object
  * `WeatherModel` — `main.temp` and `weather[0].description` (nested object + array)

### Error Handling

* `try-catch` around every API call
* HTTP status code checks (200, 201, 401, etc.) with explicit `Exception` messages
* Network error handling via `http.ClientException`
* Timeout handling via `.timeout(const Duration(seconds: 10))`

### Loading States

* `CircularProgressIndicator` shown while a request is in flight
* Data rendered in a `ListView` once loaded
* Error message + **Retry** button shown on failure, calling the same fetch method again
* State managed with a simple `isLoading` / `errorMessage` pair in a `StatefulWidget` — no external state management package used

### Public APIs Used

* **JSONPlaceholder** — posts CRUD (GET/POST/PUT/PATCH/DELETE)
* **REST Countries API** — country data (no key required)
* **OpenWeatherMap** — weather data (requires a free API key; used in place of News API)

News API was not implemented. OpenWeatherMap was used instead to satisfy the "public APIs" requirement without needing a slower, approval-based API key — REST Countries and JSONPlaceholder require no key at all, and OpenWeatherMap's free-tier key activates automatically (with a short delay), unlike NewsAPI.org's stricter free-tier restrictions.

## Application Built

### `rest_api_app`

## Features

* Post list screen with live search (filters by title as you type)
* Post detail screen (tap a post to view full title + body)
* Pull-to-refresh on the post list
* Loading indicator, error message, and retry button on failure
* Weather data fetch (`getWeather()`) implemented and console-tested; no dedicated UI screen built for it, per task scope

## Concepts Learned

### A response's status code, not just its body, tells you if a request actually succeeded

JSONPlaceholder is a mock API — POST, PUT, PATCH, and DELETE all return success-shaped responses without actually persisting anything. Checking `response.statusCode` (e.g. `201` for POST, `200` for PUT/PATCH/DELETE) is what confirms the request was sent and handled correctly, not just that no exception was thrown.

### Loading and error state need to live outside whatever widget you rebuild for a new feature

Adding search and pull-to-refresh initially replaced the `ListView` section that also contained the loading/error `Builder` logic, producing a blank screen with no spinner and no error message when a request was slow or failed. The fix was keeping the loading/error `Builder` wrapping the list, with the search field and `RefreshIndicator` layered around it rather than replacing it.

### A new free-tier API key is not instantly usable

A freshly created OpenWeatherMap key returned `401 Unauthorized` (surfaced in this app as "Invalid or inactive API key") immediately after signup — this is expected platform behavior, since free-tier keys can take up to two hours to activate, not a code or request issue.

## Important Issues Encountered

**Root causes, in the order they surfaced:**
1. Search + pull-to-refresh implementation initially dropped the loading/error state handling, causing a blank screen with no spinner or error message
2. Newly generated OpenWeatherMap API key returned `401` immediately after signup due to the platform's key-activation delay, not a code issue

Resolution: the blank-screen issue was fixed by wrapping the list (not replacing it) with the existing loading/error `Builder`; the API key issue resolved on its own after the activation delay passed.

## Current Verification Status

GET (post list) was confirmed working end-to-end, including loading and error states. **POST, PUT, PATCH, and DELETE were implemented but not individually console-tested. Search, pull-to-refresh, and tap-to-detail navigation were not individually confirmed. Weather API testing was pending key activation at time of writing.** Confirm the checklist below before treating Day 18 as complete.

## Final Verification Checklist

* [x] `flutter pub get` completes with no errors
* [x] GET request loads and displays the post list
* [ ] POST request returns status `201` (console-tested)
* [ ] PUT request returns status `200` (console-tested)
* [ ] PATCH request returns status `200` (console-tested)
* [ ] DELETE request returns status `200` (console-tested)
* [x] JSON parses correctly into `Post` model, including list parsing
* [x] Nested JSON parses correctly (`UserModel.address`)
* [x] Loading indicator shows while a request is in flight
* [x] Error message + Retry button show on failure (e.g. offline test)
* [ ] Retry button re-triggers the fetch successfully after a failure
* [ ] Tapping a post opens the detail screen with correct data
* [ ] Search field filters the list correctly by title
* [ ] Pull-to-refresh reloads the list
* [ ] Weather API returns real data once the key is active (console-tested)
* [x] REST Countries API returns data (country count checked)
* [x] No debug `print`/test calls left in `main.dart` in the final version

## Repository Structure

```text
Day 18/
│
├── rest_api_app/
│   ├── lib/
│   │   ├── main.dart
│   │   ├── models/
│   │   │   ├── post_model.dart
│   │   │   ├── user_model.dart
│   │   │   └── weather_model.dart
│   │   ├── services/
│   │   │   └── api_service.dart
│   │   └── screens/
│   │       ├── post_list_screen.dart
│   │       └── post_detail_screen.dart
│   ├── pubspec.yaml
│   └── README.md
└── README.md
```

## Screenshots

| Screen | Screenshot |
|---|---|
| Post list screen | <img width="300" height="669" alt="Screenshot 2026-09-24 130242" src="https://github.com/user-attachments/assets/fd713625-4d55-49c6-9faa-dab6ba434ac9" />|
| Post detail screen  | <img width="344" height="741" alt="image" src="https://github.com/user-attachments/assets/2c5ffd7b-ddfb-4780-901e-5965ccccabbb" />|
| Loading state | <img width="346" height="735" alt="image" src="https://github.com/user-attachments/assets/8bbe115e-ef21-41ce-9da3-ffd59e4b7041" />|
| Error + Retry state | <img width="344" height="757" alt="image" src="https://github.com/user-attachments/assets/44dc6b6c-e2d2-4900-9b9c-01a6b6e2d652" />|
| Search filtering | <img width="342" height="750" alt="image" src="https://github.com/user-attachments/assets/4b1a2aa7-1ec2-4e7b-9161-16e20e697083" />|

## Resources

http package documentation:
https://pub.dev/packages/http

JSONPlaceholder:
https://jsonplaceholder.typicode.com

REST Countries API:
https://restcountries.com

OpenWeatherMap API:
https://openweathermap.org/api

## YouTube Search Terms

* Flutter REST API tutorial
* HTTP requests Flutter
* Dio package Flutter
* JSON parsing Flutter
* API integration complete guide

## Recommended Channels

* Reso Coder
* The Flutter Way
* Marcus Ng

## Conclusion

Day 18 covered REST API integration in Flutter — HTTP methods (GET/POST/PUT/PATCH/DELETE), JSON parsing with nested objects, error handling (status codes, network errors, timeouts), and loading/error/retry UI states, across three public APIs. The main issue encountered was a scope mismatch when adding search and pull-to-refresh, which initially dropped the existing loading/error handling — a reminder that adding a new feature to an existing screen needs to wrap around prior logic, not silently replace it. The API key activation delay for OpenWeatherMap was expected platform behavior, not a bug. As with Day 17, individual pieces were built and partially tested as they were completed, but a full pass through every item on the verification checklist above — particularly the untested HTTP methods and UI interactions — is still pending before this can be marked fully complete.
