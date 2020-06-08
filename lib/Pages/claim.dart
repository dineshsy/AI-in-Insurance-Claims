import 'package:flutter/material.dart';
// const String SUCCESS_MESSAGE=" You will be contacted by us very soon.";
class Claim extends StatefulWidget {
  @override
  _ClaimState createState() => _ClaimState();
}

class _ClaimState extends State<Claim> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
        body:  new Container());}}
//   child: Padding(
//     padding: const EdgeInsets.all(15.0),
// //     child: new ListView(
// //       minLines: 10,
// //       maxLines: 15,
// //       autocorrect: false,
// //       // decoration: InputDecoration(
// //         // hintText:SUCCESS_MESSAGE,
// //         // filled: true,
// //         // fillColor: Color(0xFFDBEDFF),
// //         //  children: <Widget>[
// //           Column(
// //             children: <Widget>[
// //               new Container(
// //                 height: 250.0,
// //                 color: Colors.white,
// //                 child: new Column(
// //                   children: <Widget>[
// //                     Padding(
// //                             padding: EdgeInsets.only(
// //                                 left: 25.0, right: 25.0, top: 25.0),
// //                             child: new Row(
// //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                               mainAxisSize: MainAxisSize.max,
// //                               children: <Widget>[
// //                                 new Column(
// //                                   mainAxisAlignment: MainAxisAlignment.start,
// //                                   mainAxisSize: MainAxisSize.min,
// //                                   children: <Widget>[
// //                                     new Text(
// //                                       'Personal Information',
// //                                       style: TextStyle(
// //                                           fontSize: 18.0,
// //                                           fontWeight: FontWeight.bold),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ],
// //                                 ),
// //                   // ],
// //                 ),
// //                   ],
// //               ),
// //                 ),
// //             ],
// //           ),
// //         //  ],
// //         enabledBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.all(Radius.circular(10.0)),
// //           borderSide: BorderSide(color: Colors.grey),
// //         ),
// //         focusedBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.all(Radius.circular(10.0)),
// //           borderSide: BorderSide(color: Colors.grey),
// //         ),
// //       ),
// //     ),
// //   ),
// // ),
// //         );
// //     // );
// //   }
// // }