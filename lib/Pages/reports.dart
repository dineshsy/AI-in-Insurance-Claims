import 'package:flutter/material.dart';
import 'package:health_care/utilities/utils.dart' as urls;

class Reports extends StatefulWidget {
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  List list = urls.imageURL;
  List names = urls.imageName;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: Colors.black,
      ),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          contentPadding: EdgeInsets.all(8.0),
          title: Text(names[index]),
          trailing: Image.network(
            list[index],
            fit: BoxFit.cover,
            height: 40.0,
            width: 40.0,
          ),
          onTap: () {
            /* Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyDetails(list[index])));*/
          },
        );
      },
    );
  }
}
