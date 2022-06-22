import 'package:flutter/material.dart';
import 'package:mobile/screens/screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   int index = 0;
    final screens = [
      const DashboardScreen(),
      const TransactionScreen(),
      const SwapbatteryScreen(),
      const UserProfile(),
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
          icon: Icon(Icons.auto_graph_outlined , size: 30, color: Colors.grey[400],), 
          selectedIcon:const Icon(Icons.auto_graph_outlined , size: 30, color: Colors.green,),
          label: 'Transactions'
          ),
        NavigationDestination(
          icon: Icon(Icons.battery_alert_rounded , size: 30, color: Colors.grey[400], ), 
          selectedIcon: const Icon(Icons.battery_alert_outlined , size: 30, color: Colors.green, ),
          label: 'Battery'
          ),
        NavigationDestination(
          icon: Icon(Icons.person, size: 30, color: Colors.grey[400],  ), 
          selectedIcon: const Icon(Icons.person, size: 30,  color: Colors.green, ),
          label: 'Profile'
          ),
      ]),
        ),
    );
  }
}