import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpada/data/api/api_service.dart';
import 'package:simpada/data/model/daftar_produk_model.dart';
import 'package:simpada/data/model/profile_model.dart';
import 'package:simpada/data/model/simpada_retribusi.dart';
import 'package:simpada/screen/dashboard/dashboard_screen.dart';

class BuktiBayarRiwayatScreen extends StatefulWidget {
  final ntrd;
  final npwrd;
  final jenisRetribusi;
  final jenisProduk;
  final namaWajibRetribusi;
  final nominalPajak;
  final periodePenagihan;
  final lokasiRetribusi;
  final tempatRetribusi;
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
      {this.ntrd,
      this.npwrd,
      this.jenisRetribusi,
      this.jenisProduk,
      this.namaWajibRetribusi,
      this.nominalPajak,
      this.periodePenagihan,
      this.lokasiRetribusi,
      this.tempatRetribusi,
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
  String _ntrd;
  String _npwrd;
  String _jenisRetribusi;
  String _nominalPajak;
  String _name;
  String _periodeBayar;
  var _tanggalPenagihan;
  String _status;
  List<dynamic> _listNpwrd = [];

  void getWidgetData() {
    _jenisRetribusi = 'Pasar';
    _ntrd = widget.ntrd;
    _npwrd = widget.npwrd;
    _listNpwrd.clear();
    _listNpwrd.add(widget.npwrd);
    _nominalPajak = widget.nominalPajak;
    _name = widget.name;
    _tanggalPenagihan = widget.tanggalPenagihan;
    _periodeBayar = widget.periodeBayar;
    _status = widget.status;
    print(_listNpwrd);
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

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var nama = prefs.getString('name');
    return nama;
  }

  @override
  void initState() {
    getUser().then((id) {
      setState(() {
        _name = id;
        getWidgetData();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios),
        //   iconSize: 20.0,
        //   onPressed: () {
        //     _goBack(context);
        //   },
        // ),
      //   centerTitle: true,
      //   title: Text(
      //     'Riwayat',
      //     style: TextStyle(
      //       fontFamily: 'poppins regluar',
      //       fontSize: 14.0,
      //     ),
      //     textAlign: TextAlign.center,
      //   ),
      // ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFFFFFFF),
      body: Container(
        height: size.height,
        child: SingleChildScrollView(
          child: FutureBuilder<List<Profile>>(
            future: postRequestProfile(_listNpwrd),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Profile> data = snapshot.data;
                print('ini nama wr ${data[0].namaWr}');
                return Column(
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
                                              'NTRD',
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
                                        _ntrd.toString(),
                                        style: TextStyle(
                                            fontSize: 13,
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
                                        data[0].namaWr,
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
                                  FutureBuilder<List<DaftarProdukAtas>>(
                                    future: postRequestProduk(_npwrd),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        List<DaftarProdukAtas> dataRetribusi =
                                            snapshot.data;
                                        return Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                            color: Color(
                                                                0xFF757F8C),
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
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                            color: Color(
                                                                0xFF757F8C),
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
                                                  dataRetribusi[0]
                                                      .lokasi
                                                      .daftarTempat[0]
                                                      .daftarProdukBawah[0]
                                                      .type,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 135,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Kolektor',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF757F8C),
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
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                            color: Color(
                                                                0xFF757F8C),
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
                                                  dataRetribusi[0]
                                                      .lokasi
                                                      .daftarTempat[0]
                                                      .daftarProdukBawah[0]
                                                      .satuanPeriode,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                            color: Color(
                                                                0xFF757F8C),
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
                                                  dataRetribusi[0].lokasi.nama,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                            color: Color(
                                                                0xFF757F8C),
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
                                                  dataRetribusi[0].lokasi.daftarTempat[0].nama,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 135,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Tanggal Penagihan',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF757F8C),
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
                                                  _tanggalPenagihan.toString(),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 135,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Periode Bayar',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF757F8C),
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
                                                  _periodeBayar.toString(),
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                            color: Color(
                                                                0xFF757F8C),
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
                                                  NumberFormat.simpleCurrency(
                                                          locale: 'id',
                                                          decimalDigits: 0)
                                                      .format(double.parse(
                                                          _nominalPajak))
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 135,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Status',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF757F8C),
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
                                                  _status == '1'
                                                      ? 'Belum Generate Billing'
                                                      : 'Sudah Generate Billing',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily:
                                                        'opensans regular',
                                                    fontWeight: FontWeight.w600,
                                                    color: _status == '1'
                                                        ? Color(0xFFF2994A)
                                                        : Color(0xFF27AE60),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Text('');
                                      }
                                    },
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
                          SizedBox(height: 22),
                          Container(
                            margin: EdgeInsets.only(left: 25, right: 25),
                            child: MaterialButton(
                              color: Color(0xFF009A8A),
                              minWidth: size.width,
                              height: 45,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(37.0),
                              ),
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(
                                      builder: (context) => DashboardScreen()),
                                );
                                // Navigator.pushReplacement(
                                //             context,
                                //             MaterialPageRoute(
                                //               builder: (context) => DashboardScreen(),
                                //             ),
                                //           );
                                // Navigator.pushAndRemoveUntil(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => DashboardScreen()),
                                //       (route) => false,
                                // );
                              },
                              child: Text(
                                'Kembali ke Beranda',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'poppins regular',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 28),
                        ],
                      ),
                    )
                  ],
                );
              } else {
                return Text('');
              }
            },
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
