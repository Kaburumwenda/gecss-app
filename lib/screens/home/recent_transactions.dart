import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
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
    String url = 'http://192.168.1.9/v1/user/transaction';
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
      child: SizedBox(
        child:  _isLoading ? const Center(child: CircularProgressIndicator(),) : ListView.builder(
          itemCount: _data.length,
          itemBuilder: (ctx, i) => Container(
            padding:const EdgeInsets.fromLTRB(10, 0, 10, 0),
            margin:const EdgeInsets.only(bottom: 10),
            child: Row(children: [
              CircleAvatar(
                backgroundColor: ( _data[i].purpose == 'Daily Deposit' ) ? Colors.brown[100] : Colors.blue[100],
                child: Text(
                  ( _data[i].purpose == 'Daily Deposit' ) ? 'DD' : 'SB',
                ),
              ),
              const Text('  '),
              Text(_data[i].purpose.toString()),
              const Spacer(),
              Text( 'KES ' + _data[i].amount.toString(), style:const TextStyle(fontWeight: FontWeight.bold, color: Colors.green,),),
              const SizedBox(width: 20,),
              Column(children: [
                Text(_data[i].status.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, 
                color: (_data[i].status.toString() == 'Paid') ? Colors.blue : (_data[i].status.toString() == 'Processing') ? Colors.purple : Colors.black
                ),),
                Text(_data[i].createdAt.toString())
              ],)
            ],),
          )
          ) ,
        )
      );
  }
}