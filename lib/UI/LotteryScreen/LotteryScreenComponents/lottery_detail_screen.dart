import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:winify/Constants/SpinKits/primary_spinkit.dart';
import 'package:winify/Constants/constants.dart';
import 'package:winify/Models/lottery_model.dart';
import 'package:winify/API/base_url.dart';

class LotteryDetailScreen extends StatefulWidget {
  final String screenState;
  final Lottery lottery;
  final String? sellerID;
  final String? publicAddress;

  const LotteryDetailScreen(
      {super.key,
      required this.screenState,
      required this.lottery,
      required this.sellerID,
      required this.publicAddress});

  @override
  State<LotteryDetailScreen> createState() => _LotteryDetailScreenState();
}

class _LotteryDetailScreenState extends State<LotteryDetailScreen> {
  final api = "${BaseUrl.baseURL}/";
  bool _isLoading = true;
  List<String> _serialNumbers = [];
  late final int lotteryAmount;
  late final String lotteryUrl;

  @override
  void initState() {
    super.initState();
    lotteryAmount = widget.lottery.value;
    lotteryUrl = widget.lottery.url;
    _fetchSerialNumbers();
  }

  // Fetch serial numbers from the API
  Future<void> _fetchSerialNumbers() async {
    final lotteryId = widget.lottery.id;
    final url = "${api}seller/${widget.sellerID}/lotteries/$lotteryId";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> serials = data['lotteries'];

        setState(() {
          _serialNumbers = serials.cast<String>();
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      // print("Error: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool _isLoadingNFT = false;

  void _openPaymentDialog(String serial) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Payment Options",
            style: GoogleFonts.inika(color: Colors.black),
          ),
          content: Text(
            "Do you want to pay for the serial number $serial?",
            style: GoogleFonts.inika(color: Colors.black),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Deny"),
              onPressed: () {
                _denyPayment(serial);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Pay"),
              onPressed: () {
                _processPayment(widget.sellerID, serial, widget.publicAddress);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _denyPayment(String serial) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Payment denied for $serial")));
  }

  void _processPayment(
    String? sellerId,
    String serial,
    String? publicAddress,
  ) {
    setState(() {
      _isLoadingNFT = true;
    });

    final url1 = "${api}buyer/create-lottery-nft";
    String partBeforeHyphen = serial.substring(0, 4); // First 4 characters
    String partAfterHyphen =
        serial.substring(4); // Rest of the string after the 4th character

    final Map<String, dynamic> payload1 = {
      'lotteryCode': partBeforeHyphen,
      'lotteryId': partAfterHyphen,
      'buyerAddress': publicAddress,
    };

    // First POST request
    http
        .post(
      Uri.parse(url1),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payload1),
    )
        .then((response) {
      setState(() {
        _isLoadingNFT = false;
      });

      if (response.statusCode == 200) {
        // print(response.body);
        // Map<String, dynamic> responseData = jsonDecode(response.body);
        // String nft = responseData['imageLink'] ?? '';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Payment processed for serial $serial")),
        );
        final url2 = "${api}seller/delete-lottery";
        final Map<String, dynamic> payload2 = {
          'sellerId': sellerId,
          'lotteryId': serial,
        };

        // Second POST request (delete lottery)
        return http.post(
          Uri.parse(url2),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(payload2),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to process first payment")),
        );
        throw Exception('Failed to create lottery NFT');
      }
    }).then((response2) {
      if (response2.statusCode == 200) {
        Map<String, dynamic> response2Data = jsonDecode(response2.body);
        String successMessage =
            response2Data['message'] ?? 'Lottery deletion failed';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(successMessage)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to delete lottery")),
        );
      }
    }).catchError((error) {
      setState(() {
        _isLoadingNFT = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $error")),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Color(0xFF101010),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(197, 197, 197, 0.298),
              blurRadius: 20,
              offset: Offset(0, 4),
            )
          ]),
      child: _isLoading || _isLoadingNFT
          ? PrimarySpinkit()
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: primaryWhite,
                    thickness: 2,
                    indent: 120,
                    endIndent: 120,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${widget.lottery.id} Lottery",
                        style: GoogleFonts.sarpanch(
                            color: primaryWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Serial Numbers:",
                            style: GoogleFonts.sarpanch(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryWhite),
                          ),
                        ),
                        SizedBox(height: 10),
                        ..._serialNumbers.map((serial) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 4.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12)))),
                              onPressed: widget.screenState == 'Buyer' ? () {
                                _openPaymentDialog(serial);
                              } : (){},
                              child: Text(serial,
                                  style: GoogleFonts.sarpanch(
                                      fontSize: 16,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold))
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
