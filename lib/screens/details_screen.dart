import 'dart:async';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_futsal/details_info.dart';
import 'package:my_futsal/screens/pdf_view.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  final DetailsClass suitable ;
  DetailScreen(this.suitable);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {


  SendToEmail() async {
    String username = "myfutsalapplication@gmail.com";
    String password = "myfutsalcis499";

    final smtpServer = gmail(username, password);
    // Creating the Gmail server

    // Create our email message.
    final message = Message()
      ..from = Address(username)
      ..recipients.add('majdzo12345@gmail.com') //recipent email
      // ..ccRecipients.addAll(['myfutsalapplication@gmail.com', 'myfutsalapplication@gmail.com']) //cc Recipents emails
      // ..bccRecipients.add(Address('myfutsalapplication@gmail.com')) //bcc Recipents emails
      ..subject = 'New Book' //subject of the email
      ..text = '${_currentTime}تم حجز الملعب في الوقت:  '; //body of the email

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString()); //print if the email is sent
    } on MailerException catch (e) {
      print('Message not sent. \n'+ e.toString()); //print if the email is not sent
      // e.toString() will show why the email is not sending
    }
  }


  var isVisible = true;
  List _time =
  ["8-10 AM", "10-12 AM", "12-2 PM", "2-4 PM", "4-6 PM","6-8 PM", "8-10 PM", "10-12 PM"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentTime;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentTime = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String selectedtime in _time) {
      items.add(new DropdownMenuItem(
          value: selectedtime,
          child: new Text(selectedtime)
      ));
    }
    return items;
  }
  int _counter = 7200;
  Timer _timer;

  void _startTimer() {
    _counter = 7200;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  String formatHHMMSS(int seconds) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return "$minutesStr:$secondsStr";
    }

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60.0)),
              child: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: 0,
                      top: 0,
                      right: 0,
                      left: 0,
                      child: Hero(
                        tag: widget.suitable.id,
                        child: Image.network(
                         widget.suitable.imgUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    _buildTitleInfo(),
                    SizedBox(height: 10.0,),
                    _buildServiceBar(),
                    SizedBox(height: 10.0,),
                    _buildBookButton(),
                    SizedBox(height: 10.0,),
                    _buildUnBookButton(),
                    SizedBox(height: 10.0,),
                    _GenerateePDF(),

                  ],
                ),
              ),
            ),

        ],
      ),
    );
  }

  _buildTitleInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(widget.suitable.title,style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2
            ),
            ),
            SizedBox(height:10.0 ,),
            Text(widget.suitable.categorie),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(icon:Icon(Icons.call),
              onPressed: ()=> launch("tel://0777777777"),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('\$${widget.suitable.price}',style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2
            ),),
            SizedBox(height:10.0 ,),
            Text("ساعتين"),
          ],
    ),
      ],
    );
  }

  _buildServiceBar() {
    return new Container(
      color: Colors.white,
      child: new Center(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text("أختر ساعات الحجز: "),
              new Container(
                padding: new EdgeInsets.all(6.0),
              ),
              Visibility(
                visible: isVisible,
                child: new DropdownButton(
                  value: _currentTime,
                  items: _dropDownMenuItems,
                  onChanged: changedDropDownItem,

                ),
              ),

              SizedBox(
                height: 20.0,
              ),
              Text('Selected: ${_currentTime}'),

              (_counter > 0)
                  ? Text("")
                  : Text(
                "DONE!",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                formatHHMMSS(_counter),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
            ],
          )
      ),
    );
  }
  void changedDropDownItem(String selectedTime) {
    setState(() {
      _currentTime = selectedTime;
    });
  }

  _buildBookButton() {
    return    Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top:20),
      child: SizedBox(
        height: 60, width: 200,
        child:RaisedButton(
          onPressed: (){
            _startTimer();
            setState(() {
              isVisible = !isVisible;
            });
            SendToEmail();
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
                                  "Book is Start",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: const Color(0xFF1BC0C5),
                              ),
                            ),
                            FlatButton(
                              child:new Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
          child: Text("احجز" ,style: TextStyle(fontSize: 20),),
          colorBrightness: Brightness.dark,
          color: Colors.lightGreen,
          shape: RoundedRectangleBorder(
              borderRadius:BorderRadius.circular(30)
          ),
        ),
      ),
    );
  }

  _buildUnBookButton() {
    return    Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top:20),
      child: SizedBox(
        height: 60, width: 200,
        child:RaisedButton(
          onPressed: (){
            _timer.cancel();
            setState(() {
              isVisible = !isVisible;
            });

            // SendToEmail();
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
                                  "UnBooking Successfully",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.red,
                              ),
                            ),
                            FlatButton(
                              child:new Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
          child:Text("الغاء الحجز", style: TextStyle(fontSize: 20),),
          colorBrightness: Brightness.dark,
          color: Colors.blueAccent,
          shape: RoundedRectangleBorder(
              borderRadius:BorderRadius.circular(30)
          ),
        ),
      ),
    );
  }
  _GenerateePDF() {
    return    Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top:20),
      child: SizedBox(
        height: 60, width: 200,
        child:RaisedButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => PdfPage()));
          },
          child:Text("Generate PDF", style: TextStyle(fontSize: 20),),
          colorBrightness: Brightness.dark,
          color: Colors.redAccent,
          shape: RoundedRectangleBorder(
              borderRadius:BorderRadius.circular(30)
          ),
        ),
      ),
    );
  }
}
