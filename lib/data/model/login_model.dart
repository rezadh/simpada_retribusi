import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:simpada/constants.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Login {
  String rc;
  String description;
  String tanggal;
  String name;

  Login({this.rc, this.description, this.tanggal, this.name});

  Login.fromJson(Map<String, dynamic> object) {
    rc = object['rc'];
    description = object['description'];
    tanggal = object['tgl'];
    name = object['name'];
  }
}
Future<Login> postRequestLogin(String username, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  DateTime dateNow = DateTime.now();
  var token = prefs.getString('token');
  var api = prefs.getString('apikey');
  var date = DateFormat("yyyy-MM-dd").format(dateNow);
  var time = DateFormat("HH:mm:ss.sss").format(dateNow);
  String timeStamp = date + 'T' + time + 'Z';
  var clientTime = DateFormat('dd-MM-yyyy HH:mm:ss').format(dateNow);
  var _signature = utf8.encode('$username:$timeStamp');
  var key = utf8.encode(api);
  var hmacSha256 = Hmac(sha256, key);
  Digest digest = hmacSha256.convert(_signature);
  String url = BaseUrl + 'retribusi/login';
  Map<String, String> h = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
    'Timestamp': timeStamp,
    'Signature': digest.toString(),
  };

  Map b = {'tgl': clientTime, 'username': username};
  var response =
  await http.post(Uri.parse(url), headers: h, body: json.encode(b));
  if (response.statusCode == 200 || response.statusCode == 201) {
    return Login.fromJson(json.decode(response.body));
  } else {
    print(response.body);
    return null;
  }
}