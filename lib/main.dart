import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winify/Providers/wallet_provider.dart';
import 'package:winify/UI/SplashScreen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider<WalletProvider>(
      create: (context) => WalletProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Winify',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}