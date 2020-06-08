import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:health_care/Helper/HealthDataModal.dart';
import 'package:health_care/Pages/HealthReportDetails.dart';
import 'package:health_care/utilities/utils.dart' as urls;

class Reports extends StatefulWidget {
  Reports({Key key, this.userId}) : super(key: key);

  final String userId;
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  List list = urls.imageURL;
  List names = urls.imageName;
  List<HealthReport> _healthReportList;
  Query _healthReportQuery;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _healthReportList = new List();
    _healthReportQuery = _database
        .reference()
        .child("healthReport")
        .orderByChild("userId")
        .equalTo(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Reports",
            style: TextStyle(color: Colors.black, letterSpacing: 2.0),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: IconButton(
                icon: Icon(
                  Icons.share,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
        body: FutureBuilder(
            future: _healthReportQuery.once(),
            builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
              if (snapshot.hasData) {
                if ((_healthReportList != null)) _healthReportList.clear();
                Map<dynamic, dynamic> values = snapshot.data.value;
                if (values == null) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      alignment: Alignment.center,
                      child: Text("No data available"));
                }
                values.forEach((key, values) {
                  print(values);
                  HealthReport _healthReport = new HealthReport(
                      values['healthData'],
                      values['userId'],
                      values['isClaimed'],
                      values['imageURL']);

                  _healthReportList.add(_healthReport);
                });
                return new ListView.builder(
                    shrinkWrap: true,
                    itemCount: _healthReportList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HealthReportDetails(
                                  healthReport: _healthReportList[index],
                                  index: index),
                            )),
                        child: Container(
                          /// Give nice padding
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: <Widget>[
                              /// This is the important part, we need [Hero] widget with unique tag for this item.
                              Hero(
                                tag: "avatar_" + index.toString(),
                                child: CircleAvatar(
                                  radius: 32,
                                  backgroundImage: NetworkImage(
                                      _healthReportList[index].imageURL),
                                ),
                              ),
                              Padding(
                                /// Give name text a Padding
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Report  $index"),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              }
              return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator());
            }));
  }
}
