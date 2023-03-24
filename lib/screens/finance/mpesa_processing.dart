import 'dart:convert';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/endpoints/endpoint.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/screens/screens.dart';

class MpesaProcess extends StatefulWidget {
  final customerid;
  final respmsg;
  final mobile;
  final amount;
  const MpesaProcess({ Key? key, this.customerid, this.respmsg, this.amount, this.mobile }) : super(key: key);

  @override
  State<MpesaProcess> createState() => _MpesaProcessState();
}

class _MpesaProcessState extends State<MpesaProcess> {
  LocalStorage storage = LocalStorage('usertoken');
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var _msg= widget.respmsg;
    print('###############################');
    print(widget.customerid);
    print(widget.respmsg);
  }

  _confirmPayment() async {
    setState(() {
      _isLoading = true;
    });

    var baseur = AdsType.baseurl;
    String _url = "$baseur/mpesa/cipher";
    var token = storage.getItem('token');
    try {
      http.Response response = await http.post(Uri.parse(_url),
          body: json.encode({
            "amount":widget.amount,
            "mobile": widget.mobile,
            "checkoutid": widget.customerid
          }),
          headers: {
            "Content-Type": "application/json",
            'Authorization': "token $token"
          });
          var data = json.decode(response.body) as Map;
          var _errcode = data['error'];
          var _respmsg = data['success'];

          if(_errcode == '0'){
              ArtDialogResponse response = await ArtSweetAlert.show(
                  barrierDismissible: false,
                  context: context,
                  artDialogArgs: ArtDialogArgs(
                    type: ArtSweetAlertType.success,
                    title: "$_respmsg ",
                    confirmButtonText: "   Okay   ",
                  )
                );

                if(response==null) {
                  return;
                }

                if(response.isTapConfirmButton) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const HomeScreen(),
                     ));
                  return;
                }
          }


          if(_errcode != '0'){
            ArtDialogResponse response = await ArtSweetAlert.show(
                  barrierDismissible: false,
                  context: context,
                  artDialogArgs: ArtDialogArgs(
                    type: ArtSweetAlertType.danger,
                    title: "$_respmsg ",
                    confirmButtonText: "   Okay   ",
                  )
                );

                if(response==null) {
                  return;
                }

                if(response.isTapConfirmButton) {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (BuildContext context) => const DepositScreen(),
                  //    ));
                  return;
                }
          }
          
           setState(() {
            _isLoading = false;
          });

    } catch (e) {
      // print("e favoritButton");
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  
        backgroundColor: Colors.brown,
        title: const Text('Mpesa confirmation', style: TextStyle(fontSize: 16, color: Colors.white54),),
        elevation: 0,
        leading:const BackButton(color: Colors.white54 ),
      ),
      body: Container(
        padding:const EdgeInsets.all(10),
        child: ListView(children: [
          Lottie.asset('assets/lottie/clock.json', height: 200), 
          Center(child: Text(widget.respmsg, 
          style:const TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),)),
          const SizedBox(height: 20,),
          const Center(child: Text('Please after payment click the button below to confirm your payments', 
          style:TextStyle(color: Colors.black54, fontSize: 18),)),

          const SizedBox(height: 40,),

            Row(children: [
              Expanded(
                child: _isLoading  ? ElevatedButton(
                  onPressed: null,
                  child:const Text("Processing ...", style: TextStyle(fontSize: 18.0),),
                  style: ElevatedButton.styleFrom(
                    primary:Colors.brown,
                    padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                )
                : 
                ElevatedButton(
                  onPressed: () {
                  _confirmPayment();
                  },
                  child:const Text("Confirm Payment", style: TextStyle(fontSize: 18.0),),
                  style: ElevatedButton.styleFrom(
                    primary:Colors.orange,
                    padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),

                )
            ],),

        ]),
      ),
    );
  }
}