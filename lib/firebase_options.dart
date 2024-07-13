// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDx6SsnLb4XiNsbYIyBalajf_RP-Xn50Js',
    appId: '1:424948448958:web:8e2dba1be08498162f68ef',
    messagingSenderId: '424948448958',
    projectId: 'hr-management-dbe1c',
    authDomain: 'hr-management-dbe1c.firebaseapp.com',
    storageBucket: 'hr-management-dbe1c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDwR9cCuOgUZz0jU3tPIKe07oT7T-PDgtA',
    appId: '1:424948448958:android:ea110bd5bd73a8e62f68ef',
    messagingSenderId: '424948448958',
    projectId: 'hr-management-dbe1c',
    storageBucket: 'hr-management-dbe1c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDKQGYjR4Ws9oYeB_5DJu7CUWCPC0mcoUg',
    appId: '1:424948448958:ios:55275b1585b44ac42f68ef',
    messagingSenderId: '424948448958',
    projectId: 'hr-management-dbe1c',
    storageBucket: 'hr-management-dbe1c.appspot.com',
    iosBundleId: 'com.example.humanresoucemanagement',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDKQGYjR4Ws9oYeB_5DJu7CUWCPC0mcoUg',
    appId: '1:424948448958:ios:3436179316736ad42f68ef',
    messagingSenderId: '424948448958',
    projectId: 'hr-management-dbe1c',
    storageBucket: 'hr-management-dbe1c.appspot.com',
    iosBundleId: 'com.example.humanresoucemanagement.RunnerTests',
  );
}
