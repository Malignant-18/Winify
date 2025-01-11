import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winify/Constants/SpinKits/primary_spinkit.dart';
import 'package:winify/Constants/constants.dart';
import 'package:winify/UI/LandingScreen/landing_screen.dart';
import 'package:winify/UI/LoginScreen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  screenLogic(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? firstTime = prefs.getBool('firstTime');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen()
      )
    );
    if (firstTime == null || firstTime == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LandingScreen()
        ),
      );
    }    
  }
  @override
  void initState() {
    Future.delayed(
      const Duration(
        milliseconds: 5000
      ), 
      () {
      if (mounted) {
        screenLogic(context);
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackground,
      body: PrimarySpinkit()
    );
  }
}