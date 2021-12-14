import 'dart:async';
import 'dart:convert';
import 'dart:io' as Io;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpada/screen/dashboard/dashboard_screen.dart';

class BuktiBayarScreen extends StatefulWidget {
  final npwrd;
  final jenisRetribusi;
  final jenisProduk;
  final namaWajibRetribusi;
  final nominalPajak;
  final periodePenagihan;
  final lokasiRetribusi;
  final name;
  final tanggalPenagihan;
  final totalNilai;
  final dibayarkan;
  final periodeBayar;
  final tempatRetribusi;

  BuktiBayarScreen(
      {this.npwrd,
      this.jenisRetribusi,
      this.jenisProduk,
      this.namaWajibRetribusi,
      this.nominalPajak,
      this.periodePenagihan,
      this.lokasiRetribusi,
      this.name,
      this.tanggalPenagihan,
      this.totalNilai,
      this.dibayarkan,
      this.periodeBayar, this.tempatRetribusi});

  @override
  _BuktiBayarScreenState createState() => _BuktiBayarScreenState();
}

class _BuktiBayarScreenState extends State<BuktiBayarScreen> {
  String _npwrd;
  String _jenisRetribusi;
  String _jenisProduk;
  String _namaWajibRetribusi;
  String _nominalPajak;
  String _periodePenagihan;
  String _lokasiRetribusi;
  String _totalNilai;
  String _name;
  String _dibayarkan;
  String _periodeBayar;
  String _tempatRetribusi;
  var _tanggalPenagihan;
  int _valueValidation = 0;

  void getWidgetData() {
    _npwrd = widget.npwrd;
    _jenisRetribusi = widget.jenisRetribusi;
    _jenisProduk = widget.jenisProduk;
    _namaWajibRetribusi = widget.namaWajibRetribusi;
    _nominalPajak = widget.nominalPajak;
    _periodePenagihan = widget.periodePenagihan;
    _lokasiRetribusi = widget.lokasiRetribusi;
    _dibayarkan = widget.dibayarkan;
    _name = widget.name;
    _totalNilai = widget.totalNilai;
    _tanggalPenagihan = widget.tanggalPenagihan;
    _periodeBayar = widget.periodeBayar;
    _tempatRetribusi = widget.tempatRetribusi;
  }

  static const platformMethodChannel = const MethodChannel('com.pac.print/edc');

  Future<bool> _initPrinter() async {
    try {
      final bool result = await platformMethodChannel.invokeMethod('connect');
      return result;
    } on PlatformException catch (e) {
      return false;
    }
  }

  Future _printData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('nama');
    await _initPrinter().then((value) {
      if (!value) {
        return;
      }
    });
    // File filePhoto = File('images/logo.png');
    // List<int> imageBytes = await filePhoto.readAsBytes();
    // String base64Image = base64Encode(imageBytes);
    // getDate();
    ByteData bytes = await rootBundle.load('images/logo.png');
    // ByteData bytes = await rootBundle.load('assets/images/logo_splash.png');
    var buffer = bytes.buffer;
    var base64Image = base64.encode(Uint8List.view(buffer));
    // final bytes = Io.File("images/logo.png").readAsBytesSync();
    // String base64Encode(List bytes) => base64.encode(bytes);
    List<String> items = [
      'NPWRD            :$_npwrd',
      'Wajib Retribusi  :$_namaWajibRetribusi',
      'Jenis Retribusi  :$_jenisRetribusi',
      'Jenis produk     :$_jenisProduk',
      'Kolektor         :$_name',
      'Periode Penagihan:$_periodePenagihan',
      'Lokasi Retribusi :$_lokasiRetribusi',
      'Tempat Retribusi :$_tempatRetribusi',
      'Tanggal Penagihan:$_tanggalPenagihan',
      'Periode Bayar    :$_periodeBayar',
      'Nilai Retribusi  :${NumberFormat.simpleCurrency(locale: 'id', decimalDigits: 0).format(int.parse(_nominalPajak)).toString()}',
    ];
    Map data = {
      'title': 'BUKTI PEMBAYARAN',
      'logo': base64Image,
      'items': items,
      // 'footer': 'TERIMA KASIH\nSELAMAT JALAN',
    };
    print(data);
    String payload = json.encode(data);
    try {
      final int result = await platformMethodChannel.invokeMethod(payload);
      if (result != 0) {
        showPop('GAGAL', 'Gagal print bill');
      }
    } on PlatformException catch (e) {
      showPop('GAGAL', 'Gagal print bill');
    }
  }

  Future<bool> showPop(String title, String message) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
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

  @override
  void initState() {
    getWidgetData();
    setState(() {
      _initPrinter();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xFF2E93E1),
        centerTitle: true,
        title: Text(
          'Bukti Bayar',
          style: TextStyle(
              fontFamily: 'poppins regluar',
              fontSize: 14.0,
              fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: size.width,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Bukti Bayar Transaksi',
                      style: TextStyle(
                          color: Color(0xFF3B414B),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'opensans regular'),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Card(
                      margin: EdgeInsets.only(
                        left: 25,
                        right: 25,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      elevation: 2,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 20, bottom: 23, top: 10, right: 17),
                        width: size.width,
                        child: Column(
                          children: [
                            Icon(
                              Icons.qr_code_2,
                              size: 78,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 135,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'NPWRD',
                                        style: TextStyle(
                                            color: Color(0xFF757F8C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'opensans regular'),
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
                                      fontFamily: 'opensans regular'),
                                ),
                              ],
                            ),
                            SizedBox(height: 11),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 135,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Wajib Retribusi',
                                        style: TextStyle(
                                            color: Color(0xFF757F8C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'opensans regular'),
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
                                      fontFamily: 'opensans regular'),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 135,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Jenis Retribusi',
                                        style: TextStyle(
                                            color: Color(0xFF757F8C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'opensans regular'),
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
                                      fontFamily: 'opensans regular'),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 135,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Jenis Produk',
                                        style: TextStyle(
                                            color: Color(0xFF757F8C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'opensans regular'),
                                      ),
                                      Text(':'),
                                    ],
                                  ),
                                ),
                                Text(
                                  _jenisProduk.toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'opensans regular'),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 135,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Kolektor',
                                        style: TextStyle(
                                            color: Color(0xFF757F8C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'opensans regular'),
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
                                      fontFamily: 'opensans regular'),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 135,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Periode Penagihan',
                                        style: TextStyle(
                                            color: Color(0xFF757F8C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'opensans regular'),
                                      ),
                                      Text(':'),
                                    ],
                                  ),
                                ),
                                Text(
                                  _periodePenagihan.toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'opensans regular'),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 135,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Lokasi Retribusi',
                                        style: TextStyle(
                                            color: Color(0xFF757F8C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'opensans regular'),
                                      ),
                                      Text(':'),
                                    ],
                                  ),
                                ),
                                Text(
                                  _lokasiRetribusi.toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'opensans regular'),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 135,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Tempat Retribusi',
                                        style: TextStyle(
                                            color: Color(0xFF757F8C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'opensans regular'),
                                      ),
                                      Text(':'),
                                    ],
                                  ),
                                ),
                                Text(
                                  _tempatRetribusi.toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'opensans regular'),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 135,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Tanggal Penagihan',
                                        style: TextStyle(
                                            color: Color(0xFF757F8C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'opensans regular'),
                                      ),
                                      Text(':'),
                                    ],
                                  ),
                                ),
                                Text(
                                  _tanggalPenagihan.toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'opensans regular'),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 135,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Periode Bayar',
                                        style: TextStyle(
                                            color: Color(0xFF757F8C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'opensans regular'),
                                      ),
                                      Text(':'),
                                    ],
                                  ),
                                ),
                                Text(
                                  _periodeBayar.toString(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'opensans regular'),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 11,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 135,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Nilai Retribusi',
                                        style: TextStyle(
                                            color: Color(0xFF757F8C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'opensans regular'),
                                      ),
                                      Text(':'),
                                    ],
                                  ),
                                ),
                                Text(
                                  NumberFormat.simpleCurrency(
                                          locale: 'id', decimalDigits: 0)
                                      .format(int.parse(_nominalPajak))
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'opensans regular'),
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
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Container(
                      padding: EdgeInsets.only(left: 24, right: 24),
                      width: size.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _valueValidation == 0
                              ? MaterialButton(
                                  color: Color(0xFFE0E0E0),
                                  minWidth: 147,
                                  height: 44,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(37.0),
                                    side: BorderSide(
                                      color: Color(
                                        0xFFE0E0E0,
                                      ),
                                      width: 1.0,
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    'Beranda',
                                    style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontFamily: 'poppins regular',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14),
                                  ),
                                )
                              : MaterialButton(
                                  color: Color(0xFFF2994A),
                                  minWidth: 147,
                                  height: 44,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(37.0),
                                    side: BorderSide(
                                      color: Color(
                                        0xFFF2994A,
                                      ),
                                      width: 1.0,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DashboardScreen()),
                                      (route) => false,
                                    );
                                  },
                                  child: Text(
                                    'Beranda',
                                    style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontFamily: 'poppins regular',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14),
                                  ),
                                ),
                          MaterialButton(
                            minWidth: 147,
                            height: 44,
                            color: Color(0xFF01A190),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(37.0),
                              side: BorderSide(
                                color: Color(
                                  0xFF01A190,
                                ),
                                width: 1.0,
                              ),
                            ),
                            onPressed: () {
                              var duration = const Duration(seconds: 1);
                              _printData();
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    Timer(duration, () {
                                      setState(() {
                                        _valueValidation = 1;
                                      });
                                      Navigator.pop(context);
                                    });
                                    return AlertDialog(
                                      actions: [
                                        Container(
                                          width: size.width,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 92,
                                                height: 92,
                                                alignment: Alignment.center,
                                                // padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Color(0xFF27AE60),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    border: Border.all(
                                                        width: 2,
                                                        color: Colors.white)),
                                                child: FaIcon(
                                                  FontAwesomeIcons.check,
                                                  size: 50,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(height: 12),
                                              Text(
                                                'Cetak Resi Berhasil',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w800,
                                                    color: Color(0xFF252B42),
                                                    fontFamily:
                                                        'opensans regular'),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              SizedBox(
                                                height: 11,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  });

                              // Navigator.pushAndRemoveUntil(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => DashboardScreen()),
                              //       (route) => false,
                              // );
                            },
                            child: Text(
                              'Cetak Resi',
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontFamily: 'poppins regular',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 28),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _dash(BuildContext context) {
  final Size size = MediaQuery.of(context).size;
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
