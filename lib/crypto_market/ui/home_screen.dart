import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/crypto_market/data/provider/crypto_provider.dart';
import 'package:flutter_application_1/crypto_market/model/crypto_model.dart';
import 'package:flutter_application_1/crypto_market/util/item_crypto.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  List<Crypto> _dataSearch = [];
  var _isFoundData = true;

  @override
  void initState() {
    Provider.of<CryptoProvider>(context, listen: false).getData();
    Timer.periodic(const Duration(seconds: 10), ((timer) {
      Provider.of<CryptoProvider>(context, listen: false).getData();
      _dataSearch =
          Provider.of<CryptoProvider>(context, listen: false).listCrypto;
    }));

    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _dataSearch = Provider.of<CryptoProvider>(context).listCrypto;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[300],
        title: Text(
          'CRYPTO MARKET',
          style: TextStyle(
              color: Colors.grey[900],
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<CryptoProvider>(
        builder: (context, value, child) {
          return Column(
            children: [
              _searchBar(),
              _dataSearch.isEmpty
                  ? const Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Expanded(
                      child: !_isFoundData
                          ? const Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Not found coin!',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: _dataSearch.length,
                              itemBuilder: (context, int index) {
                                var data = _dataSearch[index];

                                return ItemsCrypto(
                                  name: data.name,
                                  symbol: data.symbol,
                                  change: data.change!,
                                  changePercentage:
                                      data.changePercentage!.toDouble(),
                                  price: data.price!.toDouble(),
                                  imageUrl: data.imageUrl,
                                );
                              },
                            ),
                    ),
            ],
          );
        },
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(4, 4),
              blurRadius: 10,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ]),
      width: MediaQuery.sizeOf(context).width * 0.9,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TextField(
            controller: _textEditingController,
            onChanged: (value) {
              _searchFunc(value);
            },
            decoration: const InputDecoration(
                suffixIcon: Icon(Icons.search),
                hintText: 'Search ...',
                border: InputBorder.none),
          ),
        ),
      ),
    );
  }

  _searchFunc(String value) {
    List<Crypto> list = [];
    var provider =
        Provider.of<CryptoProvider>(context, listen: false).listCrypto;

    if (value.isEmpty) {
      list = provider;
    } else {
      list = provider
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    setState(() {
      if (list.isEmpty) {
        _isFoundData = false;
      } else {
        _dataSearch = list;
        _isFoundData = true;
      }
    });
  }
}
