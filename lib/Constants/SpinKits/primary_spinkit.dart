import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:winify/Constants/constants.dart';

class PrimarySpinkit extends StatelessWidget {
  const PrimarySpinkit({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitSpinningLines(
        color: primaryColor,
      ),
    );
  }
}