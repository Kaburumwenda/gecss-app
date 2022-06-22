import 'dart:convert';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mobile/Animation/FadeAnimation.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/screens/home/home_screen.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

late ProgressDialog pr;

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screens';
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LocalStorage storage =  LocalStorage('usertoken');

  String _username = '';
  String _password = '';
  String _loginErr = '';
  final _form = GlobalKey<FormState>();
  bool _isObscure = true;

  void _loginNew() async {
    var isvalid = _form.currentState!.validate();
    if (!isvalid) {
      return;
    }
    _form.currentState!.save();
    await pr.show();
    String url = 'http://192.168.1.9/v1/auth/login';

      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({"username": _username, "password": _password}));
      var data = json.decode(response.body) as Map;

      if (data.containsKey("token")) {
        storage.setItem("token", data['token']);
        await pr.hide();
        Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const HomeScreen(),
        ));
      }

      if(data['non_field_errors'][0].length > 0 ){
      await pr.hide();
        _loginErr = data['non_field_errors'][0];
        ArtSweetAlert.show(
          barrierDismissible: false,
          context: context,
          artDialogArgs: ArtDialogArgs(
            title: _loginErr,
            confirmButtonText: "Ok",
            type: ArtSweetAlertType.danger
          ));
      }
   
  }

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context, showLogs: true, isDismissible: false, );
    pr.style(message: 'Autheticating ...', );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.brown,
        title:const Text("Login", style: TextStyle(color: Colors.white54 ),),
        leading:const BackButton(color: Colors.white54 ),
      ),
      body: FadeAnimation(
        0.8,
        Container(
          padding:const EdgeInsets.all(20),
          child: SingleChildScrollView(  
            child:Form(
              key: _form,
              child: Column(
                children: [
      
                  Column(children: [
                    Image.asset('assets/images/launcher.png', width: 60,),
                    const Text('GECSS')
                  ]),

                   const SizedBox(height: 40,),
                   TextFormField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Enter Your member number';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.brown[100],
                      filled: true,
                      hintText: "Member number",
                      labelText: 'Member number'
                    ),
                    onSaved: (v) {
                      _username = v!;
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Enter Your password';
                      }
                      return null;
                    },
                    obscureText: _isObscure,
                    decoration:InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.brown[100],
                      filled: true,
                      hintText: "Password",
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        }, 
                        icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off, color: Colors.brown, size: 35,)
                        )
                    ),
                    onSaved: (v) {
                      _password = v!;
                    },
                  ),
                  const SizedBox(height: 60.0,),
                  Row(children: [
                    Expanded(
                      child:ElevatedButton(
                        onPressed: () {
                          _loginNew();
                        },
                        child:const Text("Login", style: TextStyle(fontSize: 20.0),),
                        style: ElevatedButton.styleFrom(
                          primary:Colors.brown,
                          padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ),
                      )
                  ],),
      
                 
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}
