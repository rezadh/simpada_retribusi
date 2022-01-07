import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:simpada/constants.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GenerateToken {
  String rc;
  String description;
  String accessToken;

  GenerateToken({this.rc, this.description, this.accessToken});

  GenerateToken.fromJson(Map<String, dynamic> object) {
    rc = object['rc'];
    description = object['description'];
    accessToken = object['access_token'];
  }
}

Future<GenerateToken> getToken(String username, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  DateTime dateNow = DateTime.now();
  var date = DateFormat("yyyy-MM-dd").format(dateNow);
  var time = DateFormat("HH:mm:ss.sss").format(dateNow);
  var api = prefs.getString('apikey');
  String timeStamp = date + 'T' + time + 'Z';
  var _signature = utf8.encode('$username:$timeStamp');
  print(api);
  String _auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
  var key = utf8.encode(api);
  var hmacSha256 = Hmac(sha256, key);
  Digest digest = hmacSha256.convert(_signature);
  var clientTime = DateFormat('dd-MM-yyyy HH:mm:ss').format(dateNow);
  String url = BaseUrl + 'retribusi/token';
  Map<String, String> h = {
    'Content-Type': 'application/json',
    'Authorization': _auth,
    'Timestamp': timeStamp,
    'Signature': digest.toString(),
  };
  Map b = {'tgl': clientTime, 'username': username};
  print(b);
  var response = await http.get(Uri.parse(url), headers: h);
  if (response.statusCode == 200 || response.statusCode == 201) {
    var token = json.decode(response.body)['access_token'];
    prefs.setString('token', token);
    print(response.body);
    return GenerateToken.fromJson(json.decode(response.body));
  } else {
    print(response.body);
    return null;
  }
}