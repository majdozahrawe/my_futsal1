import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:my_futsal/loginsuccess.dart';
import 'package:my_futsal/screens/home_screen.dart';
import 'package:my_futsal/screens/login_reg/ui/signup.dart';

class LoginSuccess extends StatefulWidget{
  final String email;
  const LoginSuccess({Key key, this.email}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginSuccess();
  }
}

class _LoginSuccess extends State<LoginSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child:Container(
            constraints: BoxConstraints(
                minHeight:MediaQuery.of(context).size.height
            ),
            width:MediaQuery.of(context).size.width,
            decoration:BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [ Colors.blue,Colors.blueAccent,
                  Colors.blue,Colors.blueAccent,
                ],
              ),
            ),

            padding: EdgeInsets.all(20),
            child:Column(children:<Widget>[

              Container(
                margin: EdgeInsets.only(top:80),
                child: Text("Login Successfully", style: TextStyle(
                    color:Colors.white,fontSize: 40, fontWeight: FontWeight.bold
                ),),
              ),

              SizedBox(height: 30.0),
              Container(
                  height: 390,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    child: Image.asset(('assets/images/goal.png'),),)
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top:20),
                child: SizedBox(
                  height: 60, width: 200,
                  child:RaisedButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Text("Continue", style: TextStyle(fontSize: 20),),
                    colorBrightness: Brightness.dark,
                    color: Colors.lightGreen,
                    shape: RoundedRectangleBorder(
                        borderRadius:BorderRadius.circular(30)
                    ),
                  ),
                ),
              ),
            ]),
          )
      ),
    );
  }


}