import 'dart:convert';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mobile/Animation/FadeAnimation.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

late ProgressDialog _pr;

class SwapbatteryScreen extends StatefulWidget {
  const SwapbatteryScreen({ Key? key }) : super(key: key);

  @override
  State<SwapbatteryScreen> createState() => _SwapbatteryScreenState();
}

class _SwapbatteryScreenState extends State<SwapbatteryScreen> {
  LocalStorage storage = LocalStorage('usertoken');
  String _phone = '';
  final _form = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
     _pr = ProgressDialog(context, showLogs: true, isDismissible: false, );
     _pr.style(message: 'Please wait...', );
    return Scaffold(
      appBar: AppBar(  
        backgroundColor: Colors.brown,
        title: const Text('Swap Battery', style: TextStyle(fontSize: 16, color: Colors.white54),),
        elevation: 0,
        leading:const BackButton(color: Colors.white54 ),
      ),

      body: FadeAnimation(
        0.8,
        Container(
        padding:const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(children: [
            Image.asset('assets/images/mpesa.png', width: 200,),
            const Text('Pay battery swap charges of KES 300 with mpesa', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            const Text('Please enter valid mpesa number', style: TextStyle(color: Colors.blue),),
            const SizedBox(height: 20,),

            TextFormField(
              validator: (v) {
                if (v!.isEmpty) {
                  return 'Enter mpesa number';
                }
                return null;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.brown[200],
                filled: true,
                hintText: "mpesa number",
                labelText: 'mpesa number'
              ),
              onSaved: (v) {
                _phone = v!;
              },
            ),
            const SizedBox(height: 40,),

            Row(children: [
                  Expanded(
                    child:ElevatedButton(
                      onPressed: () {
                      // _applyNow();
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (BuildContext context) => const LoanSuccess(),
                      //   ));
                      },
                      child: _isLoading ? const CircularProgressIndicator() : const Text("Pay Now", style: TextStyle(fontSize: 18.0),),
                      style: ElevatedButton.styleFrom(
                        primary:Colors.brown,
                        padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    ),
                    )
                ],),


          ],))
          ,)
      ),
      )
    );
  }
}