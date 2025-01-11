import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:winify/Constants/constants.dart';

Widget firstPage() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [Color(0xFFFFFFFF), Color(0xFF9333EA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds),
        child: Text(
          "Welcome to Winify",
          style: GoogleFonts.sarpanch(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      Text(
        "Your secure blockchain-baseded lottery platform with NFT backed tickets",
        style: GoogleFonts.sarpanch(
          color: smallTextColor,
        ),
        textAlign: TextAlign.center,
      )
    ],
  );
}
