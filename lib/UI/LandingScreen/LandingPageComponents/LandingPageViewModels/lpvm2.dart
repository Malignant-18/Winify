import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:winify/Constants/constants.dart';

Widget secondPage() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Scan to Connect",
        style: GoogleFonts.sarpanch(
          color: primaryWhite,
          fontWeight: FontWeight.bold,
          fontSize: 24
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Image.asset(
        "assets/landingSecond.png",
        height: 284,
        width: 284,
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        "Secure Connection Protocol",
        style: GoogleFonts.sarpanch(
          color: smallTextColor,
          fontSize: 16
        ),
      ),
      Text(
        "End-to-End Encrypted • Blockchain Verified",
        style: GoogleFonts.sarpanch(
          color: smallTextColor,
          fontSize: 14
        ),
      )
    ],
  );
}