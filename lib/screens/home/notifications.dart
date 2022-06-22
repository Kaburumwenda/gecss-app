import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mobile/Animation/FadeAnimation.dart';
import 'package:mobile/models/models.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({ Key? key }) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Client client = http.Client();
  List<Notifications> _data = [];
  bool _isLoading = true;

   @override
  void initState() {
    super.initState();
   _getNotifications();
  }

  _getNotifications() async {
    _data = [];
    String url = 'http://192.168.1.9/v1/notifications';
    List resp = json.decode((await client.get(Uri.parse(url) )).body);
     resp.forEach((element) {
      _data.add(Notifications.fromJson(element));
    });
    setState(() {
       _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'.toUpperCase(), style:const TextStyle(color: Colors.white54, fontSize: 14),),
        leading:const BackButton(color: Colors.white54),
        backgroundColor: Colors.brown,
        elevation: 0.0,
        ),
      
      body: _isLoading ? const Center(child: CircularProgressIndicator(),) : FadeAnimation(
        0.8,
        Container(
          child: _data.isNotEmpty ? ListView.builder(
            itemCount: _data.length,
            itemBuilder: (ctx, i) => Container(
              color: Colors.white,
              margin:const EdgeInsets.fromLTRB(20, 10, 20, 10),
              padding:const EdgeInsets.all(8),
              child: Column(children: [
                Text(_data[i].title.toString(), style:const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54), ),
                const SizedBox(height: 20,),
                Text(_data[i].message.toString())
              ],),
            )
            ): const Center(child: Text('No notifications. please check again later'),),
        ),
      ),
    );
  }
}