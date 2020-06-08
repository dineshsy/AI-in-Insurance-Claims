import 'package:firebase_database/firebase_database.dart';

class HealthReport {
  String key;
  String imageURL;
  Map healthData;
  bool isClaimed;
  String userId;

  HealthReport(this.healthData, this.userId, this.isClaimed, this.imageURL);

  HealthReport.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        userId = snapshot.value["userId"],
        healthData = snapshot.value["healthData"],
        isClaimed = snapshot.value["isClaimed"],
        imageURL = snapshot.value['imageURL'];

  toJson() {
    return {
      "userId": userId,
      "healthData": healthData,
      "isClaimed": isClaimed,
      "imageURL": imageURL,
    };
  }
}
