import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:my_futsal/pdf_preview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:my_futsal/screens/login_reg/ui/signin.dart';
import 'package:my_futsal/screens/login_reg/ui/signup.dart';
import 'package:pdf/pdf.dart';

import '../../home_screen.dart';
//import http package manually

class SignUpScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SignUpScreen();
  }
}

class _SignUpScreen extends State<SignUpScreen>{
  final  pdf = pw.Document();




  Future savePdf() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File("$documentPath/example.pdf");
    file.writeAsBytesSync(pdf.save());
  }



  bool  showprogress;
  String email, password,fname,lname,confirmpassword;
bool visible = false;
  var _fname = TextEditingController();
  var _lname = TextEditingController();
  var _email = TextEditingController();
  var _password = TextEditingController();
  var _confirmpassword = TextEditingController();



  writeOnPdf() {

    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(
              level: 0,
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: <pw.Widget>[
                    pw.Text('My Futsal', textScaleFactor: 2),
                  ])),
          pw.Header(level: 1, text: 'What My Futsal Do ?'),
          pw.Paragraph(
              text:
              "Applications are getting more popular in these days where we can see Many people use their smartphones applications for travelling, ordering food and even buy their daily home necessities.We started with the main problem that happens with anyone want to book a place for playing football so we decided to solve this problem which will be an application for smart phone.So we want to develop this application aim to make booking a place for playing football easier for people in this field, managing the way that working on and improve of the user experience throw using our software."),

          pw.Padding(padding: const pw.EdgeInsets.all(10)),
          pw.Table.fromTextArray(context: context, data: const <List<String>>[

            <String>['title', 'categorie'],
            <String>["_fname.text", 'GFG1'],
            <String>['SN1', 'GFG2'],
            <String>['SN2', 'GFG3'],
            <String>['SN3', 'GFG4'],
          ]),

          pw.Table.fromTextArray(context: context, data: const <List<String>>[
            <String>['Year', 'Sample'],
            <String>['SN0', 'GFG1'],
            <String>['SN1', 'GFG2'],
            <String>['SN2', 'GFG3'],
            <String>['SN3', 'GFG4'],
          ]),
        ];
      },
    ));
  }

  Future userRegistration() async{

    setState(() {
      visible = true ;
    });

    String fname = _fname.text;
    String lname = _lname.text;
    String email = _email.text;
    String password = _password.text;


    var url = 'https://myfutsal123.000webhostapp.com/reg.php';
    var data = {'fname': fname,'lname': lname, 'email': email, 'password' : password};
    var response = await http.post(url, body: json.encode(data));
    var message = jsonDecode(response.body);

    if(response.statusCode == 200){
      setState(() {
        visible = false;
      });
    }

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
                        color: const Color(0xFF1BC0C5),
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

  @override
  void initState() {
    fname = "";
    lname = "";
    email = "";
    password = "";
    confirmpassword = "";
    showprogress = false;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
    ));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
      ),
      body: SingleChildScrollView(
          child:Container(
            constraints: BoxConstraints(
                minHeight:MediaQuery.of(context).size.height
              //set minimum height equal to 100% of VH
            ),
            width:MediaQuery.of(context).size.width,
            //make width of outer wrapper to 100%
            decoration:BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [ Colors.blue,Colors.blueAccent,
                  Colors.blue,Colors.blueAccent,
                ],
              ),
            ), //show linear gradient background of page

            padding: EdgeInsets.all(20),
            child:Column(children:<Widget>[

              Container(
                margin: EdgeInsets.only(top:80),
                child: Text("SignUp", style: TextStyle(
                    color:Colors.white,fontSize: 40, fontWeight: FontWeight.bold
                ),),
              ),

              Container(
                margin: EdgeInsets.only(top:10),
                child: Text("Sign Up As User", style: TextStyle(
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
                  controller: _fname, //set username controller
                  style:TextStyle(color:Colors.blue, fontSize:20),
                  decoration: myInputDecoration(
                    label: "First Name",
                    icon: Icons.person,
                  ),
                  onChanged: (value){
                    //set username  text on change
                    fname = value;
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.fromLTRB(10,0,10,0),
                margin: EdgeInsets.only(top:10),
                child: TextFormField(
                  controller: _lname, //set username controller
                  style:TextStyle(color:Colors.blue, fontSize:20),
                  decoration: myInputDecoration(
                    label: "Last Name",
                    icon: Icons.person,
                  ),
                  onChanged: (value){
                    //set username  text on change
                    lname = value;
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.fromLTRB(10,0,10,0),
                margin: EdgeInsets.only(top:10),
                child: TextFormField(
                  controller: _email, //set username controller
                  style:TextStyle(color:Colors.blue, fontSize:20),
                  decoration: myInputDecoration(
                    label: "Email",
                    icon: Icons.email,
                  ),
                  onChanged: (value){
                    //set username  text on change
                    email = value;
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _password, //set password controller
                  style: TextStyle(color:Colors.blue, fontSize:20),
                  obscureText: true,
                  decoration: myInputDecoration(
                    label: "Password",
                    icon: Icons.lock,
                  ),
                  onChanged: (value){
                    // change password text
                    password = value;
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _confirmpassword, //set password controller
                  style: TextStyle(color:Colors.blue, fontSize:20),
                  obscureText: true,
                  decoration: myInputDecoration(
                    label: "Confirm-Password",
                    icon: Icons.lock,
                  ),
                  onChanged: (value){
                    confirmpassword = value;
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

                      if((_email.text).isEmpty){
                        Fluttertoast.showToast(
                            msg: "Email is Empty",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            timeInSecForIos: 4
                        );
                      }
                      else if((_password.text).isEmpty){
                        Fluttertoast.showToast(
                            msg: "Password is Empty",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            timeInSecForIos: 4
                        );
                      }
                      else if((_password.text).length < 8){
                        Fluttertoast.showToast(
                            msg: "Password must be more than 8 charachter",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            timeInSecForIos: 4
                        );
                      }
                      else if((_confirmpassword.text) != (_password.text)){
                        Fluttertoast.showToast(
                            msg: "Password is not matched",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            timeInSecForIos: 4
                        );
                      }
                      else{
                        userRegistration();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInPage()));
    }
                    },
                    child: showprogress?
                    SizedBox(
                      height:30, width:30,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blue[100],
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ):Text("SIGN UP NOW", style: TextStyle(fontSize: 20),),
                    colorBrightness: Brightness.dark,
                    color: Colors.lightGreen,
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
                    child:Text("Do you have an account? Login",
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