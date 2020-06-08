import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:health_care/Helper/HealthDataModal.dart';
import 'dart:async';
import 'dart:io';
import 'dart:core';
import 'package:health_care/Helper/imagepicker.dart';
import 'package:health_care/Helper/text_reader.dart';
import 'package:health_care/Helper/imageUploader.dart';
import 'package:health_care/utilities/utils.dart' as urls;
import 'package:flutter_spinkit/flutter_spinkit.dart';

final FirebaseDatabase _database = FirebaseDatabase.instance;

class Upload extends StatefulWidget {
  Upload({Key key, this.userId}) : super(key: key);

  final String userId;
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  File pickedImage;
  bool isImageLoaded = false;
  ImageHelper imageHelper = new ImageHelper();
  bool isError = false;
  bool isLoading = false;

  var post;
  final spinkit = SpinKitRotatingCircle(
    color: Colors.white,
    size: 50.0,
  );

  Future pickImage() async {
    var tempStore = await imageHelper.pickImage();
    setState(() {
      pickedImage = tempStore;
      isImageLoaded = true;
    });
  }

  String url;
  void errorHandler() {
    setState(() {
      isError = true;
    });
  }

  Future imageUploadHelper(File image) async {
    // FutureOr<dynamic> s;
    if (image != null) {
      var fileName = (image.uri).toString().split('/').last;
      try {
        url =
            await ImageUpload.uploadImage(fileName: "$fileName", image: image);
      } on Exception catch (e) {
        errorHandler();
      }
      urls.imageURL.add(url);
      urls.imageName.add(fileName);
    }

    print(url + ' from imageUpladHelper');
    // print(urls.imageURL);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Upload your report",
              style: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
          ),
          isImageLoaded
              ? Center(
                  child: Container(
                      height: 200.0,
                      width: 200.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(pickedImage),
                              fit: BoxFit.cover))),
                )
              : Container(),
          SizedBox(height: 10.0),
          FloatingActionButton(
            autofocus: true,
            child: Icon(Icons.add_a_photo),
            onPressed: pickImage,
          ),
          SizedBox(height: 10.0),
          isImageLoaded
              ? InkWell(
                  radius: 20,
                  splashColor: Colors.blue,
                  autofocus: true,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Text(
                            'Read Text',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () async {
                    await imageUploadHelper(pickedImage);
                    if (isError == true) {
                      showDialog(
                          context: this.context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Icon(Icons.add_alert),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Oops!",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              content: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text("Something went wrong"),
                                ],
                              ),
                              contentPadding: EdgeInsets.all(10),
                              actions: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: RawMaterialButton(
                                    onPressed: () {},
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("Try Again")
                                      ],
                                    ),
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    splashColor: Colors.green,
                                    fillColor: Colors.green.shade100,
                                  ),
                                )
                              ],
                              backgroundColor: Colors.red.shade200,
                              elevation: 20,
                            );
                          });
                    } else {
                      setState(() {
                        isLoading = true;
                      });
                      await imageUploadHelperJSON(url)
                          .then((value) => this.setState(() {
                                this.isLoading = false;
                              }));
                    }
                  },
                )
              : SizedBox()
        ],
      ),
      isLoading
          ? SafeArea(
              child: Center(
                  child: SpinKitWave(
                      color: Colors.black, type: SpinKitWaveType.start)))
          : SizedBox(),
    ]));
  }

  Future imageUploadHelperJSON(String s) async {
    print('hi fromm imageUploaderJson');
    post = await apiRequest(s);
    print(post); // to print the JSON
    HealthReport healthReport =
        new HealthReport(post, widget.userId, false, url);
    // print(post["ParsedResults"][0]);
    _database
        .reference()
        .child("healthReport")
        .push()
        .set(healthReport.toJson());
  }
}
