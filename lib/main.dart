import 'package:ees_calculator/Front%20End/log_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBRqSbc5WIYH-gXP42vjQu6Owhoopd_0J0",
          authDomain: "eescalculator-df5ef.firebaseapp.com",
          projectId: "eescalculator-df5ef",
          storageBucket: "eescalculator-df5ef.firebasestorage.app",
          messagingSenderId: "321352161067",
          appId: "1:321352161067:web:94c688ca0cc395a4a7176e",
          measurementId: "G-L1WN080KYW"),
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(), // Make sure the LoginPage is defined correctly
      debugShowCheckedModeBanner: false,
    );
  }
}
