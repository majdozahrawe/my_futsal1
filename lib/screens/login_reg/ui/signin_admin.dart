import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:my_futsal/loginsuccess.dart';
import 'package:my_futsal/screens/home_screen_admin.dart';
import 'package:my_futsal/screens/login_reg/ui/signin.dart';
import 'package:my_futsal/screens/login_reg/ui/signup.dart';
import 'package:my_futsal/screens/login_reg/ui/signup_admin.dart';

import '../../home_screen.dart';
//import http package manually

class SignInPageAdmin extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _SignInPageAdmin();
  }

}

class _SignInPageAdmin extends State<SignInPageAdmin> {
HomePageAdmin v = HomePageAdmin();

  bool  showprogress;
  String email, password;

  bool visible = false;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();


  Future loginAdmin() async {
    setState(() {
      showprogress = true;
    });
    String email = emailController.text;
    String password = passwordController.text;

    var apiurl = 'https://myfutsal123.000webhostapp.com/admin_login.php';
    var data = {'email': email, 'password': password};
    var res = await http.post(apiurl, body: json.encode(data));
    var message = jsonDecode(res.body);

    if (message == 'Success') {
      setState(() {
        showprogress = false;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePageAdmin(email: emailController.text)));
    } else {
      setState(() {
        showprogress = false;
      });

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(20.0)),
              child: Container(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 320.0,
                        child: RaisedButton(
                          onPressed: () {},
                          child: Text(
                            message,
                            style: TextStyle(color: Colors.white),
                          ),
                          color: const Color(0xFFCD1616),
                        ),
                      ),
                      FlatButton(
                        child:new Text("OK"),
                        onPressed: () {
                          showprogress = false;
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          });

    }
  }



  @override
  void initState() {
    email = "";
    password = "";
    showprogress = false;
    super.initState();
  }

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
                colors: [ Colors.green,Colors.greenAccent,
                  Colors.green,Colors.greenAccent,
                ],
              ),
            ),

            padding: EdgeInsets.all(20),
            child:Column(children:<Widget>[

              Container(
                margin: EdgeInsets.only(top:80),
                child: Text("Sign Into My Futsal", style: TextStyle(
                    color:Colors.white,fontSize: 40, fontWeight: FontWeight.bold
                ),),
              ),

              Container(
                margin: EdgeInsets.only(top:10),
                child: Text("Sign In As Admin", style: TextStyle(
                    color:Colors.white,fontSize: 15
                ),),
              ),
              SizedBox(height: 30.0),
              Container(
                  height: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 0.0,
                          color: Colors.black26,
                          offset: Offset(1.0, 10.0),
                          blurRadius: 20.0),
                    ],
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: GestureDetector(
                    onTap: (){
                    },
                    child: Image.asset(('assets/images/stad.png'),),)
              ),

              Container(
                padding: EdgeInsets.fromLTRB(10,0,10,0),
                margin: EdgeInsets.only(top:10),
                child: TextFormField(
                  controller: emailController,
                  style:TextStyle(color:Colors.blue, fontSize:20),
                  decoration: myInputDecoration(
                    label: "Email",
                    icon: Icons.person,
                  ),
                  onChanged: (value){
                    email = value;
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: passwordController,
                  style: TextStyle(color:Colors.blue, fontSize:20),
                  obscureText: true,
                  decoration: myInputDecoration(

                    label: "Password",
                    icon: Icons.lock,
                  ),
                  onChanged: (value){
                    password = value;
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top:20),
                child: SizedBox(
                  height: 60, width: 200,
                  child:RaisedButton(
                    onPressed: (){
                      setState(() {
                        showprogress = true;
                      });
                      if((emailController.text).isEmpty){

                        Fluttertoast.showToast(
                            msg: "Email is Empty",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            timeInSecForIos: 4
                        );
                      }
                      // else if((emailController.text)==(emailController.text+"Admin") &&(passwordController.text).isNotEmpty){
                      //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePageAdmin()));
                      // }

                      else if((passwordController.text).isEmpty){
                        Fluttertoast.showToast(
                            msg: "Password is Empty",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            timeInSecForIos: 4
                        );
                      }
                      else{
                        loginAdmin();
                      }
                    },

                    child: showprogress?
                    SizedBox(
                      height:30, width:30,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blue[100],
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ) : Text("LOGIN NOW", style: TextStyle(fontSize: 20),),
                    colorBrightness: Brightness.dark,
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius:BorderRadius.circular(30)
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top:20),
                child: InkResponse(
                    onTap:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInPage()));
                    },
                    child:Text("Do you have user Account ? SignIn",
                      style: TextStyle(color:Colors.white, fontSize:18),
                    )
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top:20),
                child: InkResponse(
                    onTap:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreenAdmin()));
                    },
                    child:Text("Do you Have Stadium? SignUp As Owner",
                      style: TextStyle(color:Colors.white, fontSize:18),
                    )
                ),
              )
            ]),
          )
      ),
    );
  }

  InputDecoration myInputDecoration({String label, IconData icon}){
    return InputDecoration(
      hintText: label,
      hintStyle: TextStyle(color:Colors.blue[100], fontSize:20),
      prefixIcon: Padding(
          padding: EdgeInsets.only(left:20, right:10),
          child:Icon(icon, color: Colors.blue[100],)
      ),

      contentPadding: EdgeInsets.fromLTRB(30, 20, 30, 20),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color:Colors.blue[300], width: 1)
      ),

      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color:Colors.blue[200], width: 1)
      ),

      fillColor: Colors.white,
      filled: true,
    );
  }
}