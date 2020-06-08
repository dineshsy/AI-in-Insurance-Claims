import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "DashBoard",
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
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                width: 400,
                height: 220,
                child: FittedBox(
                  child: Image.asset('assests/images/dummy.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            widgetHelper('Protiens', 0.4),
            widgetHelper('Blood Pressure', 0.7),
            widgetHelper('Iron', 0.3),
            widgetHelper('Hemoglobin', 0.5),
          ],
        ),
      ),
    );
  }

  Widget widgetHelper(String s, double val) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Container(
        height: 50,
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Align(alignment: Alignment.centerLeft, child: Text(s)),
            SizedBox(
              height: 20,
            ),
            LinearProgressIndicator(
              value: val,
              backgroundColor: Colors.black12,
              valueColor: new AlwaysStoppedAnimation<Color>(val < 0.7
                  ? val < 0.4 ? Colors.yellow : Colors.green
                  : Colors.redAccent),
            )
          ],
        ),
      ),
    );
  }
}
