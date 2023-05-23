import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gde/responsive/mobileScreen.dart';
import 'package:gde/responsive/responsive_layout.dart';
import 'package:gde/responsive/webScreen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyAJtkeqhmsGgrNVEINYjwPxH9k99uDKCFs',
          appId: '1:70417972472:web:f2f288cfd722a46b37cf0d',
          messagingSenderId: '70417972472',
          projectId: 'gde-app-d26cd',
          storageBucket: 'gde-app-d26cd.appspot.com'),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      title: 'Application',
      home: const ResponsiveLayout(
          WebScreenLayout: WebScreenLayout(),
          MobileScreenLayout: MobileScreenLayout()),
    );
  }
}

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold();
//   }
// }
