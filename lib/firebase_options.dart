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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyC0B-7tldu0VeWGXH8RD4O_Q7sdWlQbHOE',
    appId: '1:713767043479:web:c41cd46db2e988492144d2',
    messagingSenderId: '713767043479',
    projectId: 'flutter-chat-app-85497',
    authDomain: 'flutter-chat-app-85497.firebaseapp.com',
    storageBucket: 'flutter-chat-app-85497.appspot.com',
    measurementId: 'G-4X8ZMN0L2Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBNaWX8FrlfD5Yc4bSJAI9k_wZGFVqrA-k',
    appId: '1:713767043479:android:a93f703d6da1d6ac2144d2',
    messagingSenderId: '713767043479',
    projectId: 'flutter-chat-app-85497',
    storageBucket: 'flutter-chat-app-85497.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCGfeVeHMDZFo-LOLCO1s28FWD5wW2kSpY',
    appId: '1:713767043479:ios:1bdc28e10cd5ad782144d2',
    messagingSenderId: '713767043479',
    projectId: 'flutter-chat-app-85497',
    storageBucket: 'flutter-chat-app-85497.appspot.com',
    iosClientId: '713767043479-8gvvmb7oqrcknmgmlns8vhmcd41u5kpd.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );
}
