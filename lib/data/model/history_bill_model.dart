import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:simpada/constants.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'list_billing_ntrd_model.dart';


class HistoryBill {
  String tglKedaluwarsa;
  String status;
  String nominal;
  String tglDibentuk;
  String tglBayar;
  String kodeBilling;
  List<ListBillingNTRD> listBilingNTRD;

  HistoryBill(
      {this.tglKedaluwarsa,
        this.status,
        this.nominal,
        this.tglDibentuk,
        this.tglBayar,
        this.kodeBilling,
        this.listBilingNTRD});

  HistoryBill.fromJson(Map<String, dynamic> object) {
    tglKedaluwarsa = object['tgl_kadaluarsa'];
    status = object['status'].toString();
    nominal = object['nominal_tagihan'];
    tglDibentuk = object['tgl_dibentuk'];
    tglBayar = object['tgl_bayar'];
    kodeBilling = object['kode_billing'];
    if (object['list_ntrd'] != null) {
      listBilingNTRD = new List<ListBillingNTRD>();
      object['list_ntrd'].forEach((v) {
        listBilingNTRD.add(new ListBillingNTRD.fromJson(v));
      });
    }
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
    print(responseJson);
    return responseJson.map((e) => HistoryBill.fromJson(e)).toList();
    // return HistoryBill.fromJson(json.decode(response.body));
  } else {
    print(response.body);
    return null;
  }
}