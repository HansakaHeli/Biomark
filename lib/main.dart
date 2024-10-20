import 'package:biomark_app/src/providers/auth_provider.dart';
import 'package:biomark_app/src/screens/ProfileSetupScreen.dart';
import 'package:biomark_app/src/screens/account_recovery_screen.dart';
import 'package:biomark_app/src/screens/home_screen.dart';
import 'package:biomark_app/src/screens/login_screen.dart';
import 'package:biomark_app/src/screens/register_screen.dart';
import 'package:biomark_app/src/screens/reset_password_screen.dart';
import 'package:biomark_app/src/screens/unsubscribe_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AuthsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Biomark',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/register': (context) => RegisterScreen(),
          '/login': (context) => LoginScreen(),
          '/profile_setup': (context) => ProfileSetupScreen(),
          '/acc_recovery':(context) => AccountRecoveryScreen(),
          '/reset_password':(context) => ResetPasswordScreen(),
          '/unsubscribe':(context) => UnsubscribeScreen(),

        },
        //home: RegisterScreen(),
      ),
    );
  }
}




