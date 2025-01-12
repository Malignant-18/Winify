class NftHistory {
  final String tokenId;
  final String lotteryId;
  final String lotteryCode;
  final String imageLink;
  final String metadataLink;

  NftHistory({
    required this.tokenId,
    required this.lotteryId,
    required this.lotteryCode,
    required this.imageLink,
    required this.metadataLink,
  });

  factory NftHistory.fromJson(Map<String, dynamic> json) {
    return NftHistory(
      tokenId: json['tokenId'],
      lotteryId: json['lotteryId'],
      lotteryCode: json['lotteryCode'],
      imageLink: json['imageLink'],
      metadataLink: json['metadataLink'],
    );
  }
}
