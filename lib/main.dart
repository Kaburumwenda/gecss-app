import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/screens/screens.dart';

void main() async {
 SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.brown,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.brown,
      systemNavigationBarIconBrightness: Brightness.light ));
     
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gecss',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: Colors.grey[200]
      ),
      home:const SplashScreen(),
    );
  }
}
