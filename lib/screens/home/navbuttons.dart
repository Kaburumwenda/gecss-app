import 'package:flutter/material.dart';
import 'package:mobile/screens/screens.dart';

class NavButtonScreen extends StatelessWidget {
  const NavButtonScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[100],
      margin:const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Container(
        padding:const EdgeInsets.all(10),
        decoration: BoxDecoration(  
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        
        GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const DepositScreen(),
              ));
          },
          child: Column(
          children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(  
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: const CircleAvatar(
              radius: 20.0,
              child: Icon(Icons.monetization_on_outlined , size: 30, color: Colors.blue, ),
              backgroundColor: Colors.transparent,
            ),
          ),
          const Text('Daily'),
          const Text('Deposit')
        ],),),

        GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>const SwapbatteryScreen(),
            ));
          },
          child: Column(
          children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(  
              color: Colors.white,
              borderRadius: BorderRadius.circular(50)
            ),
            child: const CircleAvatar(
              radius: 20.0,
              child: Icon(Icons.battery_alert_outlined , size: 30, color: Colors.green, ),
              backgroundColor: Colors.transparent,
            ),
          ),
          const Text('Swap'),
          const Text('Battery')
        ],),),

        GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>const TransactionScreen(),
            ));
          },
          child: Column(
          children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(  
              color: Colors.white,
              borderRadius: BorderRadius.circular(50)
            ),
            child: const CircleAvatar(
              radius: 20.0,
              child: Icon(Icons.history_edu_outlined , size: 30, color: Colors.orange, ),
              backgroundColor: Colors.transparent,
            ),
          ),
          const Text('Account'),
          const Text('History')
        ],),),

        GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>const BatteryStations(),
            ));
          },
          child: Column(
          children:[
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(  
              color: Colors.white,
              borderRadius: BorderRadius.circular(50)
            ),
            child: const CircleAvatar(
              radius: 20.0,
              child: Icon(Icons.charging_station_outlined , size: 30, color: Colors.purple, ),
              backgroundColor: Colors.transparent,
            ),
          ),
          const Text('Battery'),
          const Text('Station')
        ],),),
       
      ],)),
    );
  }
}