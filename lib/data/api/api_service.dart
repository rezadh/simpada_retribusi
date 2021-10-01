import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:simpada/constants.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:simpada/data/model/simpada_retribusi.dart';

Future<Registration> postRegistration(String code) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  DateTime dateNow = DateTime.now();
  var noHp = prefs.getString('noHp');
  var password = prefs.getString('password');
  var date = DateFormat("yyyy-MM-dd").format(dateNow);
  var time = DateFormat("HH:mm:ss.sss").format(dateNow);
  String timeStamp = date + 'T' + time + 'Z';
  var _signature = utf8.encode('$noHp:$timeStamp');
  String _auth = 'Basic ' + base64Encode(utf8.encode('$noHp:$password'));
  var key = utf8.encode(api_key);
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
    prefs.setString('apikey', apiKey);
    return Registration.fromJson(json.decode(response.body));
  } else {
    print(response.body);
    return null;
  }
}

Future<GenerateToken> getToken(String username, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var api = prefs.getString('apikey');
  DateTime dateNow = DateTime.now();
  var date = DateFormat("yyyy-MM-dd").format(dateNow);
  var time = DateFormat("HH:mm:ss.sss").format(dateNow);
  String timeStamp = date + 'T' + time + 'Z';
  var _signature = utf8.encode('$username:$timeStamp');
  String _auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
  var key = utf8.encode(api_key);
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

Future<Login> postRequestLogin(String username, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  DateTime dateNow = DateTime.now();
  var token = prefs.getString('token');
  var date = DateFormat("yyyy-MM-dd").format(dateNow);
  var time = DateFormat("HH:mm:ss.sss").format(dateNow);
  String timeStamp = date + 'T' + time + 'Z';
  var clientTime = DateFormat('dd-MM-yyyy HH:mm:ss').format(dateNow);
  var _signature = utf8.encode('$username:$timeStamp');
  var key = utf8.encode(api_key);
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

Future<CollectTax> postCollectTax(
    String username, String password, Map body) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var api = prefs.getString('apikey');
  DateTime dateNow = DateTime.now();
  var token = prefs.getString('token');
  print(token);
  var date = DateFormat("yyyy-MM-dd").format(dateNow);
  var time = DateFormat("HH:mm:ss.sss").format(dateNow);
  String timeStamp = date + 'T' + time + 'Z';
  var _signature = utf8.encode('$username:$timeStamp');
  var key = utf8.encode(api);
  var hmacSha256 = Hmac(sha256, key);
  Digest digest = hmacSha256.convert(_signature);
  String url = BaseUrl + 'retribusi/collect';
  Map<String, String> h = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
    'Timestamp': timeStamp,
    'Signature': digest.toString(),
  };
  Map b = {
    'npwrd': body['npwrd'],
    'tgl_pungut': body['tanggal_penagihan'],
    'nominal': body['nominal'],
    'periode': body['periode'],
    'jumlah_bayar_maju': body['jumlah_bayar'],
    'satuan_periode': body['satuan_periode'],
    'username': username
  };
  print(b);
  var response =
      await http.post(Uri.parse(url), headers: h, body: json.encode(b));
  if (response.statusCode == 200 || response.statusCode == 201) {
    print(response.body);
    return CollectTax.fromJson(json.decode(response.body));
  } else {
    print(response.body);
    return null;
  }
}

Future<List<ListNTRD>> postRequestNTRD() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var api = prefs.getString('apikey');
  DateTime dateNow = DateTime.now();
  var token = prefs.getString('token');
  var noHp = prefs.getString('noHp');
  var date = DateFormat("yyyy-MM-dd").format(dateNow);
  var time = DateFormat("HH:mm:ss.sss").format(dateNow);
  String timeStamp = date + 'T' + time + 'Z';
  var _signature = utf8.encode('$noHp:$timeStamp');
  var key = utf8.encode(api);
  var hmacSha256 = Hmac(sha256, key);
  Digest digest = hmacSha256.convert(_signature);
  String url = BaseUrl + 'retribusi/ntrd/all';
  Map<String, String> h = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
    'Timestamp': timeStamp,
    'Signature': digest.toString(),
  };
  Map b = {'username': noHp};
  print(b);
  var response =
      await http.post(Uri.parse(url), headers: h, body: json.encode(b));
  if (response.statusCode == 200 || response.statusCode == 201) {

    List responseJson = json.decode(response.body)['daftar'];
    print(responseJson);
    return responseJson.map((e) => ListNTRD.fromJson(e)).toList();
  } else {
    print(response.body);
    return null;
  }
}

Future<BillCode> postRequestBillCode(List billCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var api = prefs.getString('apikey');
  DateTime dateNow = DateTime.now();
  var token = prefs.getString('token');
  var noHp = prefs.getString('noHp');
  var date = DateFormat("yyyy-MM-dd").format(dateNow);
  var time = DateFormat("HH:mm:ss.sss").format(dateNow);
  String timeStamp = date + 'T' + time + 'Z';
  var _signature = utf8.encode('$noHp:$timeStamp');
  var key = utf8.encode(api);
  var hmacSha256 = Hmac(sha256, key);
  Digest digest = hmacSha256.convert(_signature);
  String url = BaseUrl + 'retribusi/billcode';
  Map<String, String> h = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
    'Timestamp': timeStamp,
    'Signature': digest.toString(),
  };
  List jsonList = billCode;
  Map b = {'username': noHp, 'daftar_ntrd': jsonList};
  print(b);
  var response =
  await http.post(Uri.parse(url), headers: h, body: json.encode(b));
  if (response.statusCode == 200 || response.statusCode == 201) {
    var responseJson = json.decode(response.body);
    print(responseJson);
    return BillCode.fromJson(json.decode(response.body));
  } else {
    print(response.body);
    return null;
  }
}
