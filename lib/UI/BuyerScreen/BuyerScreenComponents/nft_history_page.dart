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
                        fontSize: 36
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
