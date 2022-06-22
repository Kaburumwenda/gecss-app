import 'dart:convert';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mobile/Animation/FadeAnimation.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/screens/screens.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({ Key? key }) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'.toUpperCase(), style:const TextStyle(color: Colors.white54, fontSize: 14),),
        leading:const BackButton(color: Colors.white54 ),
        backgroundColor: Colors.brown,
        elevation: 0.0,
        ),

      body: FadeAnimation(
        0.8,
        Column(children: [
             Row(children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: (){                      
                    ArtSweetAlert.show(
                      barrierDismissible: false,
                      context: context,
                      artDialogArgs: ArtDialogArgs(
                        title: 'Your transactions are as shown bellow',
                        confirmButtonText: "Ok",
                        type: ArtSweetAlertType.success
                      ));
                  }, 
                  child: const Text('History', style: TextStyle(fontSize: 16),),
                  style: ElevatedButton.styleFrom(
                    primary:Colors.brown[200],
                    padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                  )
                ),
      
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                     Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>const DepositScreen(),
                    ));
                  }, 
                  child: const Text('Deposit', style: TextStyle(fontSize: 16),),
                  style: ElevatedButton.styleFrom(
                    primary:Colors.green,
                    padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                  )
                ),
      
            ],),
            const SizedBox(height: 20,),
                  
            Expanded(
            child: _isLoading ? const Center(child: CircularProgressIndicator(),) : SizedBox(
              height: 300,
              child: _data.isNotEmpty ? ListView.builder(
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
                    Text( '＄' + _data[i].amount.toString(), style:const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),),
                    const SizedBox(width: 20,),
                    Column(children: [
                      Text(_data[i].status.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold, 
                      color: (_data[i].status == 'Paid') ? Colors.blue : (_data[i].status.toString() == 'Pending') ? Colors.purple : Colors.black
                      ),),
                      Text(_data[i].createdAt.toString())
                    ],)
                  ],),
                )
                ) : const Center(child: Text('No transactions yet', style: TextStyle(color: Colors.orange),),) ,
              )
            )
        ],),
      ),

    );
  }
}