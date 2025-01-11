import 'package:flutter/material.dart';

class LotteryScreen extends StatefulWidget {
  final String? sellerID;
  final String publicAddress;
  const LotteryScreen({super.key, required this.sellerID, required this.publicAddress});

  @override
  State<LotteryScreen> createState() => _LotteryScreenState();
}

class _LotteryScreenState extends State<LotteryScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}