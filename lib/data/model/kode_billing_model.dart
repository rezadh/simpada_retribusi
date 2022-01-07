import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:simpada/constants.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BillCode {
  String rc;
  String description;
  List<String> daftarNTRD;
  String billCode;
  String tanggalKadaluarsa;

  BillCode(
      {this.rc,
        this.description,
        this.daftarNTRD,
        this.billCode,
        this.tanggalKadaluarsa});

  BillCode.fromJson(Map<String, dynamic> object) {
    rc = object['rc'];
    daftarNTRD = object['daftar_ntrd'].cast<String>();
    description = object['description'];
    billCode = object['billing_code'];
    tanggalKadaluarsa = object['tgl_kadaluarsa'];
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