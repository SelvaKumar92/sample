# Restaurant Mobile App

This is the project for the new Wealthy mobile application.

## Getting Started

Open the project directory 'packages/wealthy' in Android Studio.

Retrieve the packages for the project using 'Tools -> Flutter -> Flutter Pub Get' or the following command.
```
flutter pub get
```

Run build runner to generate output file using third party package builders (json_serializable,
freezed, etc).

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

During local development build runner should be running in watch mode, so that generated output
files are recreated when changes are made.

```
flutter packages pub run build_runner watch --delete-conflicting-outputs
```

Set configuration for dart file main.dart or main_dev.dart as --flavor dev
```--flavor dev```

Set configuration for dart file main_prod.dart as --flavor prod
```--flavor prod```

Generating build for release in PlayStore

``` 
flutter build appbundle --flavor=prod -t lib/main_prod.dart
```

Generating build for release in AppStore

``` 
flutter build ipa --flavor=prod -t lib/main_prod.dart
```