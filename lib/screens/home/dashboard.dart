import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mobile/endpoints/endpoint.dart';
import 'package:mobile/models/models.dart';
import 'package:mobile/screens/screens.dart';
import 'package:mobile/state/ads_state.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({ Key? key }) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Client client = http.Client();
  List<Notifications> _data = [];
  bool _isLoading = true;
  int _note = 0;
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;

   @override
  void initState() {
    super.initState();
   _getNotifications();
   _initBannerAd();
  }

  _getNotifications() async {
    _data = [];
    var baseur = AdsType.baseurl;
    String url = '$baseur/v1/notifications';
    List resp = json.decode((await client.get(Uri.parse(url) )).body);
     resp.forEach((element) {
      _data.add(Notifications.fromJson(element));
    });

    _note = _data.length;

    setState(() {
       _isLoading = false;
    });
  }


_initBannerAd(){
  _bannerAd = BannerAd(
    size: AdSize.mediumRectangle, 
     adUnitId: AdsTypes.b1,
    listener: BannerAdListener(
      onAdLoaded: (ad){
        setState(() {
          _isAdLoaded = true;
        });
      },
      onAdFailedToLoad: (ad, error){
        print('error');
      }
    ), 
    request:const AdRequest()
    );

    _bannerAd.load();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        centerTitle: true,
        elevation: 0.0,
        title:Text('Gecss operations'.toUpperCase(), style:const TextStyle(color: Colors.white54, fontSize: 16),),
          leading: IconButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const UserProfile(),
              ));
          }, 
          icon: Container(
            padding:const EdgeInsets.fromLTRB(5, 5, 5, 5),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.orange[200],),
            child:const Icon(Icons.person)
            ), 
          color: Colors.black54,
          ),
        actions: [
          TextButton.icon(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>const NotificationScreen(),
              ));
            }, 
            icon: const Icon(Icons.notifications, color: Colors.amber, ), 
            label: Text( _note.toString(), style:const TextStyle(color: Colors.red),),
            style: ElevatedButton.styleFrom(
              primary:Colors.brown,
              padding:const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1),
              ),
            ),
            )
        ],
        ),
        body: Column(children:[
          const WalletDisplay(),
          const NavButtonScreen(),

          const Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Text('RECENT ACTIVITIES', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),),
            ),

            const SizedBox(height: 20,),

         Container(child:_isAdLoaded ? Container(
              alignment: Alignment.center,
              color: Colors.white,
              height: _bannerAd.size.height.toDouble(),
              width: _bannerAd.size.width.toDouble(),
              child:  AdWidget(ad: _bannerAd,),
              ):const SizedBox.shrink() ,) 
        ],),
    );
  }
}