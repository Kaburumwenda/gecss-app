import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mobile/endpoints/endpoint.dart';
import 'package:mobile/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class WalletDisplay extends StatefulWidget {
  const WalletDisplay({ Key? key }) : super(key: key);

  @override
  State<WalletDisplay> createState() => _WalletDisplayState();
}

class _WalletDisplayState extends State<WalletDisplay> {
  LocalStorage storage = LocalStorage('usertoken');
   Client client = http.Client();
  List<AccountDetails> _data = [];
  bool _isLoading = true;

   @override
  void initState() {
    super.initState();
   _getAccountDetails();
  }

  _getAccountDetails() async {
    var token = storage.getItem('token');
    _data = [];
    var baseur = AdsType.baseurl;
    String url = '$baseur/v1/user/account';
    List resp = json.decode((await client.get(Uri.parse(url), headers: {'Authorization': "token $token"} )).body);
     resp.forEach((element) {
      _data.add(AccountDetails.fromJson(element));
    });
    setState(() {
       _isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.fromLTRB(20, 10, 20, 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.brown[100],
        borderRadius: BorderRadius.circular(10)
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(children:const [
          Text('Welcoe to     ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color:Colors.black54,) ),
          Spacer(),
        ],),
        
        Container(
          child: const Text('GECSS OPERATIONS', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color:Colors.green,))
        )
      ],),


    );
  }
}