import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:winify/Constants/constants.dart';

Widget thirdPage(BuildContext context, Function onLandingEnd, {extra = const Center()}) {
  double screenWidth = MediaQuery.of(context).size.width;
  // double screenHeight = MediaQuery.of(context).size.height;

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    spacing: 10,
    children: [
      Text(
        "Key Features",
        style: GoogleFonts.sarpanch(
          color: primaryWhite,
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            // height: screenHeight * 0.3,
            width: screenWidth * 0.45,
            child: Column(
              children: [
                Image.asset("assets/qrAsset.png"),
                Container(
                  decoration: BoxDecoration(
                      color: primaryGrey,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 10,
                    children: [
                      SizedBox(
                        width: 1,
                      ),
                      Image.asset("assets/qrIcon.png"),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "QR-Based System",
                            style: GoogleFonts.sarpanch(
                                color: primaryWhite, fontSize: 12),
                          ),
                          Text(
                            "Seamless scanning for\nlottery purchases",
                            style: GoogleFonts.sarpanch(
                                color: smallTextColor, fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 3,
          ),
          SizedBox(
            // height: screenHeight * 0.3,
            width: screenWidth * 0.45,
            child: Column(
              children: [
                Image.asset("assets/secureNFT.png"),
                Container(
                  decoration: BoxDecoration(
                      color: primaryGrey,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 10,
                    children: [
                      SizedBox(
                        width: 1,
                      ),
                      Image.asset("assets/lockIcon.png"),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Secure BlockChain",
                            style: GoogleFonts.sarpanch(
                                color: primaryWhite, fontSize: 12),
                          ),
                          Text(
                            "Transparent and tam\nper proof transactions",
                            style: GoogleFonts.sarpanch(
                                color: smallTextColor, fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      SizedBox(
        width: screenWidth * 0.95,
        child: Column(
          children: [
            Image.asset("assets/landingNFT.png"),
            Container(
              decoration: BoxDecoration(
                  color: primaryGrey,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 10,
                children: [
                  SizedBox(
                    width: 1,
                  ),
                  Image.asset("assets/lotteryIcon.png"),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "NFT Tickets",
                          style: GoogleFonts.sarpanch(
                              color: primaryWhite, fontSize: 14),
                        ),
                        Text(
                          "Unique digital assets for each ticket",
                          style: GoogleFonts.sarpanch(
                              color: smallTextColor, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 5,
      ),
      extra
    ],
  );
}
