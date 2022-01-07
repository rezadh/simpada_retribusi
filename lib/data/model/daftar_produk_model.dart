import 'lokasi_model.dart';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:simpada/constants.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DaftarProdukAtas {
  Lokasi lokasi;

  DaftarProdukAtas({this.lokasi});

  DaftarProdukAtas.fromJson(Map<String, dynamic> json) {
    lokasi =
    json['lokasi'] != null ? new Lokasi.fromJson(json['lokasi']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lokasi != null) {
      data['lokasi'] = this.lokasi.toJson();
    }
    return data;
  }
}
class DaftarProdukBawah {
  int idProduk;
  String namaProduk;
  String type;
  int tarif;
  String satuanPeriode;
  String terakhirBayar;
  String periodeTerakhirBayar;

  DaftarProdukBawah(
      {this.idProduk,
        this.namaProduk,
        this.type,
        this.tarif,
        this.satuanPeriode,
        this.terakhirBayar,
        this.periodeTerakhirBayar});

  DaftarProdukBawah.fromJson(Map<String, dynamic> json) {
    idProduk = json['id_produk'];
    namaProduk = json['nama_produk'];
    type = json['type'];
    tarif = json['tarif'];
    satuanPeriode = json['satuan_periode'];
    terakhirBayar = json['terakhir_pungut'];
    periodeTerakhirBayar = json['periode_terakhir_bayar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama_produk'] = this.namaProduk;
    data['type'] = this.type;
    data['tarif'] = this.tarif;
    data['satuan_periode'] = this.satuanPeriode;
    return data;
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