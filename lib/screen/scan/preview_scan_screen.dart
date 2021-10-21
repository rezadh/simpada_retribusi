import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpada/data/api/api_service.dart';
import 'package:simpada/data/model/simpada_retribusi.dart';
import 'package:http/http.dart' as http;
import 'package:simpada/screen/transaksi/transaksi_screen.dart';
import '../../constants.dart';

class PreviewScanScreen extends StatefulWidget {
  final npwrd;
  final jenisRetribusi;
  final jenisProduk;
  final namaWajibRetribusi;
  final nominalPajak;
  final periodePenagihan;
  final lokasiRetribusi;
  final username;
  final name;
  final dateNow;

  PreviewScanScreen({this.npwrd,
    this.jenisRetribusi,
    this.jenisProduk,
    this.namaWajibRetribusi,
    this.nominalPajak,
    this.periodePenagihan,
    this.lokasiRetribusi,
    this.name,
    this.username,
    this.dateNow});

  @override
  _PreviewScanScreenState createState() => _PreviewScanScreenState();
}

class _PreviewScanScreenState extends State<PreviewScanScreen> {
  TextEditingController totalBayarController = TextEditingController(text: '1');

  String _npwrd;
  String _jenisRetribusi;
  String _namaWajibRetribusi;
  int _totalNilai;
  String _name;
  String _jenisProduk;
  String _periodePenagihan;
  var _dateNow;
  var _formatPeriode;
  var _periodeBayar;
  var _periodeBayarPreview;
  var _newDate;
  String _parseMonth;
  String _parseMonthPreview;
  Future<List<Produk>> futureData;
  String namaLokasi;
  String tempatRetribusi;
  int _totalPenagihan = 1;
  var tglPungut;
  int idProduk;
  int idTempat;
  int tarif;
  var _formatNewDate;

  Future<List<Produk>> postRequestProduk(String npwrd) async {
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
      Map data1 = daftarProduk[0];
      Map lokasi = data1['lokasi'];
      namaLokasi = lokasi['nama'];
      idProduk = lokasi['id'];
      List daftarTempat = lokasi['daftar_tempat'];
      Map tempat1 = daftarTempat[0];
      tempatRetribusi = tempat1['nama'];
      idTempat = tempat1['id'];
      List daftarProduk1 = tempat1['daftar_produk'];
      Map daftarProduk2 = daftarProduk1[0];
      tarif = daftarProduk2['tarif'];
      return daftarProduk1.map((e) => Produk.fromJson(e)).toList();
    } else {
      print(response.body);
      return null;
    }
  }

  void getWidgetData() {
    _npwrd = widget.npwrd;
    _namaWajibRetribusi = widget.namaWajibRetribusi;
    _jenisRetribusi = widget.jenisRetribusi;
    _name = widget.name;
    _dateNow = widget.dateNow;
  }

  void _getPeriodePenagihan(String periode, int penagihan) {
    var dateNow = DateTime.now();
    var dayDateNow = DateFormat('dd').format(dateNow);
    var monthDateNow = DateFormat('MM').format(dateNow);
    var yearDateNow = DateFormat('yyyy').format(dateNow);
    var formatDateNow = DateFormat('ddMMyyyy').format(dateNow);
    var parseMonthDateNow;
    parseMonthDateNow = getMonth(monthDateNow);
    tglPungut = DateFormat('dd-MM-yyyy HH:mm:ss').format(dateNow);
    if (periode.toLowerCase() == 'harian') {
      _newDate = dateNow.add(Duration(
        days: _totalPenagihan == null ? _totalPenagihan : penagihan,
      ));
    } else if (periode.toLowerCase() == 'mingguan') {
      _newDate = dateNow.add(Duration(
        days: _totalPenagihan == null ? _totalPenagihan * 7 : penagihan * 7,
      ));
    } else if (periode.toLowerCase() == 'bulanan') {
      _newDate = DateTime(
        dateNow.year,
        dateNow.month + (_totalPenagihan == null ? _totalPenagihan : penagihan),
        dateNow.day,
      );
    } else if (periode.toLowerCase() == 'tahunan') {
      _newDate = DateTime(
        dateNow.year + (_totalPenagihan == null ? _totalPenagihan : penagihan),
        dateNow.month,
        dateNow.day,
      );
    }
    var _newDay = DateFormat('dd').format(_newDate);
    var _newMonth = DateFormat('MM').format(_newDate);
    var _newYear = DateFormat('yy').format(_newDate);
    var _newYearPreview = DateFormat('yyyy').format(_newDate);
    _formatNewDate = DateFormat('ddMMyyyy').format(_newDate);
    _parseMonth = getMonthPreview(_newMonth);
    _parseMonthPreview = getMonth(_newMonth);
    if (int.parse(_newMonth) == int.parse(monthDateNow)) {
      _periodeBayar = '$dayDateNow - $_newDay $_parseMonth $_newYear';
      _periodeBayarPreview = '$_newDay $_parseMonthPreview $_newYearPreview';
    } else if (int.parse(_newMonth) > int.parse(monthDateNow)) {
      _periodeBayar = '$dayDateNow $parseMonthDateNow - $_newDay $_parseMonthPreview $_newYear';
      _periodeBayarPreview = '$_newDay $_parseMonth $_newYearPreview';
    } else if (int.parse(_newYear) > int.parse(yearDateNow)) {
      _periodeBayar = '$dayDateNow $parseMonthDateNow $yearDateNow - $_newDay $_parseMonthPreview $_newYear';
      _periodeBayarPreview = '$_newDay $_parseMonth $_newYearPreview';
    }
    _formatPeriode = '$formatDateNow/$_formatNewDate';
  }

  String getMonth(String month) {
    if (month == '01') {
      return 'Jan';
    } else if (month == '02') {
      return 'Feb';
    } else if (month == '03') {
      return 'Mar';
    } else if (month == '04') {
      return 'Apr';
    } else if (month == '05') {
      return 'Mei';
    } else if (month == '06') {
      return 'Jun';
    } else if (month == '07') {
      return 'Jul';
    } else if (month == '08') {
      return 'Agu';
    } else if (month == '09') {
      return 'Sep';
    } else if (month == '10') {
      return 'Okt';
    } else if (month == '11') {
      return 'Nov';
    } else if (month == '12') {
      return 'Des';
    }
    return null;
  }

  String getMonthPreview(String month) {
    if (month == '01') {
      return 'Januari';
    } else if (month == '02') {
      return 'Februari';
    } else if (month == '03') {
      return 'Maret';
    } else if (month == '04') {
      return 'April';
    } else if (month == '05') {
      return 'Mei';
    } else if (month == '06') {
      return 'Juni';
    } else if (month == '07') {
      return 'Juli';
    } else if (month == '08') {
      return 'Agustus';
    } else if (month == '09') {
      return 'September';
    } else if (month == '10') {
      return 'Oktober';
    } else if (month == '11') {
      return 'November';
    } else if (month == '12') {
      return 'Desember';
    }
    return null;
  }

  @override
  void initState() {
    setState(() {
      getWidgetData();
      futureData = postRequestProduk(widget.npwrd);
      postRequestProduk(widget.npwrd);
      print(futureData);
    });
    // getUser().then((id) {
    //   _name = id;
    // });
    super.initState();
  }

  void _postRequestCollect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var noHp = prefs.getString('noHp');
    prefs.setString('npwrd', widget.npwrd);
    prefs.setString('nama_wr', widget.namaWajibRetribusi);
    prefs.setString('jenis_retribusi', widget.jenisRetribusi);
    prefs.setString('jenis_produk', _jenisProduk);
    prefs.setString('nama_lokasi', namaLokasi);
    postRequestProduk(widget.npwrd);
    Map mabs =
    {
      "id_tempat": idTempat.toString(),
      "id_produk": idProduk.toString(),
      "nominal": tarif.toString(),
      "periode": _formatNewDate,
      "jumlah_bayar_maju": _totalPenagihan.toString(),
    };
    List mab = [];
    mab.add(mabs);
    Map body = {
      'npwrd': _npwrd,
      'tgl_pungut': tglPungut.toString(),
      'total_setor_pajak_retribusi': _totalNilai == null ? tarif.toString() : _totalNilai.toString(),
      'objek_retribusi': mab,
      'username': noHp,
      //   'nominal':
      //       _parseTotalNilai == null ? _parseNominalPajak : _parseTotalNilai,
      //   'periode': _formatPeriode,
      //   'jumlah_bayar': _totalBayar == null ? '1' : _totalBayar,
      //   'satuan_periode': _periodePenagihan,
    };
    print(body);
    // await postCollectTax(noHp, body).then((value) {
    //   if (value != null) {
    //     postCollectTax(noHp, password, body);
        print(postCollectTax(noHp, body));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransaksiScreen(
              npwrd: _npwrd,
              tanggalPenagihan: _dateNow,
              nominalPajak: tarif.toString(),
              jenisProduk: _jenisProduk,
              jenisRetribusi: _jenisRetribusi,
              lokasiRetribusi: namaLokasi,
              namaWajibRetribusi: _namaWajibRetribusi,
              name: _name,
              periodePenagihan: _periodePenagihan,
    //           totalNilai: _parseTotalNilai == null
    //               ? _parseNominalPajak
    //               : _parseTotalNilai,
    //           dibayarkan: _totalBayar == null ? '1' : _totalBayar,
              periodeBayar: _periodeBayar,
            ),
          ),
        );
      // } else {
      //   showPop('Pembayaran Gagal', 'Silahkan cek kembali data pembayaran');
      // }
    // });
  }

  Future<bool> showPop(String title, String message) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text(
                title,
                style: TextStyle(fontSize: 18),
              ),
              content: Text(
                message,
                style: TextStyle(fontSize: 16),
                // textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('TUTUP'),
                ),
              ],
            ),
      );
  bool shouldPop = true;

  // Future<bool> _onWillPopScope() async {
  //   return Navigator.of(context).pop(true);
  // }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    return WillPopScope(
      onWillPop: () async {
        return shouldPop;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFECECEC),
        appBar: AppBar(
          backgroundColor: Color(0xFF2E93E1),
          centerTitle: true,
          title: Text(
            'Scan',
            style: TextStyle(
                fontFamily: 'poppins regular',
                fontSize: 14.0,
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        ),
        body: Container(
          child: FutureBuilder<List<Produk>>(
            future: postRequestProduk(widget.npwrd),
            builder: (context, snapshot) {
              List<Produk> data = snapshot.data;
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {

                    _getPeriodePenagihan(
                        data[index].satuanPeriode, _totalPenagihan);
                    _jenisProduk = data[index].type;
                    _periodePenagihan =  data[index].satuanPeriode;
                    return Container(
                      height: size.height - 80,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: MaterialButton(
                              color: Color(0xFF01A190),
                              minWidth: size.width,
                              height: 50,
                              onPressed: () {
                                print(_formatPeriode);
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      AlertDialog(
                                        // title: Text(
                                        //   title,
                                        //   style: TextStyle(fontSize: 18),
                                        // ),
                                        // content: Text(
                                        //   message,
                                        //   style: TextStyle(fontSize: 14),
                                        //   // textAlign: TextAlign.center,
                                        // ),
                                        actions: [
                                          Container(
                                            width: size.width,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center,
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              children: [
                                                Container(
                                                  width: 92,
                                                  height: 92,
                                                  alignment: Alignment.center,
                                                  // padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFFF2994A),
                                                      borderRadius: BorderRadius
                                                          .circular(50),
                                                      border: Border.all(
                                                          width: 2,
                                                          color: Colors.white)),
                                                  child: FaIcon(
                                                    FontAwesomeIcons
                                                        .exclamation,
                                                    size: 50,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(height: 12),
                                                Text(
                                                  _totalNilai == null
                                                      ? NumberFormat
                                                      .simpleCurrency(
                                                      locale: 'id',
                                                      decimalDigits: 0)
                                                      .format(data[index].tarif)
                                                      .toString()
                                                      : NumberFormat
                                                      .simpleCurrency(
                                                      locale: 'id',
                                                      decimalDigits: 0)
                                                      .format(_totalNilai)
                                                      .toString(),
                                                  // _parseTotalNilai == null
                                                  //     ? 'Total Bayar : $_parseNominalPajak'
                                                  //     : 'Total Bayar : $_parseTotalNilai',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight
                                                          .w800,
                                                      color: Color(0xFF252B42),
                                                      fontFamily: 'opensans regular'),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Yakin akan melanjutkan transaksi?',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight
                                                          .w700,
                                                      color: Color(0xFF252B42),
                                                      fontFamily: 'opensans regular'),
                                                ),
                                                SizedBox(
                                                  height: 11,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    MaterialButton(
                                                      minWidth: 115,
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      color: Color(0xFFFFFFFF),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                        side: BorderSide(
                                                          color: Color(
                                                            0xFF01A190,
                                                          ),
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      child: Text(
                                                        'Tidak',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight
                                                                .w700,
                                                            color: Color(
                                                                0xFF009A8A),
                                                            fontFamily: 'opensans regular'),
                                                      ),
                                                    ),
                                                    MaterialButton(
                                                      minWidth: 115,
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        _postRequestCollect();
                                                      },
                                                      color: Color(0xFF01A190),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                        side: BorderSide(
                                                          color: Color(
                                                            0xFF01A190,
                                                          ),
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      child: Text(
                                                        'Proses',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight
                                                                .w700,
                                                            color: Color(
                                                                0xFFFFFFFF),
                                                            fontFamily: 'opensans regular'),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                );
                              },
                              child: Text(
                                'Bayar',
                                style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontFamily: 'poppins regular',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          Container(
                            width: size.width,
                            height: size.height - 130,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    'Simpada Retribusi',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'opensans regular'),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Preview',
                                    style: TextStyle(
                                        color: Color(0xFF757F8C),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'opensans regular'),
                                  ),
                                  SizedBox(
                                    height: 19,
                                  ),
                                  Card(
                                    margin: EdgeInsets.only(
                                      left: 25,
                                      right: 25,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9.0),
                                    ),
                                    elevation: 1,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 20,
                                          bottom: 23,
                                          top: 14,
                                          right: 17),
                                      width: size.width,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 135,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'NPWRD',
                                                      style: TextStyle(
                                                          color:
                                                          Color(0xFF757F8C),
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          fontFamily:
                                                          'opensans regular'),
                                                    ),
                                                    Text(':'),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                _npwrd.toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily:
                                                    'opensans regular'),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 11),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 135,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Wajib Retribusi',
                                                      style: TextStyle(
                                                          color:
                                                          Color(0xFF757F8C),
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          fontFamily:
                                                          'opensans regular'),
                                                    ),
                                                    Text(':'),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                _namaWajibRetribusi.toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily:
                                                    'opensans regular'),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 11,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 135,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Jenis Retribusi',
                                                      style: TextStyle(
                                                          color:
                                                          Color(0xFF757F8C),
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          fontFamily:
                                                          'opensans regular'),
                                                    ),
                                                    Text(':'),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                _jenisRetribusi.toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily:
                                                    'opensans regular'),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 11,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 135,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Jenis Produk',
                                                      style: TextStyle(
                                                          color:
                                                          Color(0xFF757F8C),
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          fontFamily:
                                                          'opensans regular'),
                                                    ),
                                                    Text(':'),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                data[index].type,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily:
                                                    'opensans regular'),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 11,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 135,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Penanggung Jawab',
                                                      style: TextStyle(
                                                          color:
                                                          Color(0xFF757F8C),
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          fontFamily:
                                                          'opensans regular'),
                                                    ),
                                                    Text(':'),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                _name.toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily:
                                                    'opensans regular'),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 11,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 135,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Periode Penagihan',
                                                      style: TextStyle(
                                                          color:
                                                          Color(0xFF757F8C),
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          fontFamily:
                                                          'opensans regular'),
                                                    ),
                                                    Text(':'),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                data[index].satuanPeriode,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily:
                                                    'opensans regular'),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 11,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 135,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Lokasi Retribusi',
                                                      style: TextStyle(
                                                          color:
                                                          Color(0xFF757F8C),
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          fontFamily:
                                                          'opensans regular'),
                                                    ),
                                                    Text(':'),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                namaLokasi,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily:
                                                    'opensans regular'),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 11,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 135,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Tempat Retribusi',
                                                      style: TextStyle(
                                                          color:
                                                          Color(0xFF757F8C),
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          fontFamily:
                                                          'opensans regular'),
                                                    ),
                                                    Text(':'),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                tempatRetribusi,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily:
                                                    'opensans regular'),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 11,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 135,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Terakhir Bayar',
                                                      style: TextStyle(
                                                          color:
                                                          Color(0xFF757F8C),
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          fontFamily:
                                                          'opensans regular'),
                                                    ),
                                                    Text(':'),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                _dateNow.toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily:
                                                    'opensans regular'),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 11,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 135,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Penagihan',
                                                      style: TextStyle(
                                                          color:
                                                          Color(0xFF757F8C),
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          fontFamily:
                                                          'opensans regular'),
                                                    ),
                                                    Text(
                                                      _periodeBayarPreview.toString(),
                                                      style: TextStyle(
                                                          color:
                                                          Color(0xFF3B414B),
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 106,
                                                height: 33,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFFF9000),
                                                  // border: Border.all(color: Colors.grey),
                                                  borderRadius:
                                                  BorderRadius.circular(30.0),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceAround,
                                                  children: [
                                                    _totalPenagihan == 1
                                                        ? Text(
                                                      '-',
                                                      style: TextStyle(
                                                          color:
                                                          Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight
                                                              .w700),
                                                    )
                                                        : GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          _totalPenagihan =
                                                              _totalPenagihan -
                                                                  1;
                                                          _totalNilai = data[
                                                          index]
                                                              .tarif *
                                                              _totalPenagihan;
                                                          _getPeriodePenagihan(
                                                              data[index]
                                                                  .satuanPeriode,
                                                              _totalPenagihan);
                                                        });
                                                      },
                                                      child: Text(
                                                        '-',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                            FontWeight
                                                                .w700),
                                                      ),
                                                    ),
                                                    Text(
                                                      _totalPenagihan
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.w700),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          _totalPenagihan =
                                                              _totalPenagihan +
                                                                  1;
                                                          _totalNilai =
                                                              data[index]
                                                                  .tarif *
                                                                  _totalPenagihan;
                                                          _getPeriodePenagihan(
                                                              data[index]
                                                                  .satuanPeriode,
                                                              _totalPenagihan);
                                                        });
                                                      },
                                                      child: Text(
                                                        '+',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                            FontWeight.w700),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Text(
                                              //   _dateNow.toString(),
                                              //   style: TextStyle(
                                              //       fontSize: 14,
                                              //       fontWeight: FontWeight.w600,
                                              //       fontFamily:
                                              //       'opensans regular'),
                                              // ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 11,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 135,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Nilai Retribusi',
                                                      style: TextStyle(
                                                          color:
                                                          Color(0xFF757F8C),
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                          fontFamily:
                                                          'opensans regular'),
                                                    ),
                                                    Text(':'),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                _totalNilai == null
                                                    ? NumberFormat
                                                    .simpleCurrency(
                                                    locale: 'id',
                                                    decimalDigits: 0)
                                                    .format(data[index].tarif)
                                                    .toString()
                                                    : NumberFormat
                                                    .simpleCurrency(
                                                    locale: 'id',
                                                    decimalDigits: 0)
                                                    .format(_totalNilai)
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily:
                                                    'opensans regular'),
                                              ),
                                            ],
                                          ),
                                          _dash(context),
                                          SizedBox(
                                            height: 13,
                                          ),
                                          Center(
                                            child: Image.asset(
                                              'images/logo.png',
                                              width: 110,
                                            ),
                                          ),
                                          // Row(
                                          //   crossAxisAlignment:
                                          //       CrossAxisAlignment.end,
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.spaceBetween,
                                          //   children: [
                                          //     Image.asset(
                                          //       'images/bank_sulselbar.png',
                                          //       width: 100,
                                          //     ),
                                          //     Image.asset(
                                          //       'images/logo.png',
                                          //       width: 110,
                                          //     ),
                                          //   ],
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 24),
                                  Padding(
                                    padding: EdgeInsets.only(left: 25),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: [
                                        Text('Metode Pembayaran',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'poppins regular')),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          SnackBar(content: Text(
                                              'Under Development')));
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => MetodePembayaranScreen(),
                                      //   ),
                                      // );
                                    },
                                    child: Card(
                                      margin: EdgeInsets.all(24),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            16.0),
                                        side: BorderSide(
                                            color: Color(0xFFBDBDBD), width: 1),
                                      ),
                                      elevation: 1,
                                      child: Container(
                                        padding: EdgeInsets.all(18),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                    padding: EdgeInsets.all(2),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(8),
                                                      color: Color(0xFFFFFFFF),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey,
                                                            offset: Offset(
                                                                0.0, 1.0),
                                                            blurRadius: 2.0),
                                                      ],
                                                    ),
                                                    child: Image.asset(
                                                        'images/cash.png')),
                                                SizedBox(width: 10),
                                                Text(
                                                  'Pembayaran Cash',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight
                                                          .w700),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  'Lihat Semua',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w800,
                                                    color: Color(0xFF2F80ED),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.keyboard_arrow_right,
                                                  color: Color(0xFF2F80ED),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              return Text('');
            },
          ),
        ),
      ),
    );
  }
}

Widget _dash(BuildContext context) {
  final Size size = MediaQuery
      .of(context)
      .size;
  final dashWidth = 10.0;
  final dashCount = (size.width / (2 * dashWidth)).floor();
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20.0),
    child: Flex(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      direction: Axis.horizontal,
      children: List.generate(dashCount, (_) {
        return SizedBox(
          width: dashWidth,
          height: 1,
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.grey),
          ),
        );
      }),
    ),
  );
}
