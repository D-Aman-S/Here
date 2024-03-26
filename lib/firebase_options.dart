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
    apiKey: 'AIzaSyCylBmC8_ZwYEB2jYqPNgZIajnKq7lcrQY',
    appId: '1:669721212063:web:92c9852ebf97c382f81eaa',
    messagingSenderId: '669721212063',
    projectId: 'weather-wizard-80410',
    authDomain: 'weather-wizard-80410.firebaseapp.com',
    databaseURL: 'https://weather-wizard-80410-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'weather-wizard-80410.appspot.com',
    measurementId: 'G-X2QMCJ8M4Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBapcNYi2yoxWrvVsFzK8JVXD-PQrDjFuw',
    appId: '1:669721212063:android:2ff153bf18542813f81eaa',
    messagingSenderId: '669721212063',
    projectId: 'weather-wizard-80410',
    databaseURL: 'https://weather-wizard-80410-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'weather-wizard-80410.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBs6rVL0YjDL0QuXVOglNXrIq4wy2v5OFc',
    appId: '1:669721212063:ios:414130fd3b5a3910f81eaa',
    messagingSenderId: '669721212063',
    projectId: 'weather-wizard-80410',
    databaseURL: 'https://weather-wizard-80410-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'weather-wizard-80410.appspot.com',
    iosClientId: '669721212063-mlbun4ct9q91aaqolf713dhi8krl0c4s.apps.googleusercontent.com',
    iosBundleId: 'com.aman.weatherwizard',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBs6rVL0YjDL0QuXVOglNXrIq4wy2v5OFc',
    appId: '1:669721212063:ios:414130fd3b5a3910f81eaa',
    messagingSenderId: '669721212063',
    projectId: 'weather-wizard-80410',
    databaseURL: 'https://weather-wizard-80410-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'weather-wizard-80410.appspot.com',
    iosClientId: '669721212063-mlbun4ct9q91aaqolf713dhi8krl0c4s.apps.googleusercontent.com',
    iosBundleId: 'com.aman.weatherwizard',
  );
}
