import 'dart:ui'; // Required for ImageFilter
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:winify/API/nft_fetch.dart';
import 'package:winify/Constants/SpinKits/primary_spinkit.dart';
import 'package:winify/Constants/constants.dart';
import 'package:winify/Models/nft_history.dart';

class NftHistoryPage extends StatefulWidget {
  final String publicAddress;

  const NftHistoryPage({super.key, required this.publicAddress});

  @override
  State<NftHistoryPage> createState() => _NftHistoryPageState();
}

class _NftHistoryPageState extends State<NftHistoryPage> {
  bool _isLoading = true;
  List<NftHistory> _nftHistory = [];

  @override
  void initState() {
    super.initState();
    _loadNftHistory();
  }

  Future<void> _loadNftHistory() async {
    final history = await fetchNftHistory(widget.publicAddress);
    setState(() {
      _nftHistory = history;
      _isLoading = false;
    });
  }

  // Function to show the details of the NFT in a dialog
  void _showNftDetails(NftHistory nft) {
    showDialog(
      context: context,
      barrierDismissible: true, // Allow tapping outside to dismiss the dialog
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: Colors.transparent, // Make dialog background transparent
          child: Stack(
            children: [
              // Blur background using BackdropFilter
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Set the blur intensity
                  child: Container(
                    color: Colors.transparent, // Transparent but blurred background
                  ),
                ),
              ),
              // Content of the dialog
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: primaryBackground,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(197, 197, 197, 0.298),
                        blurRadius: 20,
                        offset: Offset(0, 4),
                      )
                    ]
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Enlarged image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          nft.imageLink,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 16),
                      // Lottery code
                      Text(
                        "Lottery Code : ${nft.lotteryCode}",
                        style: GoogleFonts.sarpanch(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryWhite,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Token ID
                      Text(
                        "Token ID : ${nft.tokenId}",
                        style: GoogleFonts.sarpanch(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: smallTextColor,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Close button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text("Close"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackground,
      body: SafeArea(
        child: _isLoading
            ? Center(child: PrimarySpinkit()) // Show loading spinner
            : _nftHistory.isEmpty
                ? Center(child: Text('No NFTs found'))
                : Column(
                    children: [
                      Text(
                        "Lotteries Bought",
                        style: GoogleFonts.sarpanch(
                          color: primaryWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8.0),
                          itemCount: _nftHistory.length,
                          itemBuilder: (context, index) {
                            final nft = _nftHistory[index];
                            return Card(
                              color: Colors.black12,
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(10.0),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    nft.imageLink,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(
                                  nft.lotteryCode,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text(
                                  'Token ID: ${nft.tokenId}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                                onTap: () => _showNftDetails(nft), // Show the enlarged view on tap
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
