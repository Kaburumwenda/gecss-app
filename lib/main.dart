import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mobile/screens/screens.dart';
import 'package:mobile/state/ads_state.dart';

AppOpenAd? openAd;

Future<void> loadAd() async {
  await AppOpenAd.load(
    adUnitId: AdsTypes.a1, 
    // adUnitId: "",
    request:const AdRequest(), 
    adLoadCallback: AppOpenAdLoadCallback(
      onAdLoaded: (ad) {
        openAd = ad;
        openAd!.show();
      }, 
      onAdFailedToLoad:(error){
        // ignore: avoid_print
        print('ad failed to load $error');
      }
      ),
      orientation: AppOpenAd.orientationPortrait
    );
}

void main() async {
 SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.brown,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.brown,
      systemNavigationBarIconBrightness: Brightness.light ));

      WidgetsFlutterBinding.ensureInitialized();
      MobileAds.instance.initialize();
      await loadAd();
     
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gecss Operations',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: Colors.grey[200]
      ),
      home:const SplashScreen(),
    );
  }
}
