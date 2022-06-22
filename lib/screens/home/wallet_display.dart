import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mobile/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mobile/screens/iam/profile.dart';

class WalletDisplay extends StatefulWidget {
  const WalletDisplay({ Key? key }) : super(key: key);

  @override
  State<WalletDisplay> createState() => _WalletDisplayState();
}

class _WalletDisplayState extends State<WalletDisplay> {
  LocalStorage storage = LocalStorage('usertoken');
   Client client = http.Client();
  List<UserAccount> _data = [];
  bool _isLoading = true;

   @override
  void initState() {
    super.initState();
   _getAccountDetails();
  }

  _getAccountDetails() async {
    var token = storage.getItem('token');
    _data = [];
    String url = 'http://192.168.1.9/v1/user/account';
    List resp = json.decode((await client.get(Uri.parse(url), headers: {'Authorization': "token $token"} )).body);
     resp.forEach((element) {
      _data.add(UserAccount.fromJson(element));
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
        Row(children:[
          Text('Account balance:'.toUpperCase(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color:Colors.black54,) ),
          const Spacer(),
          const CircleAvatar(
            radius: 20.0,
            backgroundImage: AssetImage('assets/images/launcher.png'),
            backgroundColor: Colors.transparent,
          ),
        ],),
        
        Container(
          child: _isLoading ? const Text(' KES __:__', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color:Colors.green,)) : Row(children: [
            Text( 
              _data.isNotEmpty ? 'KES ' + _data[0].balance.toString() : ' KES 0.00',
              style:const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color:Colors.green,)
            ),
            IconButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const UserProfile(),
                ));
            }, 
            icon: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.orange[200],),
              child: const Icon(Icons.arrow_circle_right_outlined , size: 30, color: Colors.white, )), 
            color: Colors.black54,),
          ],),
        )
      ],),


    );
  }
}