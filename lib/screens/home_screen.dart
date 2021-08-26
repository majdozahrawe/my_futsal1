import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_futsal/details_info.dart';
import 'package:my_futsal/screens/details_screen.dart';
import 'package:my_futsal/screens/Profile.dart';
import 'package:my_futsal/screens/login_reg/ui/signin.dart';
import 'package:http/http.dart' as http;
import 'package:my_futsal/screens/login_reg/ui/signin_admin.dart';
import 'package:my_futsal/main.dart';
import 'package:my_futsal/screens/pdf_view.dart';
import '../widget/StartRating.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future fetchitems()async{
    var apiURL = 'https://myfutsal123.000webhostapp.com/fname_email.php';
    var respnse = await http.get(apiURL);
    return json.decode(respnse.body);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      drawer: Drawer(
        child: new ListView(
          padding: new EdgeInsets.all(0.0),
          children: <Widget>[
            new UserAccountsDrawerHeader(
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.white,
                radius: 45.0,
                  child: Image.asset(("assets/images/mflogo.png"),
                    width:  300,
                    height:  300,),
              ),
            ),
            new ListTile(
              title: new Text("Home"),
              trailing: new Icon(Icons.home),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),

            new Divider(),
            new ListTile(
              title: new Text("Logout"),
              trailing: new Icon(Icons.logout),
              onTap: () =>Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInPage())),

            ),

            new Divider(),
            new ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInPageAdmin()));
              },
              title: new Text("Do you Have Stadium ? "),
              trailing: new Icon(Icons.person),
            ),
            new Divider(),
            new ListTile(
              title: new Text("Close"),
              trailing: new Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),

      body: Column(
        children: <Widget>[
      Container(
      margin: EdgeInsets.only(right: 20.0,left: 40.0),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
 ],     ),),

          Expanded(
            child: _buildListView(),),
        ],
      ),
    );
  }

  _buildImageListView(DetailsClass info) {
    return Positioned(
      right: 30.0,
      child: Container(
        width: 180.0,
        height: 260,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),

            boxShadow: [BoxShadow(
              color: Colors.black45,
              offset: Offset.fromDirection(0.0, 0.2),
              blurRadius: 18,
            )
            ]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Stack(
            children: <Widget>[
              Container(
                height: 260.0,
                child: Hero(
                  tag: info.id,
                  child: Image.network(
                    info.imgUrl,
                    fit: BoxFit.cover,

                  ),
                ),
              ),
              Positioned(
                  bottom: 0.0,
                  child: Container(
                    height: 50.0,
                    width: 180.0,
                    decoration: BoxDecoration(
                        boxShadow: [BoxShadow(
                            color: Colors.black45,
                            blurRadius: 16,
                            offset: Offset.fromDirection(0.0, 0.2)

                        )
                        ]
                    ),

                  )
              ),
              Positioned(
                bottom: 10.0,
                right: 4.0,
                left: 4.0,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      child: Text(info.title, style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,

                      ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,

                      ),
                    ),
                    SizedBox(width: 10.0,),
                    Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: IconButton(
                        icon: Icon(FontAwesomeIcons.locationArrow),
                        onPressed: () {
                        },
                        color: Colors.white,
                        iconSize: 15.0,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildBoxInfo(DetailsClass info) {
    return Positioned(
      right: 150.0,
      left: 20.0,
      top: 30.0,
      child: Container(
        height: 160.0,
        decoration: BoxDecoration(
            color: Theme
                .of(context)
                .primaryColor,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [BoxShadow(
                color: Theme
                    .of(context)
                    .accentColor,
                offset: Offset.fromDirection(0.0, 0.2),
                blurRadius: 5
            )
            ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('\$${info.price}', style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold
                ),),
                SizedBox(width: 10.0,),
                Text("ساعتين", style: TextStyle(

                ),),
              ],
            ),
            SizedBox(height: 10.0,),
            Text(info.categorie),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StarRating(
                  starCount: 5,
                  rating: info.rating,
                  color: Colors.orange,
                  iconSize: 12.0,
                ),
                SizedBox(width: 5.0,),
                Text('${info.total_review} reviews', style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13.0
                ),),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 5.0,),
                Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: Colors.blue[800],
                    borderRadius: BorderRadius.circular(10.0),

                  ),
                  child: Center(child: Text("+99", style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0
                  ),)),
                ),

              ],
            )

          ],
        ),

      ),
    );
  }

  _buildListView() {
    return ListView.builder(

      itemCount: listSuitable.length,
      itemBuilder: (BuildContext context, int index) {
        DetailsClass info = listSuitable[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DetailScreen(info)));
          },
          child: Container(
            height: 280.0,
            child: Stack(
              children: <Widget>[
                _buildImageListView(info),
                _buildBoxInfo(info)
              ],
            ),
          ),
        );
      },
    );
  }
}
