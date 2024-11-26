// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCIzA5bD0huEBYqy4iu54kh_C5uuzRAUTo',
    appId: '1:571209457708:web:58f65963310057e554f189',
    messagingSenderId: '571209457708',
    projectId: 'hr-managemenrt-429311',
    authDomain: 'hr-managemenrt-429311.firebaseapp.com',
    storageBucket: 'hr-managemenrt-429311.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCDH1usNAZ9bImdz4HXhtzBfcDXJk8tZJY',
    appId: '1:571209457708:android:71a845f3b040a4ff54f189',
    messagingSenderId: '571209457708',
    projectId: 'hr-managemenrt-429311',
    storageBucket: 'hr-managemenrt-429311.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA0UizMf2ZPSNHt1SytVdT8Gu4jHSwUGU4',
    appId: '1:571209457708:ios:15a13ee51b80567154f189',
    messagingSenderId: '571209457708',
    projectId: 'hr-managemenrt-429311',
    storageBucket: 'hr-managemenrt-429311.firebasestorage.app',
    iosClientId: '571209457708-6tglt6qmh4t5bofhbvgfdtgoi53uplge.apps.googleusercontent.com',
    iosBundleId: 'com.example.humanresoucemanagement',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA0UizMf2ZPSNHt1SytVdT8Gu4jHSwUGU4',
    appId: '1:571209457708:ios:15a13ee51b80567154f189',
    messagingSenderId: '571209457708',
    projectId: 'hr-managemenrt-429311',
    storageBucket: 'hr-managemenrt-429311.firebasestorage.app',
    iosClientId: '571209457708-6tglt6qmh4t5bofhbvgfdtgoi53uplge.apps.googleusercontent.com',
    iosBundleId: 'com.example.humanresoucemanagement',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCIzA5bD0huEBYqy4iu54kh_C5uuzRAUTo',
    appId: '1:571209457708:web:fd0261faaaeaa96254f189',
    messagingSenderId: '571209457708',
    projectId: 'hr-managemenrt-429311',
    authDomain: 'hr-managemenrt-429311.firebaseapp.com',
    storageBucket: 'hr-managemenrt-429311.firebasestorage.app',
  );

}