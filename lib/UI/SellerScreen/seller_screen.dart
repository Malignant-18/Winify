import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:winify/Constants/constants.dart';

class SellerScreen extends StatefulWidget {
  final String sellerID;
  const SellerScreen({required this.sellerID,super.key});

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primaryBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Hey",
                    style: GoogleFonts.sarpanch(
                      color: primaryWhite,
                      fontWeight: FontWeight.w800,
                      fontSize: 36
                    ),
                  ),
                  Text(
                    widget.sellerID,
                    style: GoogleFonts.sarpanch(
                      color: primaryColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 36
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Welcome back!",
                  style: GoogleFonts.sarpanch(
                    color: primaryWhite,
                    fontWeight: FontWeight.w800,
                    fontSize: 36
                  ),
                ),
              ),
              Text(
                "Your digital storefront is ready",
                style: GoogleFonts.sarpanch(
                  color: smallTextColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 16
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: screenHeight * 0.47,
                width: screenWidth * 0.95,
                decoration: BoxDecoration(
                  color: primaryGrey,
                  borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Your Seller QR Code",
                      style: GoogleFonts.sarpanch(
                        color: primaryWhite,
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    QrImageView(
                      backgroundColor: Colors.white,
                      data: widget.sellerID,
                      version: QrVersions.auto,
                      size: 250.0,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "This QR code contains your seller information.",
                      style: GoogleFonts.sarpanch(
                        color: smallTextColor,
                        fontSize: 14
                      ),
                    ),
                    Text(
                      "Buyers can scan this to connect with you.",
                      style: GoogleFonts.sarpanch(
                        color: smallTextColor,
                        fontSize: 14
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                // Container(
                //   padding: const EdgeInsets.fromLTRB(10, 32, 10, 0),
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //         backgroundColor: Colors.transparent,
                //         shape: ContinuousRectangleBorder(
                //             borderRadius: BorderRadius.circular(12)),
                //         elevation: 0),
                //     onPressed: () {},
                //     child: Ink(
                //       width: double.infinity,
                //       decoration: BoxDecoration(
                //           gradient: primaryGradient,
                //           shape: BoxShape.rectangle,
                //           borderRadius: BorderRadius.circular(12)),
                //       child: Padding(
                //         padding: const EdgeInsets.symmetric(vertical: 20),
                //         child: Center(
                //           child: Text(
                //             "New? Register",
                //             style: GoogleFonts.sarpanch(
                //               fontSize: 16,
                //               color: primaryWhite, fontWeight: FontWeight.bold),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGrey,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8)
                        )
                      )
                    ),
                    onPressed: (){}, 
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                        right: 20,
                      ),
                      child: Row(
                        spacing: 10,
                        children: [
                          Image.asset(
                            "assets/timerIcon.png"
                          ),
                          Text(
                            "View Story",
                            style: GoogleFonts.sarpanch(
                              color: primaryWhite,
                              fontSize: 14
                            ),
                          )
                        ],
                      ),
                    )
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGrey,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8)
                        )
                      )
                    ),
                    onPressed: (){}, 
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                      ),
                      child: Row(
                        spacing: 10,
                        children: [
                          Image.asset(
                            "assets/walletIconWhite.png"
                          ),
                          Text(
                            "View Lotteries",
                            style: GoogleFonts.sarpanch(
                              color: primaryWhite,
                              fontSize: 14
                            ),
                          )
                        ],
                      ),
                    )
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: screenHeight * 0.2,
                width: screenWidth * 0.8,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primaryGrey,
                  borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Seller Data",
                        style: GoogleFonts.sarpanch(
                          color: primaryWhite,
                          fontWeight: FontWeight.w500,
                          fontSize: 20
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Seller Name:",
                          style: GoogleFonts.sarpanch(
                            color: smallTextColor
                          ),
                        ),
                        Text(
                          "Ikkachi Main",
                          style: GoogleFonts.sarpanch(
                            color: primaryWhite
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Seller ID:",
                          style: GoogleFonts.sarpanch(
                            color: smallTextColor
                          ),
                        ),
                        Text(
                          widget.sellerID,
                          style: GoogleFonts.sarpanch(
                            color: primaryWhite
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Active since:",
                          style: GoogleFonts.sarpanch(
                            color: smallTextColor
                          ),
                        ),
                        Text(
                          "4th Jan",
                          style: GoogleFonts.sarpanch(
                            color: primaryWhite
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}