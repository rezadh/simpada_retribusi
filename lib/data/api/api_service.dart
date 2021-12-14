import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:simpada/constants.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:simpada/data/model/simpada_retribusi.dart';

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

Future<CollectTax> postCollectTax(
    String username, Map body) async {
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
    'tgl_pungut': body['tgl_pungut'],
    'total_setor_pajak_retribusi': body['total_setor_pajak_retribusi'],
    'objek_retribusi': body['objek_retribusi'],
    'username': body['username'],
  };
  print('ini body $b');
  var response =
      await http.post(Uri.parse(url), headers: h, body: json.encode(b));
  print(response.body);
  print(response);
  if (response.statusCode == 200 || response.statusCode == 201) {
    print('ini response collect tax ${response.body}');
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
Future<List<Profile>> postRequestProfile(List npwrd) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var api = prefs.getString('apikey');
  DateTime dateNow = DateTime.now();
  var token = prefs.getString('token');
  var noHp = prefs.getString('noHp');
  var date = DateFormat("yyyy-MM-dd").format(dateNow);
  var time = DateFormat("HH:mm:ss.sss").format(dateNow);
  var clientTime = DateFormat('dd-MM-yyyy HH:mm:ss').format(dateNow);
  String timeStamp = date + 'T' + time + 'Z';
  var _signature = utf8.encode('$noHp:$timeStamp');
  var key = utf8.encode(api);
  var hmacSha256 = Hmac(sha256, key);
  Digest digest = hmacSha256.convert(_signature);
  String url = BaseUrl + 'retribusi/wr/profile';
  Map<String, String> h = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
    'Timestamp': timeStamp,
    'Signature': digest.toString(),
  };
  List jsonList = npwrd;
  Map b = {'npwrd': jsonList, 'tgl_request': clientTime, 'username': noHp};
  var response =
  await http.post(Uri.parse(url), headers: h, body: json.encode(b));
  if (response.statusCode == 200 || response.statusCode == 201) {
    List responseJson = json.decode(response.body)['daftar_wr'];
    return responseJson.map((e) => Profile.fromJson(e)).toList();
  } else {
    print(response.body);
    return null;
  }
}

Future<List<HistoryBill>> postRequestHistoryBill() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var api = prefs.getString('apikey');
  DateTime dateNow = DateTime.now();
  var token = prefs.getString('token');
  var noHp = prefs.getString('noHp');
  // var billingCode = prefs.getString('billcode');
  var date = DateFormat("yyyy-MM-dd").format(dateNow);
  var time = DateFormat("HH:mm:ss.sss").format(dateNow);
  var clientTime = DateFormat('dd-MM-yyyy HH:mm:ss').format(dateNow);
  String timeStamp = date + 'T' + time + 'Z';
  var _signature = utf8.encode('$noHp:$timeStamp');
  var key = utf8.encode(api);
  var hmacSha256 = Hmac(sha256, key);
  Digest digest = hmacSha256.convert(_signature);
  String url = BaseUrl + 'retribusi/billcode/history/1';
  Map<String, String> h = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
    'Timestamp': timeStamp,
    'Signature': digest.toString(),
  };
  Map b = {'tgl': clientTime, 'username': noHp};
  var response =
  await http.post(Uri.parse(url), headers: h, body: json.encode(b));
  if (response.statusCode == 200 || response.statusCode == 201) {
    List responseJson = json.decode(response.body)['list'];
    return responseJson.map((e) => HistoryBill.fromJson(e)).toList();
    // return HistoryBill.fromJson(json.decode(response.body));
  } else {
    print(response.body);
    return null;
  }
}
Future<List<HistoryBill>> postRequestSetoranBill() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var api = prefs.getString('apikey');
  DateTime dateNow = DateTime.now();
  var token = prefs.getString('token');
  var noHp = prefs.getString('noHp');
  // var billingCode = prefs.getString('billcode');
  var date = DateFormat("yyyy-MM-dd").format(dateNow);
  var time = DateFormat("HH:mm:ss.sss").format(dateNow);
  var clientTime = DateFormat('dd-MM-yyyy HH:mm:ss').format(dateNow);
  String timeStamp = date + 'T' + time + 'Z';
  var _signature = utf8.encode('$noHp:$timeStamp');
  var key = utf8.encode(api);
  var hmacSha256 = Hmac(sha256, key);
  Digest digest = hmacSha256.convert(_signature);
  String url = BaseUrl + 'retribusi/billcode/history/0';
  Map<String, String> h = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
    'Timestamp': timeStamp,
    'Signature': digest.toString(),
  };
  Map b = {'tgl': clientTime, 'username': noHp};
  var response =
  await http.post(Uri.parse(url), headers: h, body: json.encode(b));
  if (response.statusCode == 200 || response.statusCode == 201) {
    List responseJson = json.decode(response.body)['list'];
    return responseJson.map((e) => HistoryBill.fromJson(e)).toList();
    // return HistoryBill.fromJson(json.decode(response.body));
  } else {
    print(response.body);
    return null;
  }
}
Future<List<LastPayment>> postRequestLastPayment() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var api = prefs.getString('apikey');
  DateTime dateNow = DateTime.now();
  var token = prefs.getString('token');
  var noHp = prefs.getString('noHp');
  var npwrd = prefs.getString('npwrd');
  print(npwrd);
  var date = DateFormat("yyyy-MM-dd").format(dateNow);
  var time = DateFormat("HH:mm:ss.sss").format(dateNow);
  var clientTime = DateFormat('dd-MM-yyyy HH:mm:ss').format(dateNow);
  String timeStamp = date + 'T' + time + 'Z';
  var _signature = utf8.encode('$noHp:$timeStamp');
  var key = utf8.encode(api);
  var hmacSha256 = Hmac(sha256, key);
  Digest digest = hmacSha256.convert(_signature);
  String url = BaseUrl + 'retribusi/history/collect';
  Map<String, String> h = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
    'Timestamp': timeStamp,
    'Signature': digest.toString(),
  };
  print(clientTime);
  Map b = {'tgl': clientTime, 'username': noHp};
  var response =
  await http.post(Uri.parse(url), headers: h, body: json.encode(b));
  print(response.body);
  if (response.statusCode == 200 || response.statusCode == 201) {
    List responseJson = json.decode(response.body)['daftar'];
    return responseJson.map((e) => LastPayment.fromJson(e)).toList();
  } else {
    print(response.statusCode);
    print(response.body);
    return null;
  }
}
Future<List<DaftarProdukAtas>> postRequestProduk(String npwrd) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var api = prefs.getString('apikey');
  DateTime dateNow = DateTime.now();
  var token = prefs.getString('token');
  var noHp = prefs.getString('noHp');
  var date = DateFormat("yyyy-MM-dd").format(dateNow);
  var time = DateFormat("HH:mm:ss.sss").format(dateNow);
  var clientTime = DateFormat('dd-MM-yyyy HH:mm:ss').format(dateNow);
  String timeStamp = date + 'T' + time + 'Z';
  var _signature = utf8.encode('$noHp:$timeStamp');
  var key = utf8.encode(api);
  var hmacSha256 = Hmac(sha256, key);
  Digest digest = hmacSha256.convert(_signature);
  String url = BaseUrl + 'retribusi/wr/produk';
  Map<String, String> h = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
    'Timestamp': timeStamp,
    'Signature': digest.toString(),
  };
  Map b = {'npwrd': npwrd, 'tgl_request': clientTime, 'username': noHp};
  var response =
  await http.post(Uri.parse(url), headers: h, body: json.encode(b));
  if (response.statusCode == 200 || response.statusCode == 201) {
    Map responseJson = json.decode(response.body);
    List daftarProduk = responseJson['daftar_produk'];
    List <DaftarProdukAtas> daftar = daftarProduk.map((e) => DaftarProdukAtas.fromJson(e)).toList();
    return daftar;
  } else {
    print(response.body);
    return null;
  }
}