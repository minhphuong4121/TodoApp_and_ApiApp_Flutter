import 'package:flutter/material.dart';
import 'package:flutter_application_1/crypto_market/data/service/fetch_data.dart';
import 'package:flutter_application_1/crypto_market/model/crypto_model.dart';


class CryptoProvider extends ChangeNotifier {
  List<Crypto> listCrypto = [];
  final RemoteDataSource _remoteData = RemoteDataSource();

  Future<void> getData({String? searchText}) async {
    final data = await _remoteData.fetchCrypto();
    listCrypto = data;
  
    notifyListeners();
  }

  
}
