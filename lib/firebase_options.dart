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
    apiKey: 'AIzaSyBRqSbc5WIYH-gXP42vjQu6Owhoopd_0J0',
    appId: '1:321352161067:web:30ced0e67812a408a7176e',
    messagingSenderId: '321352161067',
    projectId: 'eescalculator-df5ef',
    authDomain: 'eescalculator-df5ef.firebaseapp.com',
    databaseURL: 'https://eescalculator-df5ef-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'eescalculator-df5ef.firebasestorage.app',
    measurementId: 'G-Z4X9DYMKRF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA3WEwEXguOltp6TbZB_w0j62TVMIzkR_M',
    appId: '1:321352161067:android:fba3482be05b6609a7176e',
    messagingSenderId: '321352161067',
    projectId: 'eescalculator-df5ef',
    databaseURL: 'https://eescalculator-df5ef-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'eescalculator-df5ef.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCRPKbXq_HfGgPCn6WbW0WhxQe3qdFlCq8',
    appId: '1:321352161067:ios:39004a253ff63c42a7176e',
    messagingSenderId: '321352161067',
    projectId: 'eescalculator-df5ef',
    databaseURL: 'https://eescalculator-df5ef-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'eescalculator-df5ef.firebasestorage.app',
    iosBundleId: 'com.example.eesCalculator',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCRPKbXq_HfGgPCn6WbW0WhxQe3qdFlCq8',
    appId: '1:321352161067:ios:39004a253ff63c42a7176e',
    messagingSenderId: '321352161067',
    projectId: 'eescalculator-df5ef',
    databaseURL: 'https://eescalculator-df5ef-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'eescalculator-df5ef.firebasestorage.app',
    iosBundleId: 'com.example.eesCalculator',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBRqSbc5WIYH-gXP42vjQu6Owhoopd_0J0',
    appId: '1:321352161067:web:c423f0a1087a77a0a7176e',
    messagingSenderId: '321352161067',
    projectId: 'eescalculator-df5ef',
    authDomain: 'eescalculator-df5ef.firebaseapp.com',
    databaseURL: 'https://eescalculator-df5ef-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'eescalculator-df5ef.firebasestorage.app',
    measurementId: 'G-S9R7RKK40P',
  );

}