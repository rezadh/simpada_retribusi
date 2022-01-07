import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:simpada/constants.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'daftar_wr_model.dart';

class Profile {
  String rc;
  String description;
  List<DaftarWr> daftarWr;
  String npwrd;
  String namaWr;
  String alamat;
  String noTelp;

  Profile(
      {this.rc,
        this.description,
        this.daftarWr,
        this.npwrd,
        this.namaWr,
        this.alamat,
        this.noTelp});

  Profile.fromJson(Map<String, dynamic> object) {
    rc = object['rc'];
    description = object['description'];
    daftarWr = object['daftar_wr'];
    npwrd = object['npwrd'];
    namaWr = object['nama_wr'];
    alamat = object['alamat'];
    noTelp = object['tlpn'];
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