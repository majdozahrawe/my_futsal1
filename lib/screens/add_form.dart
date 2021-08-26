import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:my_futsal/screens/home_screen_admin.dart';

import '../details_info.dart';

class AddForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AddForm();
  }
}


class _AddForm extends State<AddForm>{

  var c=4;
  bool  showprogress;
  String title, price,categorie;
  bool visible = false;
  var titleController = TextEditingController();
  var priceController = TextEditingController();
  var categorieController = TextEditingController();

  var pickedImage;
  File _image;

final picker = ImagePicker();

  Future chooseImage()async{
     pickedImage = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadImage()async{
    final url = Uri.parse('http://192.168.8.100/flutter_api/upload_image.php');
    var request = http.MultipartRequest('Post',url);
   var pic = await http.MultipartFile.fromPath("image", _image.path);
   request.files.add(pic);
   var response = await request.send();

   if (response.statusCode == 200){
     print("Image  Uploaded");
   }
   else{
     print("Image Not Uploaded");

   }
  }

  Future upload() async{
    setState(() {
      visible = true ;
    });

    String title = titleController.text;
    String price = priceController.text;
    String categorie = categorieController.text;

    var url = 'https://myfutsal123.000webhostapp.com/item_add.php';
    var data = {'title': title,'price': price, 'categorie': categorie};
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
    title = "";
    price = "";
    categorie = "";
    showprogress = false;

    super.initState();
  }

  void addItemToList(){
// splitpath =[c,users,ulo,image.jpg];
  // sin =[image,.jpg]
    var splitpath = _image.path.split('/');
    var len = splitpath.length;
    var FinalResult = splitpath[len-1];
    var SplitImageName = FinalResult.split('.');
    var ImageName = SplitImageName[0];

    // cout<<"x = "<<x;

    setState(() {
      listSuitable.add(
        DetailsClass(
        id: '${c}',
        imgUrl: "http://192.168.8.100/flutter_api/uploads/${ImageName}.jpg",
        price:priceController.text,
        categorie: categorieController.text,
        rating: 4,
        total_review: "200",
        title: titleController.text,
      ),);
    });
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
            //make width of outer wrapper to 100%
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
                child: Text("Add Item", style: TextStyle(
                    color:Colors.blue,fontSize: 40, fontWeight: FontWeight.bold
                ),),
              ),


              SizedBox(height: 30.0),

              Container(
                padding: EdgeInsets.fromLTRB(10,0,10,0),
                margin: EdgeInsets.only(top:10),
                child: TextFormField(
                  controller: titleController,
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
                  controller: priceController,
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
                  controller: categorieController,
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


              IconButton
                (
                  icon: Icon(Icons.camera),
                  onPressed: (){
                    chooseImage();
                  }
              ),

              Container(
child: _image != null ? Image.file(_image)  :Text('No Image Selected') ,
              ),

              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top:20),
                child: SizedBox(
                  height: 60, width: 200,
                  child:RaisedButton(
                    onPressed: (){
                      if (pickedImage ==null){
                        Fluttertoast.showToast(
                          msg: "No Image Selected",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                      else{
                        Fluttertoast.showToast(
                          msg: "Image Uploaded Successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        uploadImage();
                      }

                    },
                    child: Text("Add Image", style: TextStyle(fontSize: 20),),
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
                child: SizedBox(
                  height: 60, width: 200,
                  child:RaisedButton(
                    onPressed: (){
                      setState(() {
                        showprogress = true;
                      });

                      if((titleController.text).isEmpty){
                        Fluttertoast.showToast(
                            msg: "Title is Empty",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            timeInSecForIos: 4
                        );
                      }
                      else if((priceController.text).isEmpty){
                        Fluttertoast.showToast(
                            msg: "Price is Empty",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            timeInSecForIos: 4
                        );
                      }
                      else if(pickedImage ==null){
                        Fluttertoast.showToast(
                            msg: "You Must insert Image",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            timeInSecForIos: 4
                        );
                      }
                      else{
                        upload();
                        addItemToList();
                        c++;
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePageAdmin()));
                      }
                    },
                    child:Text("Submit", style: TextStyle(fontSize: 20),),
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