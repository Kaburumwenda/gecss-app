import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/endpoints/endpoint.dart';
import 'package:mobile/models/models.dart';

class RecentTransaction extends StatefulWidget {
  const RecentTransaction({ Key? key }) : super(key: key);

  @override
  State<RecentTransaction> createState() => _RecentTransactionState();
}

class _RecentTransactionState extends State<RecentTransaction> {
  LocalStorage storage = LocalStorage('usertoken');
  Client client = http.Client();
  List<Transaction> _data = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getFinance();
  }

  _getFinance() async {
    var token = storage.getItem('token');
    _data = [];
    var baseur = AdsType.baseurl;
    String url = '$baseur/v1/user/transaction';
    List resp = json.decode((await client.get(Uri.parse(url), headers: {'Authorization': "token $token"} )).body);
     resp.forEach((element) {
      _data.add(Transaction.fromJson(element));
    });
    setState(() {
       _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Lottie.asset('assets/lottie/service.json'), 
      );
  }
}