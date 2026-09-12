# Day 9 - Flutter Animations

## Overview

Day 9 focused on Flutter's animation system, covering implicit animations, animation curves, explicit animations driven by AnimationController, Hero animations with custom flight paths, AnimatedBuilder, and applying all of it to build realistic animated UI screens.

The module covered pre-packaged implicit widgets (AnimatedContainer, AnimatedOpacity, AnimatedPositioned, AnimatedCrossFade, TweenAnimationBuilder), built-in and custom animation curves, explicit animation using AnimationController and Tween, Hero shared-element transitions with a custom flight path, and AnimatedBuilder for optimized, reusable animations — brought together in a login screen, a loading animation, custom page transitions, and an animated list.

## Learning Objectives

- Understand Flutter animations
- Create implicit animations
- Build explicit animations
- Custom transitions

## Topics Covered

### Implicit Animations

- AnimatedContainer
- AnimatedOpacity
- AnimatedPositioned
- AnimatedCrossFade
- TweenAnimationBuilder

### Animation Curves

- Curves.easeIn, Curves.easeOut
- Curves.bounceIn
- Custom curves

### Explicit Animations

- AnimationController
- Tween animations
- Animation listeners
- Dispose controllers

### Hero Animations

- Hero widget
- Tag matching
- Page transitions
- Custom flight paths

### AnimatedBuilder

- Optimize rebuilds
- Reusable animations
- Multiple widgets animated

### Animated UI

- Animated login screen
- Loading animations
- Page transitions
- List item animations

# Application Built

## Animation Practice App

A single app built to demonstrate the full set of animation patterns above, rather than separate apps per concept.

### Features

* Implicit animations screen — AnimatedContainer, AnimatedOpacity, AnimatedPositioned (inside a Stack), AnimatedCrossFade (Login/Register toggle), and TweenAnimationBuilder, using easeIn, easeOut, bounceIn, and a custom curve
* Explicit animations screen — an AnimationController driving a Tween through AnimatedBuilder, with controller disposal on screen exit
* Hero animation — two screens sharing a matching Hero tag, with a custom flight path via MaterialRectCenterArcTween instead of the default straight-line transition
* Animated login screen — logo, fields, and button staggered into view using Interval-based timing on a single controller
* Loading animation — a looping, pulsing spinner driven by AnimatedBuilder
* Custom page transitions — a fade + slide PageRouteBuilder used for every navigation from the home menu
* Animated list — items sliding/fading in on insert and out on removal, using AnimatedList

### Concepts

* AnimatedContainer, AnimatedOpacity, AnimatedPositioned, AnimatedCrossFade, TweenAnimationBuilder
* Curves.easeIn, Curves.easeOut, Curves.bounceIn, custom Curve subclass
* AnimationController, Tween, ColorTween, addListener, dispose
* Hero widget, tag matching, createRectTween for custom flight paths
* AnimatedBuilder for optimized rebuilds and multi-widget animation
* Interval-based staggered animation
* PageRouteBuilder for custom page transitions
* AnimatedList for list item insert/remove animations

# Key Learning

The main learning from Day 9 was the distinction between implicit and explicit animations, and when each is the right tool.

Implicit widgets (AnimatedContainer, AnimatedOpacity, etc.) only need a target value to change — Flutter interpolates automatically, with no controller to create or dispose. Explicit animations hand that control over: an AnimationController has to be created, started, listened to, and disposed manually, in exchange for the ability to drive multiple properties or widgets off a single timeline — as seen in the staggered login screen, where one controller is split into Intervals so the logo, fields, and button animate in sequence rather than all at once.

Hero animations surfaced a similar decision point: the default straight-line flight is enough for a simple shared-element transition, but overriding createRectTween with a built-in class like MaterialRectCenterArcTween shows how the same widget can be extended without hand-writing tween math.

# Screenshots

## Implicit Animations

### Before
<img width="279" height="598" alt="image" src="https://github.com/user-attachments/assets/5fbba5ca-ccec-4110-b72b-30ec6a5e3ed4" />
<img width="272" height="608" alt="image" src="https://github.com/user-attachments/assets/a2972110-40ce-4efe-87ab-c7fca3e74112" />

### After
<img width="277" height="603" alt="image" src="https://github.com/user-attachments/assets/fcc7777e-d7c5-4330-a39a-63ab183a77a3" />
<img width="273" height="605" alt="image" src="https://github.com/user-attachments/assets/63b747c1-23e1-4d01-b899-b0f9e2814409" />



## Explicit Animations
### Before
<img width="278" height="597" alt="image" src="https://github.com/user-attachments/assets/b38632f2-8dbb-4b56-acb8-0e023648f8ec" />

### After
<img width="272" height="608" alt="image" src="https://github.com/user-attachments/assets/3d79c612-1673-4e60-bc84-a3896ce7c7fd" />



## Hero Animation
### Before
<img width="270" height="604" alt="image" src="https://github.com/user-attachments/assets/5873ea9f-b08e-4a3e-9310-05ad7c350380" />
### After
<img width="273" height="604" alt="image" src="https://github.com/user-attachments/assets/1f84a1f3-b3ec-401b-a7ed-b5affbb313c3" />


## Animated Login Screen , Loading Animation , Animated List
<img width="272" height="593" alt="image" src="https://github.com/user-attachments/assets/49ed5c55-e433-41a1-afba-3dcf4ba850ab" />
<img width="268" height="597" alt="image" src="https://github.com/user-attachments/assets/4433634e-69de-480c-89d4-22712aecd9db" />
<img width="272" height="600" alt="image" src="https://github.com/user-attachments/assets/948f8ed3-1679-4d72-ac29-c32c4bebb226" />





# Repository Structure

```text
Day 9/
│
├── anim_app/
│   ├── lib/
│   │   ├── main.dart
│   │   ├── implicit_animations_screen.dart
│   │   ├── explicit_animations_screen.dart
│   │   ├── hero_screen_a.dart
│   │   ├── hero_screen_b.dart
│   │   ├── animated_login_screen.dart
│   │   ├── loading_animation_screen.dart
│   │   └── animated_list_screen.dart
│   └── README.md
└── README.md
```

# Resources

Flutter Animations Documentation:

[https://docs.flutter.dev/ui/animations](https://docs.flutter.dev/ui/animations)

## YouTube Search Terms

* Flutter animations tutorial
* Flutter implicit animations
* AnimatedContainer Flutter
* Hero animations Flutter
* Custom animations Flutter

## Recommended Channels

* Flutter Official
* Reso Coder
* Marcus Ng

# Conclusion

Day 9 provided practical experience with Flutter's animation system. Building a single app that combines implicit animations, explicit animations, Hero transitions with a custom flight path, AnimatedBuilder, and staggered UI animation reinforced how Flutter's animation framework separates "what changes" (Tweens, target values) from "what drives the change" (an AnimationController's ticking, or an implicit widget's own internal timer).
