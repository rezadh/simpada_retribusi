import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:simpada/constants.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Registration {
  String rc;
  String description;
  String apiKey;

  Registration({this.rc, this.description, this.apiKey});

  Registration.fromJson(Map<String, dynamic> object) {
    rc = object['rc'];
    description = object['description'];
    apiKey = object['apiKey'];
  }
}
Future<Registration> postRegistration(String noHp, String password, String code) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  DateTime dateNow = DateTime.now();
  // var noHp = prefs.getString('noHp');
  // var password = prefs.getString('password');
  var api = prefs.getString('apikey');
  var date = DateFormat("yyyy-MM-dd").format(dateNow);
  var time = DateFormat("HH:mm:ss.sss").format(dateNow);
  String timeStamp = date + 'T' + time + 'Z';
  var _signature = utf8.encode('$noHp:$timeStamp');
  String _auth = 'Basic ' + base64Encode(utf8.encode('$noHp:$password'));
  var key = utf8.encode(code);
  var hmacSha256 = Hmac(sha256, key);
  Digest digest = hmacSha256.convert(_signature);
  String url = BaseUrl + 'retribusi/register';
  Map<String, String> h = {
    'Content-Type': 'application/json',
    'Authorization': _auth,
    'Timestamp': timeStamp,
    'Signature': digest.toString(),
  };
  print(h);
  Map b = {'imei': '123123123', 'code': code};
  var response =
  await http.post(Uri.parse(url), headers: h, body: json.encode(b));
  if (response.statusCode == 200 || response.statusCode == 201) {
    var apiKey = json.decode(response.body)['apikey'];
    print(apiKey);
    prefs.setString('apikey', apiKey);
    return Registration.fromJson(json.decode(response.body));
  } else {
    print(response.body);
    return null;
  }
}