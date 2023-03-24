import 'package:flutter/material.dart';
import 'package:mobile/screens/screens.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   int index = 0;
    final screens = [
      const DashboardScreen(),
      const BatteryConsole(),
      const BatteryAssign(),
      const BatteryCharged(),
    ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
       bottomNavigationBar:NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.blue.shade100,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white54)
          )
          ),
        child: NavigationBar(
        backgroundColor: Colors.brown,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        animationDuration:const Duration(seconds: 3),
        selectedIndex: index,
        onDestinationSelected: (index) => 
         setState(() {
           this.index = index;
         }),
        destinations: [
        NavigationDestination(
          icon: Icon(Icons.home, size: 30, color: Colors.grey[400], ), 
          selectedIcon: const Icon(Icons.home, size: 30, color: Colors.green, ), 
          label: 'Home'
          ),
        NavigationDestination(
          icon: Icon(Icons.ev_station_outlined , size: 30, color: Colors.grey[400],), 
          selectedIcon:const Icon(Icons.ev_station_outlined , size: 30, color: Colors.green,),
          label: 'Batteries'
          ),
        NavigationDestination(
          icon: Icon(Icons.battery_alert_outlined , size: 30, color: Colors.grey[400], ), 
          selectedIcon: const Icon(Icons.battery_alert_outlined , size: 30, color: Colors.green, ),
          label: 'Assign'
          ),
        NavigationDestination(
          icon: Icon(Icons.charging_station_outlined, size: 30, color: Colors.grey[400],  ), 
          selectedIcon: const Icon(Icons.charging_station_outlined, size: 30,  color: Colors.green, ),
          label: 'Charged'
          ),
      ]),
        ),

      floatingActionButton: FloatingActionButton(
      onPressed: () async {
         final Uri launchUri = Uri(
            scheme: 'tel',
              path: '+254114166024'
            );
            if ( await canLaunch(launchUri.toString())) {
              await launch(launchUri.toString());
            } else{
              // ignore: avoid_print
              print(" the action is not supported. (No phone app)");
            }
      },
      child:const Icon(Icons.call ),
      backgroundColor: Colors.blue,
    ),

    );
  }
}