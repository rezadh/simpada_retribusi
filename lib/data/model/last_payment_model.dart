import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:simpada/constants.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class LastPayment {
  String tanggalPenagihan;
  String nominal;
  String periode;
  String satuanPeriode;
  String ntrd;
  String status;
  String npwrd;

  LastPayment({
    this.ntrd,
    this.tanggalPenagihan,
    this.nominal,
    this.periode,
    this.satuanPeriode,
    this.status,
    this.npwrd
  });

  LastPayment.fromJson(Map<String, dynamic> object) {
    tanggalPenagihan = object['tgl_pungut'];
    nominal = object['nominal'];
    periode = object['periode_bayar'];
    satuanPeriode = object['satuan_periode'];
    ntrd = object['ntrd'];
    status = object['status'].toString();
    npwrd = object['npwrd'].toString();
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