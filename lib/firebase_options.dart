import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDXmAT5fdeFokrKe3r7rerL0GGLziAYkd0',
    authDomain: 'durable-sound-463120.firebaseapp.com',
    databaseURL:
        'https://durable-sound-463120-v8-default-rtdb.europe-west1.firebasedatabase.app/',
    projectId: 'durable-sound-463120',
    storageBucket: 'durable-sound-463120-v8.firebasestorage.app',
    messagingSenderId: '204320277724',
    appId: '1:204320277724:web:237b5a30c0f99db2af6019',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDXmAT5fdeFokrKe3r7rerL0GGLziAYkd0',
    authDomain: 'durable-sound-463120.firebaseapp.com',
    databaseURL:
        'https://durable-sound-463120-v8-default-rtdb.europe-west1.firebasedatabase.app/',
    projectId: 'durable-sound-463120',
    storageBucket: 'durable-sound-463120-v8.firebasestorage.app',
    messagingSenderId: '204320277724',
    appId: '1:204320277724:android:237b5a30c0f99db2af6019',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDXmAT5fdeFokrKe3r7rerL0GGLziAYkd0',
    authDomain: 'durable-sound-463120.firebaseapp.com',
    databaseURL:
        'https://durable-sound-463120-v8-default-rtdb.europe-west1.firebasedatabase.app/',
    projectId: 'durable-sound-463120',
    storageBucket: 'durable-sound-463120-v8.firebasestorage.app',
    messagingSenderId: '204320277724',
    appId: '1:204320277724:ios:237b5a30c0f99db2af6019',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDXmAT5fdeFokrKe3r7rerL0GGLziAYkd0',
    authDomain: 'durable-sound-463120.firebaseapp.com',
    databaseURL:
        'https://durable-sound-463120-v8-default-rtdb.europe-west1.firebasedatabase.app/',
    projectId: 'durable-sound-463120',
    storageBucket: 'durable-sound-463120-v8.firebasestorage.app',
    messagingSenderId: '204320277724',
    appId: '1:204320277724:ios:237b5a30c0f99db2af6019',
  );
}
