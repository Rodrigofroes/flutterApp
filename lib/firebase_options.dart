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
    apiKey: 'AIzaSyAoKJ9UlLHJzzM2xcByYatHNofaEQ2yUU4',
    appId: '1:650660459407:web:d9747d452098caa49291fa',
    messagingSenderId: '650660459407',
    projectId: 'projectlistdart',
    authDomain: 'projectlistdart.firebaseapp.com',
    databaseURL: 'https://projectlistdart-default-rtdb.firebaseio.com',
    storageBucket: 'projectlistdart.appspot.com',
    measurementId: 'G-S19BVKQV31',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCK9JHVdhqiGUE4k9AcAITZD1-DcEAdCwU',
    appId: '1:650660459407:android:109e33ee77e6da319291fa',
    messagingSenderId: '650660459407',
    projectId: 'projectlistdart',
    databaseURL: 'https://projectlistdart-default-rtdb.firebaseio.com',
    storageBucket: 'projectlistdart.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCkcrM_XQF1jmw8A_NGTNF2C5t45AWvIWU',
    appId: '1:650660459407:ios:4c142864a1de32429291fa',
    messagingSenderId: '650660459407',
    projectId: 'projectlistdart',
    databaseURL: 'https://projectlistdart-default-rtdb.firebaseio.com',
    storageBucket: 'projectlistdart.appspot.com',
    iosBundleId: 'com.example.projectapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCkcrM_XQF1jmw8A_NGTNF2C5t45AWvIWU',
    appId: '1:650660459407:ios:fd1d2bec626773949291fa',
    messagingSenderId: '650660459407',
    projectId: 'projectlistdart',
    databaseURL: 'https://projectlistdart-default-rtdb.firebaseio.com',
    storageBucket: 'projectlistdart.appspot.com',
    iosBundleId: 'com.example.projectapp.RunnerTests',
  );
}