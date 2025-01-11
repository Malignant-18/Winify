import 'package:flutter/material.dart';

class BuyerScreen extends StatefulWidget {
  final dynamic publicAddress;
  const BuyerScreen({required this.publicAddress, super.key});

  @override
  State<BuyerScreen> createState() => _BuyerScreenState();
}

class _BuyerScreenState extends State<BuyerScreen> {
  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Center(
        child: Text(
          widget.publicAddress.toString()
        ),
      ),
    );
  }
}