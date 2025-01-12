import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:winify/Constants/SpinKits/primary_spinkit.dart';
import 'package:winify/Constants/constants.dart';
import 'package:winify/Models/lottery_model.dart';
import 'package:winify/API/base_url.dart';
import 'package:winify/UI/LotteryScreen/LotteryScreenComponents/lottery_detail_screen.dart';

class LotteryScreen extends StatefulWidget {
  final String screenState;
  final String? sellerID;
  final String? publicAddress;
  const LotteryScreen(
      {super.key, required this.screenState, required this.sellerID, this.publicAddress});

  @override
  State<LotteryScreen> createState() => _LotteryScreenState();
}

class _LotteryScreenState extends State<LotteryScreen> {
  List<Lottery> _lotteries = [];
  bool _isLoading = true;
  final api = "${BaseUrl.baseURL}/seller/";

  @override
  void initState() {
    super.initState();
    fetchLotteries();
  }

  Future<void> fetchLotteries() async {
    try {
      final response =
          await http.get(Uri.parse("$api${widget.sellerID}/lotteries"));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)["message"];
        setState(() {
          _lotteries = data.map((item) => Lottery.fromJson(item)).toList();
          _isLoading = false; // Once data is fetched, stop loading
        });
      } else {
        // Handle errors
        print("Failed to load lotteries: ${response.statusCode}");
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      // Handle any exceptions
      print("Error fetching lotteries: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primaryBackground,
      body: _isLoading
          ? Center(
              child: PrimarySpinkit()
            )
          : Stack(
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(15, 50, 15, 15),
                  height: screenHeight * 0.75,
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                    color: primaryGrey,
                    borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Available Lotteries of Seller ${widget.sellerID}:",
                          style: GoogleFonts.sarpanch(
                            color: primaryWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 25
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: _lotteries.length,
                          itemBuilder: (context, index) {
                            // Extract lottery data
                            final lottery = _lotteries[index];
                            return ListTile(
                              leading:
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      lottery.image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                              title: Text(
                                lottery.id,
                                style: GoogleFonts.sarpanch(
                                  color: primaryWhite,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              subtitle:
                                  Text(
                                    "Value: Rs.${lottery.value}/-",
                                    style: GoogleFonts.sarpanch(
                                      color: smallTextColor
                                    ),
                                  ),
                              onTap: () {
                                _onLotteryTap(context, lottery, widget.sellerID,
                                    widget.publicAddress);
                              },
                            );
                          },
                        ),
                    ),
                  ],
                ),
              ),
            ],
          ),
    );
  }
  void _onLotteryTap(
      BuildContext context, Lottery lottery, String? sellerID, String? publicAddress) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow the sheet to expand
      builder: (BuildContext context) {
        return LotteryDetailScreen(
          screenState: widget.screenState,
          sellerID: sellerID,
          lottery: lottery,
          publicAddress: publicAddress,
        );
      },
    );
  }
}
