import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:winify/Constants/constants.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const InputField(
      {required this.controller, required this.hintText, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Text(
            hintText,
            style: GoogleFonts.sarpanch(color: smallTextColor),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: TextFormField(
            controller: controller,
            style: GoogleFonts.sarpanch(
                color: primaryWhite
              ),
            decoration: InputDecoration(
              hintText: "Enter your $hintText",
              hintStyle: GoogleFonts.sarpanch(
                color: hintTextColor
              ),
              filled: true,
              fillColor: primaryGrey,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: smallTextColor, width: 0.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: smallTextColor, width: 0.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: smallTextColor, width: 0.5),
              ),
            ),
            keyboardType: hintText == "Username" ? TextInputType.text : TextInputType.visiblePassword,
            obscureText: hintText == "Username" ? false : true,
          ),
        )
      ],
    );
  }
}
