import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_care/Pages/dash_board.dart';
import 'package:health_care/Pages/reports.dart';
import 'package:health_care/Pages/upload/upload.dart';
import 'package:health_care/Sign-in/GoogleSignIn.dart';
import 'Pages/profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignIn(),
      theme: ThemeData(fontFamily: 'Montserrat'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.user}) : super(key: key);

  final FirebaseUser user;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var indexCurr = 0;

  void pageBuilder(int index) {
    setState(() {
      indexCurr = index;
    });
  }

  List currentPage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPage = [
      DashBoard(),
      Reports(
        userId: widget.user.uid,
      ),
      Profile(
        user: widget.user,
      ),
      Upload(
        userId: widget.user.uid,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage[indexCurr],
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                size: 25,
              ),
              color: (indexCurr == 0 ? Colors.black : Colors.blue),
              onPressed: () {
                pageBuilder(0);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.list,
                size: 25,
              ),
              color: (indexCurr == 1 ? Colors.black : Colors.blue),
              onPressed: () {
                pageBuilder(1);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.add_circle,
                size: 25,
              ),
              color: (indexCurr == 3 ? Colors.black : Colors.blue),
              onPressed: () {
                pageBuilder(3);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                size: 25,
              ),
              color: (indexCurr == 2 ? Colors.black : Colors.blue),
              onPressed: () {
                pageBuilder(2);
              },
            ),
          ],
        ),
      ),
    );
  }
}
