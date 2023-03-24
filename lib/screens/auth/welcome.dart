import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/screens/auth/login.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome', style: TextStyle(color: Colors.white54),),
        centerTitle: true,
        elevation: 0.0,
      ),

      body: Container(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Center(child: Image.asset('assets/images/launcher.png', width: 60,),),
            const Text('GECSS OPERATIONS'),
            Lottie.asset('assets/lottie/bike.json'), 
            const SizedBox(height: 20,),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  const Padding(
                    padding:EdgeInsets.only(left: 20),
                    child: Text('Electric Bikes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green ),),
                    ),
                   const  Padding(
                    padding:EdgeInsets.only(left: 20),
                    child: Text('GECSS - We are the Future'),
                    ),
                  const SizedBox(height: 40,),

                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>const LoginScreen(),
                        ));
                      },
                      child:const Text("        Login        ", style: TextStyle(fontSize: 20.0),),
                      style: ElevatedButton.styleFrom(
                        primary:Colors.brown,
                        padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    )
                  ],),

                ],)
                )
              )

        ],),
      ),
    );
  }
}