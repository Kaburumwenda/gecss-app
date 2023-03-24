import 'dart:convert';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mobile/endpoints/endpoint.dart';
import 'package:mobile/models/models.dart';

class BatteryConsole extends StatefulWidget {
  const BatteryConsole({ Key? key }) : super(key: key);

  @override
  State<BatteryConsole> createState() => _BatteryConsoleState();
}

class _BatteryConsoleState extends State<BatteryConsole> {

  LocalStorage storage = LocalStorage('usertoken');
  Client client = http.Client();
  List<Battery> _data = [];
  final _form = GlobalKey<FormState>();
  bool _isLoading = true;

  List listOfColumns = [];
  List _branches = [];
  var branchdropdownvalue;
  var branchStatus;

  int _batteries = 0;
  int _charged = 0;
  int _charging = 0;
  int _depleted = 0;
  int _issued = 0;


  @override
  void initState() {
    super.initState();
     _getBatteries();
     _getBatteryStatistics();
     _getBranches();
  }


  Future _getBatteries() async {
    var token = storage.getItem('token');
    var baseur = AdsType.baseurl;
    String baseUrl = '$baseur/v1/batteries';
    http.Response response = await http.get(Uri.parse(baseUrl),
    headers: {
            "Content-Type": "application/json",
            'Authorization': "token $token"
          }
     );

     setState(() {
       _isLoading = false;
     });

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        listOfColumns = jsonData;
      });
    }
  }


  Future _getBatteryStatistics() async {
    var token = storage.getItem('token');
    var baseur = AdsType.baseurl;
    String baseUrl = '$baseur/v1/battery/statistics';
    http.Response response = await http.get(Uri.parse(baseUrl),
    headers: {
            "Content-Type": "application/json",
            'Authorization': "token $token"
          }
     );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
          _batteries = jsonData['batteries'];
          _charged = jsonData['charged'];
          _charging = jsonData['charging'];
          _depleted = jsonData['depleted'];
          _issued = jsonData['issued'];
      });
    }
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
        _branches = jsonData;
      });
    }
  }


  _filterBraches() async {

     if( branchdropdownvalue !=null && branchStatus !=null ){
       setState(() {
       _isLoading = true;
     });
      var token = storage.getItem('token');
      var baseur = AdsType.baseurl;
      String baseUrl = '$baseur/v1/battery/filters';
      http.Response response = await http.post(Uri.parse(baseUrl),
      body: json.encode({
              'loc': branchdropdownvalue,
              'status': branchStatus
            }),
      headers: {
              "Content-Type": "application/json",
              'Authorization': "token $token"
            }
      );
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          listOfColumns = jsonData;
        });
        _filterBrachStatistics();
      }
      setState(() {
        _isLoading = false;
      });
     } else{
      ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.danger,
          title: "Opps !!!!. Please ensure Status & Swap center is selected",
        )
      );
     }
  }

  _filterBrachStatistics() async {
    var token = storage.getItem('token');
    var baseur = AdsType.baseurl;
    String baseUrl = '$baseur/v1/battery/operations/statistics';
    http.Response response = await http.post(Uri.parse(baseUrl),
    body: json.encode({
            'loc': branchdropdownvalue,
          }),
    headers: {
            "Content-Type": "application/json",
            'Authorization': "token $token"
          }
     );
     if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        _batteries = jsonData['batteries'];
        _charged = jsonData['charged'];
        _charging = jsonData['charging'];
        _depleted = jsonData['depleted'];
        _issued = jsonData['issued'];
      });
    }
  }


  _resetToDefault(){
    setState(() {
       _isLoading = true;
     });
    _getBatteries();
    _getBatteryStatistics();
    _getBranches();
    setState(() {
       _isLoading = false;
     });
   }


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Battery Console'.toUpperCase(), style:const TextStyle(fontSize: 14, color: Colors.white70,  ),),
        leading:const BackButton(color: Colors.white54 ),
      ),
    body: Column(
      children: [
        // FILTERS START 
        Container(
          padding:const EdgeInsets.fromLTRB(20, 10, 20, 5),
          color: Colors.grey[100],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            const Text('Filter by.'),

          // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> DROPDOWN
            DropdownButton<String>(
              hint:const Text('Status'),
              items: <String>["Charged", "Charging", "Depleted", "Issued"].map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (newVal) {
                 setState(() {
                  branchStatus = newVal;
                });
              },
              value: branchStatus,
            ),

            DropdownButton(
              hint:const Text('Swap center'),
              items: _branches.map((item) {
                return DropdownMenuItem(
                  value: item['title'].toString(),
                  child: Text(item['title'].toString()),
                );
              }).toList(),
              onChanged: (newVal) {
                setState(() {
                  branchdropdownvalue = newVal;
                });
              },
              value: branchdropdownvalue,
            ),
            // // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> DROPDOWN
          ],)),

          Container(
            padding:const EdgeInsets.only(right: 20),
            color: Colors.grey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

              ElevatedButton.icon(
                  onPressed: (){
                  _filterBraches();
                }, 
                icon:const Icon(Icons.sort_outlined ), 
                label: const Text('Filter'),
                style: ElevatedButton.styleFrom(
                  primary:Colors.grey[200],
                  onPrimary: Colors.black,
                  //padding:const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(width: 20.00,),

              ElevatedButton.icon(
                onPressed: (){
                  _resetToDefault();
                }, 
                icon:const Icon(Icons.refresh_outlined ), 
                label: const Text('Reset'),
                style: ElevatedButton.styleFrom(
                  primary:Colors.grey[200],
                  onPrimary: Colors.black,
                  //padding:const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              )

            ],),
          ),
        // fILTERS END
        // counts start
        Container(
          color: Colors.white,
          padding:const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Column(children: [
              Text('Total'.toUpperCase(), style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black54 ), ),
              Text(_batteries.toString(), style: const TextStyle( color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),)
            ]),
            Column(children: [
              Text('Charged'.toUpperCase(), style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black54 ), ),
              Text(_charged.toString(), style: const TextStyle( color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),)
            ]),
            Column(children:[
              Text('Depleted'.toUpperCase(), style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black54) ),
              Text(_depleted.toString(), style: const TextStyle( color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16))
            ]),
            Column(children:[
              Text('Issued'.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black54), ),
              Text(_issued.toString(), style: const TextStyle( color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16))
            ]),
            Column(children:[
              Text('Charging'.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black54), ),
              Text(_charging.toString(), style: const TextStyle( color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16))
            ]),
          ],),
        ),
        // counts end
        Divider(color: Colors.grey[100], thickness:1, height:1, indent:1, endIndent:1,),

        Expanded(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.fromLTRB(2, 10, 2, 10),
              //margin:const EdgeInsets.only(top: 0, bottom: 20),
              decoration: BoxDecoration(  
                color: Colors.white,
                borderRadius: BorderRadius.circular(2)
              ),
              child: _isLoading ? const Center(child: RefreshProgressIndicator(),) : DataTable(
                sortColumnIndex: 0,
                sortAscending: true,
                columns:const [
                  DataColumn(label: Text('Code')),
                  DataColumn(label: Text('Location')),
                  DataColumn(label: Text('Status')),
                ],
                rows:
                  listOfColumns // Loops through dataColumnText, each iteration assigning the value to element
                      .map(
                        ((element) => DataRow(
                              cells: <DataCell>[
                                DataCell(Text(element["code"])), //Extracting from Map element the value
                                DataCell(Text(element["location"])),
                                DataCell(
                                  element["status"] == 'Charged' ?
                                  Container(child: Text(element["status"], textAlign: TextAlign.center,  style:const TextStyle(color: Colors.white70),), width: 70.00,  padding: const EdgeInsets.all(5), color: Colors.cyan )
                                  : element["status"] == 'Charging' ? 
                                  Container(child: Text(element["status"], textAlign: TextAlign.center,  style:const TextStyle(color: Colors.white70),), width: 70.00, padding: const EdgeInsets.all(5), color: Colors.blue )
                                  : element["status"] == 'Issued' ?
                                  Container(child: Text(element["status"], textAlign: TextAlign.center,  style:const TextStyle(color: Colors.white70),), width: 70.00, padding: const EdgeInsets.all(5), color: Colors.green )
                                  : element["status"] == 'Depleted' ?
                                  Container(child: Text(element["status"], textAlign: TextAlign.center,  style:const TextStyle(color: Colors.white70),), width: 70.00, padding: const EdgeInsets.all(5), color: Colors.orange )
                                  : Container(child: Text(element["status"], textAlign: TextAlign.center,  style:const TextStyle(color: Colors.white70),), width: 70.00, padding: const EdgeInsets.all(5), color: Colors.grey )
                                ),
                              ],
                            )),
                      )
                      .toList(),
                ),
            ),
          ),
        ),
      ],
    ),
    );
  }
}