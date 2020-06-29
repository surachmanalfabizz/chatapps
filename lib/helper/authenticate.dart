import 'package:chatapps/views/signin.dart';
import 'package:chatapps/views/signup.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget{
  @override
  _AuthenticateState createState() => _AuthenticateState();


}

class _AuthenticateState extends State<Authenticate>{
  bool signIn = true;

  void toogleView(){
    setState(() {
      signIn = !signIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(signIn){
      return SignIn(toogleView);
    }else{
      return SignUp(toogleView);
    }
  }

}