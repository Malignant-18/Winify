import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winify/Constants/constants.dart';
import 'package:winify/Providers/wallet_provider.dart';
import 'package:winify/UI/BuyerScreen/buyer_screen.dart';

class BuyerObtainAddressScreen extends StatefulWidget {
  const BuyerObtainAddressScreen({super.key});

  @override
  State<BuyerObtainAddressScreen> createState() =>
      _BuyerObtainAddressScreenState();
}

class _BuyerObtainAddressScreenState extends State<BuyerObtainAddressScreen> {
  TextEditingController walletController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primaryBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to",
                style: GoogleFonts.sarpanch(
                    color: primaryWhite,
                    fontSize: 36,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Winify",
                style: GoogleFonts.sarpanch(
                    color: primaryColor,
                    fontSize: 36,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text(
            "Please enter your wallet address to continue",
            style: GoogleFonts.sarpanch(color: smallTextColor, fontSize: 14),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            height: screenHeight * 0.3,
            width: screenWidth * 0.95,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: primaryGrey, borderRadius: BorderRadius.circular(12)),
            child: Column(
              spacing: 20,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Connect Your Wallet",
                    style: GoogleFonts.sarpanch(
                        color: primaryWhite,
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                TextFormField(
                  controller: walletController,
                  style: GoogleFonts.sarpanch(color: primaryWhite),
                  decoration: InputDecoration(
                    hintText: "Enter your wallet address (0x...)",
                    hintStyle: GoogleFonts.sarpanch(color: hintTextColor),
                    filled: true,
                    fillColor: walletFillColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: walletFillColor, width: 0.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: walletFillColor, width: 0.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: walletFillColor, width: 0.5),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                  onPressed: () async {
                    try {
                      dynamic publicAddress;

                      if (walletController.text.isNotEmpty) {
                        // Use the entered address from the TextField
                        publicAddress = walletController.text;
                      } else {
                        // If the field is empty, generate a new address
                        final mnemonic = walletProvider.generateMnemonic();
                        print("Mnemonic: $mnemonic");
                        final privateKey =
                            await walletProvider.getPrivateKey(mnemonic);
                        print("Private Key: $privateKey");
                        publicAddress =
                            await walletProvider.getPublicKey(privateKey);
                        print("Generated Public Address: $publicAddress");
                      }
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setString('publicAddress', publicAddress);
                      await prefs.setBool('shouldRedirectToBuyerObtainAddress', true);
                      if (mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BuyerScreen(publicAddress: publicAddress),
                          ),
                        );
                      }
                    } catch (e) {
                      print("Error: $e");
                    }
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: primaryGradient,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Row(
                          spacing: 10,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/walletIcon.png"),
                            Text(
                              "Generate New Wallet",
                              style: GoogleFonts.sarpanch(
                                  fontSize: 16,
                                  color: primaryWhite,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
