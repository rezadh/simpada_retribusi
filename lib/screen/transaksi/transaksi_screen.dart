import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:simpada/screen/transaksi/bukti_bayar_screen.dart';

class TransaksiScreen extends StatefulWidget {
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

  TransaksiScreen(
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
      this.dibayarkan, this.periodeBayar});

  @override
  _TransaksiScreenState createState() => _TransaksiScreenState();
}

class _TransaksiScreenState extends State<TransaksiScreen> {
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

  }

  @override
  void initState() {
    getWidgetData();
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
          'Transaksi',
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
                    SizedBox(
                      height: 10,
                    ),
                    // Icon(Icons.check_circle, size: 61,),
                    Container(
                      width: 61,
                      height: 61,
                      alignment: Alignment.center,
                      // padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(0xFF27AE60),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 2, color: Colors.white)),
                      child: FaIcon(
                        FontAwesomeIcons.check,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 11),
                    Text(
                      'Pembayaran Berhasil',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'opensans regular'),
                    ),
                    SizedBox(
                      height: 16,
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
                            left: 20, bottom: 23, top: 14, right: 17),
                        width: size.width,
                        child: Column(
                          children: [
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
                                        'Penanggung Jawab',
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
                                    NumberFormat
                                        .simpleCurrency(
                                        locale: 'id',
                                        decimalDigits: 0)
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
                  ],
                ),
              ),
              SizedBox(height: 26),
              Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                child: MaterialButton(
                  color: Color(0xFF01A190),
                  minWidth: 315,
                  height: 44,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BuktiBayarScreen(
                          npwrd: _npwrd,
                          tanggalPenagihan: _tanggalPenagihan,
                          nominalPajak: _nominalPajak,
                          jenisProduk: _jenisProduk,
                          jenisRetribusi: _jenisRetribusi,
                          lokasiRetribusi: _lokasiRetribusi,
                          namaWajibRetribusi:
                          _namaWajibRetribusi,
                          name: _name,
                          periodePenagihan: _periodePenagihan,
                          totalNilai: _totalNilai,
                          dibayarkan: _dibayarkan,
                          periodeBayar: _periodeBayar,
                        ),
                      ),
                    );
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
              ),
              SizedBox(height: 29,),
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
