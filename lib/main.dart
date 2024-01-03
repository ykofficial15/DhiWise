import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dhiwise/Constants/indicator.dart';
import 'package:dhiwise/Controllers/loginController.dart';
import 'package:dhiwise/Controllers/persistentLogin.dart';
import 'package:dhiwise/Models/formModel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Controllers/formController.dart';
import 'Controllers/getDataController.dart';
import 'Views/bottomNav.dart';
import 'Views/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyCfOMuUs5PqCpPhtcpgPcG36Y0bD8oXka4',
      appId: '1:307711849689:android:3d8ab66475af8986987ac8',
      messagingSenderId: '307711849689',
      projectId: 'dhiwise-4cd76',
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(false),
        ),
        ChangeNotifierProvider(create: (_) => FormDataProvider()),
        ChangeNotifierProvider<LoginProvider>(
          create: (context) => LoginProvider(),
        ),
        Provider<FirebaseService>(
          create: (_) =>
              FirebaseService(), // Provide an instance of FirebaseService
          dispose: (_, firebaseService) =>
              firebaseService.dispose(), // If needed
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final prefs = snapshot.data as SharedPreferences;
              final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
              return ChangeNotifierProvider(
                create: (context) => AuthProvider(isLoggedIn),
                child: AnimatedSplashScreen(
                  backgroundColor: Color.fromARGB(255, 0, 2, 42),
                  duration: 2000,
                  splash: Text('DHIWISE',style: TextStyle(color:Colors.white,fontSize: 25, fontWeight: FontWeight.bold),),
                  splashIconSize: 100,
                  nextScreen: isLoggedIn ? BottomNavigation() : Login(),
                ),
              );
            } else {
              return Indicator();
            }
          },
        ),
      ),
    );
  }
}
