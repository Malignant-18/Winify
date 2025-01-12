import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:winify/API/base_url.dart';
import 'package:winify/Models/nft_history.dart';

Future<List<NftHistory>> fetchNftHistory(String publicAddress) async {
  final api = BaseUrl.baseURL;
  final url = '$api/buyer/get-lottery-history';

  // Create a payload with the publicAddress
  final Map<String, String> payload = {
    'buyerAddress': publicAddress,
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final historyList = (data['history'] as List)
          .map((nft) => NftHistory.fromJson(nft))
          .toList();
      // print(historyList);
      return historyList;
    } else {
      throw Exception('Failed to load NFT history');
    }
  } catch (e) {
    // print("Error fetching NFT history: $e");
    return [];
  }
}
