import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:winify/Constants/SpinKits/primary_spinkit.dart';
import 'package:winify/Constants/constants.dart';
import 'package:winify/API/base_url.dart';
import 'package:winify/UI/BuyerScreen/BuyerScreenComponents/q_r_code_scanner.dart';
import 'package:winify/UI/BuyerScreen/BuyerScreenComponents/nft_history_page.dart';
import 'package:winify/UI/LotteryScreen/lottery_screen.dart';

class BuyerScreen extends StatefulWidget {
  final String publicAddress;
  const BuyerScreen({required this.publicAddress, super.key});

  @override
  State<BuyerScreen> createState() => _BuyerScreenState();
}

class _BuyerScreenState extends State<BuyerScreen> {
  final api = "${BaseUrl.baseURL}/seller/";
  String? _result;
  Future<void>? fetchLotteryFuture;

  void setResult(String result) {
    setState(() {
      _result = result;
    });
    if (_result != null) {
      setState(() {
        fetchLotteryFuture = fetchSellerLotteries();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primaryBackground,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Dashboard",
                  style: GoogleFonts.sarpanch(
                    color: primaryWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: screenHeight * 0.4,
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                color: primaryGrey,
                borderRadius: BorderRadius.circular(12)
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Wallet Address:",
                    style: GoogleFonts.sarpanch(
                      color: smallTextColor
                    ),
                  ),
                  Text(
                    widget.publicAddress,
                    style: GoogleFonts.sarpanch(
                      color: primaryWhite,
                      fontSize: 12
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Balance:",
                    style: GoogleFonts.sarpanch(
                      color: smallTextColor
                    ),
                  ),
                  Text(
                    "0.5Eth",
                    style: GoogleFonts.sarpanch(
                      color: primaryWhite,
                      fontSize: 16
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                    onPressed: (){
                      Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => NftHistoryPage(publicAddress: widget.publicAddress))  
                      );
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
                              Image.asset("assets/walletIconWhite.png"),
                              Text(
                                "View My Lotteries",
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
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                    onPressed: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => QrCodeScanner(setResult: setResult),
                      ),
                    );
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
                              Image.asset("assets/qrIcon.png", color: primaryWhite,),
                              Text(
                                "Scan QR",
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
            ),
            if (fetchLotteryFuture != null)
              FutureBuilder<void>(
                future: fetchLotteryFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: PrimarySpinkit());
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
  Future<void> fetchSellerLotteries() async {
    if (_result == null) return;

    String url = "$api$_result/lotteries";
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        // Map<String, dynamic> responseData = jsonDecode(response.body);
        // print(responseData); // Print response for debugging
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LotteryScreen(screenState: 'Buyer' ,sellerID: _result, publicAddress: widget.publicAddress)),
        );
      } else {
        // print('Error: ${response.statusCode}');
        // print('Response body: ${response.body}');
      }
    } catch (e) {
      // print('API call failed: $e');
    }
  }
}