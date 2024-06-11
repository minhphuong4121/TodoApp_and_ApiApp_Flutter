import 'package:flutter/material.dart';

class Crypto {
  const Crypto({
    required this.name,
    required this.symbol,
    this.imageUrl,
    required this.change,
    required this.changePercentage,
    required this.price,
  });

  final String name;
  final String symbol;
  final String? imageUrl;

  final num? price;
  final double? change;
  final num? changePercentage;

  factory Crypto.fromJson(Map<String, dynamic> map) {
    return Crypto(
        name: map['name'],
        symbol: map['symbol'],
        change: map['price_change_24h'],
        changePercentage: map['price_change_percentage_24h'],
        price: map['current_price'],
        imageUrl: map['image']);
  }
}
