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
              builder: (BuildContext context) => const BatteryConsole(),
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
              child: Icon(Icons.ev_station_outlined , size: 30, color: Colors.blue, ),
              backgroundColor: Colors.transparent,
            ),
          ),
          const SizedBox(height: 5,),
          const Text('Batteries'),
        ],),),

        GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>const BatteryAssign(),
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
          const Text('Assign'),
          const Text('Batteries')
        ],),),

        GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>const BatteryCharging(),
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
          const Text('Charging'),
          const Text('battery')
        ],),),

        GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>const BatteryCharged(),
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
          const Text('Charged'),
          const Text('Battery')
        ],),),
       
      ],)),
    );
  }
}