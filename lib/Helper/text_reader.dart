import 'dart:convert';
import 'dart:io';

Future<Map> apiRequest(String s) async {
  String url = "http://192.168.1.4:5000";
  // HttpClient httpClient = new HttpClient();
  print('hi from apiRequest $s');
  // String testURL = 'https://firebasestorage.googleapis.com/v0/b/fir-setup-e0cff.appspot.com/o/DummyTest%2Fsample_rep.jpg?alt=media&token=7edb254e-78b7-40ec-abe7-cc04431c151a';
  Map<dynamic, String> jsonMap = {'url': '$s'};
  print('Please wait while the OCR is runnig');
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  request.headers.set('content-type', 'application/json');
  request.add(utf8.encode(json.encode(jsonMap)));
  HttpClientResponse response = await request.close();
  // todo - you should check the response.statusCode
  String reply = await response.transform(utf8.decoder).join();
  Map<String, dynamic> replyInJSON = jsonDecode(reply);
  Map dataInJSON = replyInJSON['data'];
  httpClient.close();
  List bloodNames = [
    'White Blood Cells',
    'Heamoglobin',
    'Calcium',
    'Potassium',
    'Red Bood Cells',
    'Glucose'
  ];
  List bloodValues = [];
  var ctr = 0;
  for (var i in dataInJSON.values) {
    for (var j = 1; j < i.values.length; j++) {
      if (ctr == 1) bloodValues.add(i['$j']);
    }
    ctr++;
  }
  Map healthData = {};
  for (var i = 0; i < bloodNames.length; i++) {
    healthData[bloodNames[i]] = bloodValues[i];
  }
  return healthData;
}
