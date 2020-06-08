import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_care/main.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _imageUrl;

  Future<FirebaseUser> _gSignin() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    // idToken: googleSignInAuthentication.idToken,
    // accessToken: googleSignInAuthentication.accessToken);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => MyHomePage(
                  user: user,
                )),
        (Route<dynamic> route) => false);
    print("User is: ${user.photoUrl}");

    setState(() {
      _imageUrl = user.photoUrl;
    });

    return user;
  }

  _logout() {
    setState(() {
      _googleSignIn.signOut();
      _imageUrl = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              child: Text("Google-Sign-in"),
              onPressed: () => _gSignin(),
              color: Colors.red,
            ),
          ),
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              color: Colors.redAccent,
              child: Text("Logout"),
              onPressed: () => _logout(),
            ),
          ),
        ],
      ),
    ));
  }
}
