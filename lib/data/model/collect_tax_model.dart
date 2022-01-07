import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:simpada/constants.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'objek_retribusi_model.dart';


class CollectTax {
  String rc;
  String description;
  String npwrd;
  String tanggalPenagihan;
  String nominal;
  String periode;
  String jumlahBayar;
  String satuanPeriode;
  String ntrd;
  List<ObjekRetribusi> objekRetribusi;

  CollectTax(
      {this.rc,
        this.description,
        this.npwrd,
        this.tanggalPenagihan,
        this.nominal,
        this.periode,
        this.jumlahBayar,
        this.satuanPeriode,
        this.ntrd,
        this.objekRetribusi});

  CollectTax.fromJson(Map<String, dynamic> object) {
    rc = object['rc'];
    description = object['description'];
    npwrd = object['npwrd'];
    tanggalPenagihan = object['tgl_pungut'];
    nominal = object['nominal'];
    periode = object['periode'];
    jumlahBayar = object['jumlah_bayar_maju'];
    satuanPeriode = object['satuan_periode'];
    ntrd = object['ntrd'];
    if (object['objek_retribusi'] != null) {
      objekRetribusi = [];
      object['objek_retribusi'].forEach((v) {
        objekRetribusi.add(new ObjekRetribusi.fromJson(v));
      });
    }
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