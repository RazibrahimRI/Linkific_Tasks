# Day 11 - Flutter Permissions

## Overview

Day 11 focused on Flutter's runtime permission system, covering how Android and iOS gate access to sensitive features, how to check and request permissions using the permission_handler package, and how to handle every possible outcome of a request.

The module covered checking permission status, requesting single and multiple permissions, configuring Android's manifest and iOS's usage descriptions, and building complete request flows for camera, location, and storage — including a rationale dialog and an open-settings path for permanently denied permissions.

## Learning Objectives

- Understand Android/iOS permissions
- Request permissions at runtime
- Handle permission results
- Check permission status

## Topics Covered

### Permission Types

- Camera
- Gallery/Photos
- Location
- Storage
- Microphone
- Contacts

### Platform Configuration

- AndroidManifest.xml — required and optional permission declarations
- Info.plist — usage description strings (NSCameraUsageDescription, etc.)

### Requesting Permissions

- Permission.status — checking current state
- Permission.request() — single permission
- List<Permission>.request() — multiple permissions at once

### Handling Results

- Granted — proceed with the feature
- Denied — show a message
- Permanently denied — open app settings
- Rationale dialogs before requesting

# Application Built

## Flutter Permissions Demo App

A single app built to demonstrate the full permission-handling lifecycle above, rather than separate apps per permission type.

### Features

- Single-screen layout with three buttons: Camera, Location, Storage
- Camera flow includes a rationale dialog, shown via shouldShowRequestRationale before the system prompt appears
- Each flow checks status, requests the permission, and branches on the result
- Denied permissions show a SnackBar message
- Permanently denied permissions open a dialog with a button that calls openAppSettings()
- Storage flow requests Permission.photos on Android, to account for Android 13+ deprecating Permission.storage for media access

### Concepts

- Permission.camera, Permission.location, Permission.photos/Permission.storage
- shouldShowRequestRationale and platform-specific rationale behavior
- isGranted, isDenied, isPermanentlyDenied result branching
- openAppSettings() for permanently denied permissions
- AndroidManifest.xml permission declarations vs. Info.plist usage descriptions
- Why a single permission_handler enum doesn't always map to the same real permission across Android versions

# Key Learning

The main learning from Day 11 was that a permission_handler enum isn't a fixed mapping to one Android permission forever — `Permission.storage` is deprecated on Android 13 (API 33) and above, and the OS denies it silently, with no dialog ever shown to the user. This isn't a bug in the request code; it's the platform enforcing its newer, narrower media-access model (`READ_MEDIA_IMAGES` / the system Photo Picker) instead of broad storage access. The fix was requesting `Permission.photos` on Android rather than `Permission.storage`, which correctly triggers the system prompt.

A second, smaller learning was that `shouldShowRequestRationale` is Android-only — iOS has no equivalent, since the OS itself decides when and whether to show its own permission-education UI, so a rationale dialog gated on that check simply never appears on iOS, by design rather than by omission.

# Screenshots

## Home Screen — Camera / Location / Storage buttons
<img width="334" height="745" alt="image" src="https://github.com/user-attachments/assets/924f8d0e-e103-4eab-b9e5-3d4b483d1c2a" />

## Granted message
<img width="348" height="754" alt="image" src="https://github.com/user-attachments/assets/03507c0f-483b-4867-b818-ce42a6b394aa" />

## Permanently Denied message

<img width="346" height="757" alt="image" src="https://github.com/user-attachments/assets/900674d3-9a92-409b-aa3c-cc2e21d85fd0" />


# Repository Structure

```text
Day 11/
│
├── permissions_demo/
│   ├── lib/
│   │   └── main.dart
│   ├── android/
│   │   └── app/src/main/AndroidManifest.xml
│   ├── ios/
│   │   └── Runner/Info.plist
│   └── README.md
└── README.md
```

# Resources

Flutter Permissions Package Documentation:

[https://pub.dev/packages/permission_handler](https://pub.dev/packages/permission_handler)

## YouTube Search Terms

* Flutter permissions tutorial
* Permission handler Flutter
* Android permissions Flutter
* iOS permissions Flutter
* Runtime permissions Flutter

## Recommended Channels

* Flutter Explained
* Reso Coder
* The Flutter Way

# Conclusion

Day 11 provided practical experience with Flutter's runtime permission system. Building a single app that covers status checking, single and multiple permission requests, rationale dialogs, and every possible result state — granted, denied, and permanently denied — reinforced that permission handling isn't just "ask once and branch on yes/no." It surfaced platform-specific behavior (Android's rationale flag, iOS's mandatory usage strings) and a concrete case of a package-level permission going stale against a newer OS version, requiring the request itself to be updated rather than just the handling around it.
