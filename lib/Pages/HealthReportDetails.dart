import 'package:flutter/material.dart';
import 'package:health_care/Helper/HealthDataModal.dart';

class HealthReportDetails extends StatelessWidget {
  HealthReportDetails({Key key, this.healthReport, this.index})
      : super(key: key);

  final HealthReport healthReport;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report Info"),
        backgroundColor: Colors.black12,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),

              /// This is the important part, we need [Hero] widget with unique tag but same as Hero's tag in [User] widget.
              child: Hero(
                tag: "avatar_" + index.toString(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: (NetworkImage(healthReport.imageURL)),
                      )),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: healthCard("White Blood Cells",
                        healthReport.healthData['White Blood Cells']),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: healthCard(
                        "Calcium", healthReport.healthData['Calcium']),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: healthCard(
                        "Hemoglobin", healthReport.healthData['Heamoglobin']),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: healthCard("Red Blood Cells",
                        healthReport.healthData['Red Bood Cells']),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: healthCard(
                        "Potassium", healthReport.healthData['Potassium']),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: healthCard(
                        "Glucose", healthReport.healthData['Glucose']),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container healthCard(String name, String value) {
    return Container(
      alignment: Alignment.center,
      width: 200,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.greenAccent),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(fontSize: 40, color: Colors.blueAccent),
            ),
            Text(
              name,
              style: TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
