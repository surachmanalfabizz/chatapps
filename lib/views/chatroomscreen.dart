import 'package:chatapps/helper/authenticate.dart';
import 'package:chatapps/services/auth.dart';
import 'package:chatapps/views/search.dart';
import 'package:chatapps/views/signin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget{

  final String uid;
  ChatRoom(this.uid);

  @override
  _ChatState createState() => _ChatState();

}

class _ChatState extends State<ChatRoom>{
  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/logo.png', height: 50),
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              _authService.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Authenticate()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.exit_to_app),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=> SearchScreen()));
        },
      ),
    );
  }

}