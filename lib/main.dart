import 'package:flutter/material.dart';
import 'package:health_care/Pages/claim.dart';
import 'package:health_care/Pages/dash_board.dart';
import 'package:health_care/Pages/reports.dart';
import 'package:health_care/Pages/upload/upload.dart';
import 'package:health_care/Sign-in/GoogleSignIn.dart';
import 'Pages/profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
 @override
  Widget build (BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignIn(),
      theme: ThemeData(fontFamily: 'Montserrat'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var indexCurr = 0;
  List currentPage = [
    DashBoard(),
    Reports(),
    Profile(),
    Claim(),
    Upload(),
  ];

  void pageBuilder(int index) {
    setState(() {
      indexCurr = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage[indexCurr],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(25.0),
        child: FloatingActionButton(
          
          child: Icon(Icons.add),
          onPressed: () {
            pageBuilder(4);
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home,size: 25,),
              color: (indexCurr == 0? Colors.black: Colors.blue),
              onPressed: () {
                pageBuilder(0);
              },
            ),
            IconButton(
              icon: Icon(Icons.list,size: 25,),
              color: (indexCurr == 1? Colors.black: Colors.blue),
              onPressed: () {
                pageBuilder(1);
              },
            ),
            IconButton(
              icon: Icon(Icons.person,size: 25,),
              color: (indexCurr == 2? Colors.black: Colors.blue),
              onPressed: () {
                pageBuilder(2);
              },
            ),
            IconButton(
              icon: Icon(Icons.assignment_turned_in,size: 25,),
              color: (indexCurr == 3? Colors.black: Colors.blue),
              onPressed: () {
                pageBuilder(3);
              },
            ),
          ],
        ),
      ),
    );
  }
}
