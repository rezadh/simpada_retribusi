import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:simpada/constants.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ListNTRD {
  String rc;
  String description;
  String tanggalPenagihan;
  String nominal;
  String periode;
  String jumlahBayar;
  String satuanPeriode;
  String ntrd;
  var status;
  bool selected = false;

  ListNTRD(
      {this.ntrd,
        this.tanggalPenagihan,
        this.nominal,
        this.periode,
        this.jumlahBayar,
        this.satuanPeriode,
        this.description,
        this.rc,
        this.selected,
        this.status});

  ListNTRD.fromJson(Map<String, dynamic> object) {
    rc = object['rc'];
    description = object['description'];
    tanggalPenagihan = object['tgl_pungut'];
    nominal = object['nominal'];
    periode = object['periode'];
    jumlahBayar = object['jumlah_bayar_maju'];
    satuanPeriode = object['satuan_periode'];
    ntrd = object['ntrd'];
    status = object['status'];
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