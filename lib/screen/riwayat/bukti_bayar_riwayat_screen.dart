import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpada/data/model/simpada_retribusi.dart';
import 'package:simpada/screen/dashboard/dashboard_screen.dart';

import '../../constants.dart';

class BuktiBayarRiwayatScreen extends StatefulWidget {
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
  final kodeBilling;
  final kadaluarsa;
  final tanggalBayar;
  final namaRetribusi;
  final status;

  BuktiBayarRiwayatScreen(
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
      this.periodeBayar,
      this.kodeBilling,
      this.namaRetribusi,
      this.status,
      this.kadaluarsa,
      this.tanggalBayar});

  @override
  _BuktiBayarRiwayatScreenState createState() =>
      _BuktiBayarRiwayatScreenState();
}

class _BuktiBayarRiwayatScreenState extends State<BuktiBayarRiwayatScreen> {
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
  var _tanggalPenagihan;
  int _valueValidation = 0;
  String _kodeBiling;
  String _kadaluarsa;
  String _tanggalBayar;
  String _status;
  String _namaRetribusi;

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
    _kodeBiling = widget.kodeBilling;
    _kadaluarsa = widget.kadaluarsa;
    _tanggalBayar = widget.tanggalBayar;
    _status = widget.status;
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return _npwrd != null
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Color(0xFFFFFFFF),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                            fontFamily: 'opensans regular'),
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Wajib Retribusi',
                                              style: TextStyle(
                                                  color: Color(0xFF757F8C),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
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
                                            fontFamily: 'opensans regular'),
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Jenis Retribusi',
                                              style: TextStyle(
                                                  color: Color(0xFF757F8C),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
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
                                            fontFamily: 'opensans regular'),
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Jenis Produk',
                                              style: TextStyle(
                                                  color: Color(0xFF757F8C),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                      'opensans regular'),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 135,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Penanggung Jawab',
                                              style: TextStyle(
                                                  color: Color(0xFF757F8C),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
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
                                            fontFamily: 'opensans regular'),
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Periode Penagihan',
                                              style: TextStyle(
                                                  color: Color(0xFF757F8C),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                      'opensans regular'),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                                  fontFamily:
                                                      'opensans regular'),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                                  fontFamily:
                                                      'opensans regular'),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                                  fontFamily:
                                                      'opensans regular'),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                                  fontFamily:
                                                      'opensans regular'),
                                            ),
                                            Text(':'),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        NumberFormat.simpleCurrency(
                                                locale: 'id', decimalDigits: 0)
                                            .format(double.parse(_nominalPajak))
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
                          SizedBox(height: 28),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        :
        //Billing
        Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Color(0xFFFFFFFF),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 135,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Kode Billing',
                                              style: TextStyle(
                                                  color: Color(0xFF757F8C),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                      'opensans regular'),
                                            ),
                                            Text(':'),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        _kodeBiling.toString(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'opensans regular'),
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Penanggung Jawab',
                                              style: TextStyle(
                                                  color: Color(0xFF757F8C),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
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
                                            fontFamily: 'opensans regular'),
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Tanggal Bayar',
                                              style: TextStyle(
                                                  color: Color(0xFF757F8C),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                      'opensans regular'),
                                            ),
                                            Text(':'),
                                          ],
                                        ),
                                      ),
                                      Text(
                                       _tanggalBayar.toString(),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 135,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Tanggal Kadaluarsa',
                                              style: TextStyle(
                                                  color: Color(0xFF757F8C),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                      'opensans regular'),
                                            ),
                                            Text(':'),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        _kadaluarsa.toString(),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 135,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Nama Retribusi',
                                              style: TextStyle(
                                                  color: Color(0xFF757F8C),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                      'opensans regular'),
                                            ),
                                            Text(':'),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        '-',
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 135,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Tagihan',
                                              style: TextStyle(
                                                  color: Color(0xFF757F8C),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                      'opensans regular'),
                                            ),
                                            Text(':'),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        NumberFormat.simpleCurrency(
                                                locale: 'id', decimalDigits: 0)
                                            .format(double.parse(_nominalPajak))
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'opensans regular'),
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
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Status',
                                              style: TextStyle(
                                                  color: Color(0xFF757F8C),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                  'opensans regular'),
                                            ),
                                            Text(':'),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        _status == '0' ? 'Menunggu Pembayaran' : _status == '1' ? 'Lunas' : 'Expired',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'opensans regular',
                                          fontWeight: FontWeight.w600,
                                          color: _status == '0' ? Color(0xFFF2994A) :_status == '1' ? Color(0xFF27AE60) : Colors.red,
                                        ),
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
