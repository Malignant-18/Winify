import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:winify/Constants/constants.dart';

class SellerStory extends StatefulWidget {
  final String sellerName;
  final String sellerStory;

  const SellerStory({
    super.key, 
    required this.sellerName, 
    required this.sellerStory
  });

  @override
  State<SellerStory> createState() => _SellerStoryState();
}

class _SellerStoryState extends State<SellerStory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackground,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Seller Story", style: GoogleFonts.sarpanch(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Seller Name
            Text(
              widget.sellerName,
              style: GoogleFonts.sarpanch(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: primaryWhite,
              ),
            ),
            SizedBox(height: 20),
            // Divider line for separation
            Divider(
              color: primaryColor,
              thickness: 2,
              indent: 50,
              endIndent: 50,
            ),
            SizedBox(height: 20),
            // Seller Story
            Text(
              widget.sellerStory,
              style: GoogleFonts.sarpanch(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: primaryWhite,
                height: 1.5,
              ),
              // textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
