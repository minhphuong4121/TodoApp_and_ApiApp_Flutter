import 'dart:convert';

import 'package:flutter_application_1/crypto_market/model/crypto_model.dart';
import 'package:http/http.dart' as http;

class RemoteDataSource {
  Future<List<Crypto>> fetchCrypto({String? searchText}) async {
    var url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=false';
    // if (searchText != null) {
    //   url = 'https://api.coingecko.com/api/v3/search?query=$searchText';
    // }
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final bodyContent = utf8.decode(response.bodyBytes);
      List listValues = jsonDecode(bodyContent);
      final data = listValues.map((e) => Crypto.fromJson(e)).toList();
      print(data.first.price);
      return data;
    } else {
      throw Exception('Failed massage');
    }
  }
}
