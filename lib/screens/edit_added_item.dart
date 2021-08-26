import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:my_futsal/screens/home_screen_admin.dart';


import '../details_info.dart';
import '../listDetailsClass.dart';

class EditForm extends StatefulWidget{
  final List list;
  final int index;
  const EditForm({Key key, this.list, this.index}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditForm();
  }
}

class _EditForm extends State<EditForm>{
  final formKey = GlobalKey<FormState>();
  bool  showprogress;
  String title, price,categorie;
  bool visible = false;
  var titleController = TextEditingController();
  var priceController = TextEditingController();
  var categorieController = TextEditingController();

  File _image;
  final picker = ImagePicker();

bool editMode = false;
 Future EditItems() async{

    setState(() {
      visible = true ;
    });

    String title = titleController.text;
    String price = priceController.text;
    String categorie = categorieController.text;

    var url = 'https://myfutsal123.000webhostapp.com/edit_item.php';
    var data = {'id':widget.list[widget.index]['id'].toString(),'title': title,'price': price, 'categorie': categorie};
    var response = await http.post(url, body:json.encode(data));
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
    titleController.text = widget.list[widget.index]['title'];
    priceController.text = widget.list[widget.index]['price'].toString();
    categorieController.text = widget.list[widget.index]['categorie'];

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
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
      ),
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
                colors: [ Colors.white70,Colors.white,
                  Colors.white70,Colors.white,
                ],
              ),
            ),

            padding: EdgeInsets.all(20),
            child:Column(children:<Widget>[

              Container(
                margin: EdgeInsets.only(top:80),
                child: Text("Edit Items", style: TextStyle(
                    color:Colors.blue,fontSize: 40, fontWeight: FontWeight.bold
                ),),
              ),


              SizedBox(height: 30.0),

              Container(
                padding: EdgeInsets.fromLTRB(10,0,10,0),
                margin: EdgeInsets.only(top:10),
                child: TextFormField(
                  controller: titleController, //set username controller
                  style:TextStyle(color:Colors.blue, fontSize:20),
                  decoration: myInputDecoration(
                    label: "Title",
                    icon: Icons.title,
                  ),
                  onChanged: (value){
                    title = value;
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.fromLTRB(10,0,10,0),
                margin: EdgeInsets.only(top:10),
                child: TextFormField(
                  controller: priceController, //set username controller
                  style:TextStyle(color:Colors.blue, fontSize:20),
                  decoration: myInputDecoration(
                    label: "Price",
                    icon: Icons.credit_card,
                  ),
                  onChanged: (value){
                    price = value;
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.fromLTRB(10,0,10,0),
                margin: EdgeInsets.only(top:10),
                child: TextFormField(
                  controller: categorieController, //set username controller
                  style:TextStyle(color:Colors.blue, fontSize:20),
                  decoration: myInputDecoration(
                    label: "Category",
                    icon: Icons.category,
                  ),
                  onChanged: (value){
                    categorie = value;
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
                      print (widget.list[widget.index]['id']);
                      EditItems();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePageAdmin()));
                    },
                    child: showprogress?
                    SizedBox(
                      height:30, width:30,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blue[100],
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ):Text("Submit Edit", style: TextStyle(fontSize: 20),),
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