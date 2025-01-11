import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:hex/hex.dart';
import 'package:flutter/foundation.dart';

abstract class WalletAddressService {
  String generateMnemonic();
  Future<String> getPrivateKey(String mnemonic);
  Future<EthereumAddress> getPublicKey(String privateKey);
  Future<Web3Client> getWeb3Client();
}

class WalletProvider extends ChangeNotifier implements WalletAddressService {
  final String sepoliaRpcUrl = 'https://sepolia.infura.io/v3/86cb1361d34948a7ab88dd954f91d39c';
  
  Web3Client? _web3Client;

  @override
  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  @override
  Future<String> getPrivateKey(String mnemonic) async {
    final seed = bip39.mnemonicToSeed(mnemonic);
    final master = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    final privateKey = HEX.encode(master.key);
    return privateKey;
  }

  @override
  Future<EthereumAddress> getPublicKey(String privateKey) async {
    final private = EthPrivateKey.fromHex(privateKey);
    final address = await private.address;
    return address;
  }

  @override
  Future<Web3Client> getWeb3Client() async {
    _web3Client ??= Web3Client(sepoliaRpcUrl, Client());
    return _web3Client!;
  }
}