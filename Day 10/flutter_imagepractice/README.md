# Day 10 - Flutter Image Handling

## Overview

Day 10 focused on Flutter's image handling tools, covering asset images, network images, cached network images, picking images from the gallery and camera, and applying it all to build a working image-based feature set.

The module covered Image.asset/Image.network/Image.file with the full set of BoxFit values, the image_picker package for gallery and camera selection with permission handling, cached_network_image for caching with a loading placeholder, error widget, and fade-in animation — brought together in a profile picture upload flow, a gallery grid, and a zoomable image viewer.

## Learning Objectives

- Handle images in Flutter
- Load network images
- Pick images from gallery and camera
- Display and cache images
- Use image packages

## Topics Covered

### Image Display

- Image.asset
- Image.network
- Image.file
- BoxFit (cover, contain, fill, fitWidth, fitHeight, none, scaleDown)

### Image Picker

- ImagePicker, ImageSource.gallery, ImageSource.camera
- Cancel handling
- Camera and gallery permissions

### Cached Network Images

- CachedNetworkImage
- Loading placeholder
- Error widget
- Fade-in animation

### Image Features

- Profile picture upload flow
- Preview before upload
- Gallery grid
- Zoomable image viewer

# Application Built

## Flutter Image Handling App

A single app built to demonstrate the full set of image handling patterns above, rather than separate apps per concept.

### Features

- Asset image comparison across all 7 BoxFit values, side by side in a scrollable row
- Plain Image.network demo and a CachedNetworkImage demo with placeholder, error widget, and fade-in
- Gallery and camera image picking via image_picker, with cancel handling on both paths
- Preview-before-upload dialog shown after picking, with Confirm/Cancel actions
- Profile picture rendered with a literal Image.file widget, clipped to a circle
- 6-tile gallery grid using CachedNetworkImage
- Zoomable full-screen image viewer (InteractiveViewer, 0.5x–4x) opened by tapping the profile picture, network image, or any grid tile

### Concepts

- Image.asset, Image.network, Image.file
- BoxFit values and their visual differences
- image_picker: ImageSource.gallery, ImageSource.camera, null-on-cancel handling
- Runtime permissions: camera only — Android 13+ gallery access uses the system Photo Picker and needs none
- CachedNetworkImage: imageUrl, placeholder, errorWidget, fadeInDuration
- Dialog-based preview/viewer flow instead of separate routed screens
- InteractiveViewer for pinch/drag zoom and pan

# Key Learning

The main learning from Day 10 was how narrow Dart's `const` rule actually is. `const NetworkImage(_networkImages[0])` failed to compile even though `_networkImages` was itself declared `const` — because the `[]` index operator is a runtime operation, not a compile-time constant expression, regardless of what it's indexing into. Only literals and const-constructor calls qualify; dropping the outer `const` fixed it.

A second, smaller learning was that hot reload only tracks code changes, not new files on disk — a newly added asset image showed a broken-image icon until the app was fully stopped and restarted, since Flutter builds its asset manifest at build time rather than watching the assets folder live.

# Screenshots

## Home Screen — Asset/BoxFit Row
<img width="408" height="882" alt="image" src="https://github.com/user-attachments/assets/1adaff98-7034-481a-98a8-3f55a5907821" />


## Home Screen — Network & Cached Image Demos
<img width="396" height="863" alt="image" src="https://github.com/user-attachments/assets/bb566710-23d2-44fe-b9f9-2682f5533822" />

## Profile Picture Flow — Preview Dialog
<img width="393" height="866" alt="image" src="https://github.com/user-attachments/assets/eca2454c-a4e9-4673-8cea-333a6896538b" />

## Profile Picture Flow — Confirmed
<img width="394" height="462" alt="image" src="https://github.com/user-attachments/assets/4ed4aa62-ff6a-4e6e-af84-6470a54a71f5" />


## Gallery Grid & Zoomed Viewer
<img width="410" height="317" alt="image" src="https://github.com/user-attachments/assets/3f2f0a30-a3c3-4e7f-ad34-33a3299d7e6f" />

<img width="402" height="873" alt="image" src="https://github.com/user-attachments/assets/94af3e75-82b0-4944-99d4-dd6bb655735c" />


# Repository Structure

```text
Day 10/
│
├── flutter_image_app/
│   ├── lib/
│   │   ├── main.dart
│   │   └── home_screen.dart
│   ├── assets/
│   │   └── images/
│   │       └── sample.jpg
│   └── README.md
└── README.md
```

# Resources

Flutter Image Handling Documentation:

[https://docs.flutter.dev/cookbook/images](https://docs.flutter.dev/cookbook/images)

## YouTube Search Terms

* Flutter image tutorial
* Image picker Flutter
* Cached network image Flutter
* Flutter camera plugin
* Display images Flutter

## Recommended Channels

* The Flutter Way
* Flutter Mapp
* Marcus Ng

# Conclusion

Day 10 provided practical experience with Flutter's image handling tools. Building a single app that combines asset/network/cached images, gallery and camera picking, a preview-before-upload flow, and a zoomable viewer reinforced how Flutter separates "where an image comes from" (asset, network, file) from "how it's cached and displayed" (BoxFit, CachedNetworkImage) — and surfaced a sharper understanding of what actually counts as a compile-time constant in Dart.
