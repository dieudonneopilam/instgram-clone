import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gde/bloc/bottom.navigation.bar/bottom_navigation_bar_bloc.dart';
import 'package:gde/resources/auth_method.dart';
import 'package:gde/responsive/mobileScreen.dart';
import 'package:gde/responsive/responsive_layout.dart';
import 'package:gde/responsive/webScreen.dart';
import 'package:gde/screens/login_screen.dart';
import 'package:provider/provider.dart';

import 'bloc/current.user/cureent_user_bloc.dart';

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
    return MultiProvider(
      providers: [
        BlocProvider(
            create: (context) => CureentUserBloc(authMethod: AuthMethods())),
        BlocProvider(create: (context) => BottomNavigationBarBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
        title: 'Application',
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return ResponsiveLayout(
                    WebScreenLayout: WebScreenLayout(),
                    MobileScreenLayout: MobileScreenLayout());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.hasError}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
