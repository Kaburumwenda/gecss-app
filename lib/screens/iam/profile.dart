import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mobile/Animation/FadeAnimation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/screens/auth/welcome.dart';
import 'package:mobile/screens/screens.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({ Key? key }) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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

  void _logoutnew() async {
    await storage.clear();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) =>const WelcomeScreen(),
    ));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text('Your Profile'.toUpperCase(), style:const TextStyle(color: Colors.white54, fontSize: 12),),
        iconTheme:const IconThemeData(color: Colors.white54 ),
        elevation: 0.0,
        actions: [
          IconButton(
          onPressed: (){ 
           _logoutnew();
          }, 
          icon: Container(
            padding:const EdgeInsets.all(5),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.grey[200],),
            child: const Icon(Icons.logout_outlined )), 
          color: Colors.black54,),
        ],
      ),
      body: _isLoading ? const Center(child: CircularProgressIndicator(),) : FadeAnimation(  
        0.8,
        Container(
          child: _data.isNotEmpty ? Column(
          children: [
          Container(
            margin:const EdgeInsets.fromLTRB(40, 20, 40, 0),
            alignment: Alignment.center,
            padding:const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
              ),
            child: Column(
             children: [

              const CircleAvatar(
               radius: 60.0,
               backgroundImage: AssetImage('assets/images/user-a.png'),
               backgroundColor: Colors.transparent,
             ),
             Text(_data[0].client.toString(), style:const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),),
             Text('Member No: ' + _data[0].memNo.toString()),
            //  RichText(
            //       text: TextSpan(
            //         children:<TextSpan>[
            //           const TextSpan(text: 'Account Status: ', style: TextStyle(color:Colors.black54, fontSize: 16)),
            //           TextSpan(text: _data[0].st, style: const TextStyle( color:Colors.green, fontSize: 14, fontWeight: FontWeight.bold)),
            //         ],
            //       ),
            //     ),
             ],
          ),),
          const SizedBox(height: 20,),
          
          Container(
            margin:const EdgeInsets.fromLTRB(40, 0, 40, 0),
            alignment: Alignment.center,
            padding:const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
              ),
            child: Column(
              children: [
             Row(children: [
               const Text('Account balance: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color:Colors.black54,)),
               Text('KES: ' + _data[0].balance.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color:Colors.green,))
             ],),
             const SizedBox(height: 10,),
             Row(children: [
               const Text('Amount to be Paid: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color:Colors.black54,)),
               Text('KES: ' + _data[0].amount.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color:Colors.green,))
             ],),
          ],),),
          const SizedBox(height: 20,),

       Container(
            margin:const EdgeInsets.fromLTRB(10, 0, 10, 0),
            alignment: Alignment.center,
            padding:const EdgeInsets.all(20),
            decoration:const BoxDecoration(
              color: Colors.white,
              ),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          
          GestureDetector(
            onTap: (){
             Navigator.of(context).push(MaterialPageRoute(
               builder: (BuildContext context) =>const DepositScreen(),
             ));
            },
            child: Column(
            children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(  
             color: Colors.blue[50],
             borderRadius: BorderRadius.circular(50),
              ),
              child: const CircleAvatar(
             radius: 20.0,
             child: Icon(Icons.monetization_on_outlined , size: 30, color: Colors.blue, ),
             backgroundColor: Colors.transparent,
              ),
            ),
            const SizedBox(height: 10,),
            const Text('Daily'),
            const Text('Deposit')
          ],),),

          GestureDetector(
            onTap: (){
               Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>const  SwapbatteryScreen(),
              ));
            },
            child: Column(
            children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(  
             color: Colors.green[50],
             borderRadius: BorderRadius.circular(50)
              ),
              child: const CircleAvatar(
             radius: 20.0,
             child: Icon(Icons.battery_alert_outlined , size: 30, color: Colors.green, ),
             backgroundColor: Colors.transparent,
              ),
            ),
            const SizedBox(height: 10,),
            const Text('Swap'),
            const Text('Battery')
          ],),),

          GestureDetector(
            onTap: (){
               Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>const  TransactionScreen(),
              ));
            },
            child: Column(
            children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(  
             color: Colors.orange[50],
             borderRadius: BorderRadius.circular(50)
              ),
              child: const CircleAvatar(
             radius: 20.0,
             child: Icon(Icons.history_edu_outlined , size: 30, color: Colors.orange, ),
             backgroundColor: Colors.transparent,
              ),
            ),
            const SizedBox(height: 10,),
            const Text('Account'),
            const Text('History')
          ],),),

          GestureDetector(
            onTap: () async {
               Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>const  BatteryStations(),
              ));
            },
            child: Column(
            children:[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(  
             color: Colors.purple[50],
             borderRadius: BorderRadius.circular(50)
              ),
              child: const CircleAvatar(
             radius: 20.0,
             child: Icon(Icons.charging_station_outlined , size: 30, color: Colors.purple, ),
             backgroundColor: Colors.transparent,
              ),
            ),
            const SizedBox(height: 10,),
            const Text('Battery'),
            const Text('Stations')
          ],),),
       
      ],),)

      ],): const Center(child: Text('Our team is working in your account. it may take upto 24 hours. use other services'),)
        ),
      )
    );
  }
}

//const Center(child: Text('Our team is working in your account. it may take upto 24 hours. use other services'),)