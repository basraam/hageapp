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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBmhtS45WtDixKE0heGXPfgFKObuuJDDw8',
    appId: '1:245713703227:android:ee23f7ca8cf99a9763271e',
    messagingSenderId: '245713703227',
    projectId: 'hage-1a64a',
    storageBucket: 'hage-1a64a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA1cngC3tGWJ_vIa4io3axkXxis4DA6bl4',
    appId: '1:245713703227:ios:373a13805276c29563271e',
    messagingSenderId: '245713703227',
    projectId: 'hage-1a64a',
    storageBucket: 'hage-1a64a.appspot.com',
    iosClientId: '245713703227-u32jgh2v001jb0bgd550oq4s9os8vna6.apps.googleusercontent.com',
    iosBundleId: 'com.example.hageMobileApp',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAc1LptRfugB-AS3NKAOWL0CQ-86CuzvQg',
    appId: '1:245713703227:web:6636077ba609879d63271e',
    messagingSenderId: '245713703227',
    projectId: 'hage-1a64a',
    authDomain: 'hage-1a64a.firebaseapp.com',
    storageBucket: 'hage-1a64a.appspot.com',
    measurementId: 'G-KDS8M4EKQF',
  );

}