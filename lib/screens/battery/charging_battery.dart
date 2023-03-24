import 'dart:convert';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mobile/endpoints/endpoint.dart';
import 'package:mobile/screens/screens.dart';

class BatteryCharging extends StatefulWidget {
  const BatteryCharging({ Key? key }) : super(key: key);

  @override
  State<BatteryCharging> createState() => _BatteryChargingState();
}

class _BatteryChargingState extends State<BatteryCharging> {

  LocalStorage storage = LocalStorage('usertoken');
  Client client = http.Client();
  // List<MpesaTransaction> _data = [];
  bool _isLoading = true;
  List categoryItemlist = [];
  var dropdownvalue;
  String? scanResult='-';
  final _form = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    // _getBranches();
    _getBranches();
  }

  _refreshTrans() {
    // _getMpesaTrans();
  }



  Future _getBranches() async {
    var token = storage.getItem('token');
    var baseur = AdsType.baseurl;
    String baseUrl = '$baseur/v1/branches';
    http.Response response = await http.get(Uri.parse(baseUrl),
    headers: {
            "Content-Type": "application/json",
            'Authorization': "token $token"
          }
     );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        categoryItemlist = jsonData;
      });
    }
  }

  _assignBatteries() async {
    var isvalid = _form.currentState!.validate();
    if (!isvalid) {
      return;
    }

    _form.currentState!.save();

    var _scan_len = scanResult!.length;
    var _branch_len = dropdownvalue!.length;

    if( _scan_len > 5 && _branch_len > 2 ){ 
      await pr.show();
      var baseur = AdsType.baseurl;
      String _url = "$baseur/v1/battery/operations/charging";
      var token = storage.getItem('token');
            try{

        http.Response response = await http.post(Uri.parse(_url),
          body: json.encode({
            'batteryCode': scanResult,
            'branch': dropdownvalue
          }),
          headers: {
            "Content-Type": "application/json",
            'Authorization': "token $token"
          });

          var _data = json.decode(response.body) as Map;
          await pr.hide();
          var _errcode = _data['error'];
          var _responsemsg = _data['message'];
           if(_errcode == '0'){
              ArtDialogResponse response = await ArtSweetAlert.show(
                  barrierDismissible: false,
                  context: context,
                  artDialogArgs: ArtDialogArgs(
                    type: ArtSweetAlertType.success,
                    title: "$_responsemsg ",
                    confirmButtonText: "   Okay   ",
                    //denyButtonText: "Scan another"
                  )
                );

                if(response==null) {
                  return;
                }

                if(response.isTapConfirmButton) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const BatteryCharging(),
                     ));
                  return;
                }
                if(response.isTapDenyButton) {
                  return;
                }

           }


          if(_errcode != '0'){
            ArtDialogResponse response = await ArtSweetAlert.show(
                  barrierDismissible: false,
                  context: context,
                  artDialogArgs: ArtDialogArgs(
                    type: ArtSweetAlertType.danger,
                    title: "$_responsemsg ",
                    confirmButtonText: "   Okay   ",
                  )
                );

                if(response==null) {
                  return;
                }

                if(response.isTapConfirmButton) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const BatteryCharging(),
                     ));
                  return;
                }
          }

      }
       catch(e){
         return e;
       }
    } else{
      ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.danger,
          title: "Opps !!!!. No battery scanned",
        )
      );
    }
    // END IF
  }

  
  @override
  Widget build(BuildContext context) {
    pr.style(message: 'Sending ...', );
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Charging Batteries'.toUpperCase(), style:const TextStyle(fontSize: 14, color: Colors.white70,  ),),
        leading:const BackButton(color: Colors.white54 ),
      ),
      body: Column(children: [
        SingleChildScrollView(
          child: Container(
            margin:const EdgeInsets.all(20),
            padding:const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(  
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
          child: Form(
            key: _form,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Row(children:const [
                    Icon(Icons.ev_station_outlined , size: 40, color: Colors.green, ),
                    Text('Charging centers', style: TextStyle(fontSize: 16),),
                  ],),
                  Row(
                    children: [
                      DropdownButton(
                        hint:const Text('Select battery charging center'),
                        items: categoryItemlist.map((item) {
                          return DropdownMenuItem(
                            value: item['title'].toString(),
                            child: Text(item['title'].toString()),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            dropdownvalue = newVal;
                          });
                        },
                        value: dropdownvalue,
                      ),
                    ],
                  ),
                ],),
            
            const SizedBox(height: 20,),

            Container(
              child: ( scanResult!.length < 4 ) ?ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary:Colors.amber,
                  onPrimary: Colors.black,
                  padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
                onPressed: scanBarcodes , 
                icon:const Icon(Icons.camera_alt_outlined, size: 40, ), 
                label: const Text('Scan Battery', style: TextStyle(fontSize: 16), )
                )
                :
                ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary:Colors.amber,
                  onPrimary: Colors.black,
                  padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
                onPressed: null, 
                icon:const Icon(Icons.camera_alt_outlined, size: 40, ), 
                label: const Text('Scan Battery', style: TextStyle(fontSize: 16), )
                ),
            ),
      
            const SizedBox(height: 20.0,),
      
            Text(
              scanResult == null ? 'Please click the above button to start scanning battery'
              : 'Scan result: $scanResult ',
              style:const TextStyle(fontSize: 18,),
            ),
      
       const SizedBox(height: 40.0,),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _assignBatteries(), 
                    icon:const Icon(Icons.send_time_extension_outlined, size: 40, ), 
                    label: const Text('Submit now', style: TextStyle(fontSize: 20), ),
                    style: ElevatedButton.styleFrom(
                        // primary:Colors.amber,
                        // onPrimary: Colors.black,
                        padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                ),
              ],
            ),

            const SizedBox(height: 50,),
          ],)),
        ),)
      ]),
      
    );
  }

  Future scanBarcodes() async {
    String scanResult;

    try{
      scanResult = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      "Cancel",
      true,
      ScanMode.BARCODE
     );
    } on PlatformException{
      scanResult = 'Failed to get platform version';
    }
    if (!mounted) return;
    setState(() => this.scanResult = scanResult  );
  }

  
}