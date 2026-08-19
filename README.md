# EES Calculator

A cross-platform Flutter calculator for electrical-material estimates and project cost calculations.

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white)](https://dart.dev/)

## Overview

EES Calculator is a Flutter application built for electrical-material estimation workflows. The project includes a structured frontend/backend codebase and Firebase integration for authentication, Firestore data, and storage.

> A public live deployment is not currently available. The project includes a recorded walkthrough below.

## Demo

[Watch the application walkthrough](https://github.com/user-attachments/assets/145096f1-e5c6-4dc3-b659-91528bd4b84f)

## Technology

- Flutter and Dart
- Firebase Authentication
- Cloud Firestore
- Firebase Storage
- Cross-platform targets: Android, iOS, web, Windows, macOS, and Linux

## Run locally

1. Install [Flutter](https://docs.flutter.dev/get-started/install).
2. Clone the repository:
   ```bash
   git clone https://github.com/Nardy11/eesCalculator.git
   cd eesCalculator
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Configure the Firebase project for your target platform.
5. Run the application:
   ```bash
   flutter run
   ```

## Project structure

- `lib/Front End` — application screens and user interface
- `lib/Back End` — application services and data access
- `lib/firebase_options.dart` — generated Firebase platform configuration
- `test/` — Flutter test directory

## Status

This is an educational/product prototype and is not presented as a certified electrical or engineering calculator.

