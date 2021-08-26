import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:core';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:my_futsal/pdf_preview_screen.dart';
import 'package:http/http.dart' as http;

import '../details_info.dart';

class PdfPage extends StatelessWidget {
  final pdf = pw.Document();
  Future savePdf() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File("$documentPath/example.pdf");
    file.writeAsBytesSync(pdf.save());
  }
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
                    pw.Text('Geeksforgeeks', textScaleFactor: 2),
                  ])),
          pw.Header(level: 1, text: 'What is Lorem Ipsum?'),

          pw.Paragraph(
              text:
              "Applications are getting more popular in these days where we can see Many people use their smartphones applications for travelling, ordering food and even buy their daily home necessities.We started with the main problem that happens with anyone want to book a place for playing football so we decided to solve this problem which will be an application for smart phone.So we want to develop this application aim to make booking a place for playing football easier for people in this field, managing the way that working on and improve of the user experience throw using our software."),

        pw.Padding(padding: const pw.EdgeInsets.all(10)),
        pw.Table.fromTextArray(context: context, data: const <List<String>>[
        <String>['title', 'pricec','categorie'],
        <String>['Ittehad', '20','Quinary'],
        <String>['Al-Nakhel', '25','Hexa'],
        <String>['Yarmouk', '25','Hexa'],
        <String>['JUST', '20','Hexa'],




        ]),
        ];
      },
    ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Geeksforgeeks"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.blueGrey,
                child: Text(
                  'Preview PDF',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
                onPressed: () async {
                  writeOnPdf();
                  await savePdf();

                  Directory documentDirectory =
                  await getApplicationDocumentsDirectory();

                  String documentPath = documentDirectory.path;

                  String fullPath = "$documentPath/example.pdf";
                  print(fullPath);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PdfPreviewScreen(
                            path: fullPath,
                          )));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
//
// class PDFView extends StatefulWidget {
//   final String url;
//   final String title;
//
//   const PDFView({Key key, this.url, this.title}) : super(key: key);
//
//   @override
//   _PDFViewState createState() => _PDFViewState();
// }
//
// class _PDFViewState extends State<PDFView> {
//   bool loading = true;
//   PDFDocument pdfDocument;
//
//   loadPdf()async{
//     pdfDocument = await PDFDocument.fromURL(widget.url);
//     setState(() {
//       loading = false;
//     });
//   }
//   @override
//   void initState() {
// loadPdf();
// super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.title),),
//       body: loading?
//       Center(
//         child: CircularProgressIndicator(),
//       ):PDFViewer(document: pdfDocument),
//
//     );
//   }
// }
