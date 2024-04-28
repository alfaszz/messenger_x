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
    apiKey: 'AIzaSyBCwQB3UQag381BXyrKD7UzKTWP6LS9ufg',
    appId: '1:654702114524:web:c3c4deead07e1053fc6619',
    messagingSenderId: '654702114524',
    projectId: 'messengerx11',
    authDomain: 'messengerx11.firebaseapp.com',
    storageBucket: 'messengerx11.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAXVWsS6QlEnqYEjo0UOgZCq_QU3gF0L-Y',
    appId: '1:654702114524:android:88fe9b0bcd87d66afc6619',
    messagingSenderId: '654702114524',
    projectId: 'messengerx11',
    storageBucket: 'messengerx11.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAhkAHul1Kp7TxpsZ5XnrMFsUsGmfRGldI',
    appId: '1:654702114524:ios:56ee3948f456a21ffc6619',
    messagingSenderId: '654702114524',
    projectId: 'messengerx11',
    storageBucket: 'messengerx11.appspot.com',
    iosBundleId: 'com.example.messengerx',
  );
}