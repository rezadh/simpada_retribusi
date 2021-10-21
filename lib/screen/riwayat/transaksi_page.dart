import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpada/data/api/api_service.dart';
import 'package:simpada/data/model/simpada_retribusi.dart';
import 'package:simpada/screen/riwayat/bukti_bayar_riwayat_screen.dart';

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({Key key}) : super(key: key);

  @override
  _TransaksiPageState createState() => _TransaksiPageState();
}

Widget _dash(BuildContext context) {
  final Size size = MediaQuery.of(context).size;
  final dashWidth = 10.0;
  final dashCount = (size.width / (2 * dashWidth)).floor();
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
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

class _TransaksiPageState extends State<TransaksiPage> {
  var _name;
  var _waktu;
  var _npwrd;
  var tglPungut;
  int idProduk;
  int idTempat;
  int tarif;
  String namaLokasi;
  String tempatRetribusi;
  String _jenisRetribusi;
  String _namaWajibRetribusi;
  String _jenisProduk;
  String _namaLokasi;
  var _dateNow;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();


  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString('name');
    _npwrd = prefs.getString('npwrd');
    _namaWajibRetribusi = prefs.getString('nama_wr');
    _jenisRetribusi = prefs.getString('jenis_retribusi');
    _jenisProduk = prefs.getString('jenis_produk');
    _namaLokasi = prefs.getString('nama_lokasi');
    return _name;
  }
  _getDate(String _date) {
    DateTime dateFormat = DateFormat('dd-MM-yyyy').parse(_date);
    var date = DateFormat('dd').format(dateFormat);
    var month = DateFormat('MM').format(dateFormat);
    var year = DateFormat('yyyy').format(dateFormat);
    String parseMonth;
    if (month == '01') {
      parseMonth = 'Januari';
    } else if (month == '02') {
      parseMonth = 'Februari';
    } else if (month == '03') {
      parseMonth = 'Maret';
    } else if (month == '04') {
      parseMonth = 'April';
    } else if (month == '05') {
      parseMonth = 'Mei';
    } else if (month == '06') {
      parseMonth = 'Juni';
    } else if (month == '07') {
      parseMonth = 'Juli';
    } else if (month == '08') {
      parseMonth = 'Agustus';
    } else if (month == '09') {
      parseMonth = 'September';
    } else if (month == '10') {
      parseMonth = 'Oktober';
    } else if (month == '11') {
      parseMonth = 'November';
    } else if (month == '12') {
      parseMonth = 'Desember';
    }
    _dateNow = '$date $parseMonth $year';
    return _dateNow;
  }
  _getDatePeriode(String _date) {
    print(_date);
    var date = _date.substring(0,2);
    var month = _date.substring(2,4);
    var year = _date.substring(4,8);
    print(date);
    print(month);
    print(year);
    String parseMonth;
    if (month == '01') {
      parseMonth = 'Januari';
    } else if (month == '02') {
      parseMonth = 'Februari';
    } else if (month == '03') {
      parseMonth = 'Maret';
    } else if (month == '04') {
      parseMonth = 'April';
    } else if (month == '05') {
      parseMonth = 'Mei';
    } else if (month == '06') {
      parseMonth = 'Juni';
    } else if (month == '07') {
      parseMonth = 'Juli';
    } else if (month == '08') {
      parseMonth = 'Agustus';
    } else if (month == '09') {
      parseMonth = 'September';
    } else if (month == '10') {
      parseMonth = 'Oktober';
    } else if (month == '11') {
      parseMonth = 'November';
    } else if (month == '12') {
      parseMonth = 'Desember';
    }
    _dateNow = '$date $parseMonth $year';
    return _dateNow;
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
  _getDateTime(String date) {
    DateTime dateFormat = DateFormat('dd-MM-yyyy HH:mm').parse(date);
    var day = DateFormat('dd').format(dateFormat);
    var month = DateFormat('MM').format(dateFormat);
    var year = DateFormat('yyyy').format(dateFormat);
    var parseMonth = getMonth(month);
    _waktu = DateFormat('HH:mm').format(dateFormat);
    String dateTime = '$day $parseMonth $year';
    return dateTime;
  }
  @override
  void initState() {
    setState(() {
      getUser();
      postRequestLastPayment();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: postRequestLastPayment,
      child: Scaffold(
        backgroundColor: Color(0xFFF2F2F2),
        body: Container(
          padding: EdgeInsets.only(top: 19, bottom: 19),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              children: [
                FutureBuilder<List<LastPayment>>(
                  future: postRequestLastPayment(),
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      List<LastPayment> data = snapshot.data;
                      return ListView.builder(
                        itemCount: data.length,
                        physics:
                        NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index){
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: (){

                                  Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BuktiBayarRiwayatScreen(
                                            npwrd: _npwrd,
                                            tanggalPenagihan: _getDate(data[index].tanggalPenagihan),
                                            nominalPajak: data[index].nominal,
                                            jenisProduk: _jenisProduk,
                                            jenisRetribusi: _jenisRetribusi,
                                            lokasiRetribusi: _namaLokasi,
                                            namaWajibRetribusi: _namaWajibRetribusi,
                                            name: _name,
                                            periodePenagihan: data[index].satuanPeriode,
                                            periodeBayar: _getDatePeriode(data[index].periode.toString()),
                                          ),
                                        ),
                                      );
                                },
                                child: Card(
                                  margin: EdgeInsets.only(left: 25, right: 25),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 2,
                                  child: Container(
                                    padding: EdgeInsets.all(14),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 132,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'Jenis Retribusi',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'opensans regular',
                                                      fontWeight: FontWeight.w400,
                                                      color: Color(0xFF4F4F4F),
                                                    ),
                                                  ),
                                                  Text(
                                                    ':',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              'Parkir',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'opensans regular',
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF4F4F4F),
                                              ),
                                            ),
                                          ],
                                        ),
                                        _dash(context),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 132,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'Penanggung Jawab',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'opensans regular',
                                                      fontWeight: FontWeight.w400,
                                                      color: Color(0xFF4F4F4F),
                                                    ),
                                                  ),
                                                  Text(
                                                    ':',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              _name.toString(),
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'opensans regular',
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF4F4F4F),
                                              ),
                                            ),
                                          ],
                                        ),
                                        _dash(context),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 132,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'Lokasi Retribusi',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'opensans regular',
                                                      fontWeight: FontWeight.w400,
                                                      color: Color(0xFF4F4F4F),
                                                    ),
                                                  ),
                                                  Text(
                                                    ':',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              'Gedung Mk P3',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'opensans regular',
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF4F4F4F),
                                              ),
                                            ),
                                          ],
                                        ),
                                        _dash(context),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 132,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'Waktu Pembayaran',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'opensans regular',
                                                      fontWeight: FontWeight.w400,
                                                      color: Color(0xFF4F4F4F),
                                                    ),
                                                  ),
                                                  Text(
                                                    ':',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  _getDateTime(data[index].tanggalPenagihan),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'opensans regular',
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFF4F4F4F),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(left: 3.0),
                                                  padding: EdgeInsets.all(1.0),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFFFE38C),
                                                    borderRadius: BorderRadius.circular(9.0),
                                                    // border: Border.all(width: 2, color: Colors.white),
                                                  ),
                                                  child: Text(
                                                    _waktu.toString(),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'opensans regular',
                                                      fontWeight: FontWeight.w600,
                                                      color: Color(0xFF4F4F4F),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        _dash(context),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 132,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'Total Nilai Retribusi',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'opensans regular',
                                                      fontWeight: FontWeight.w400,
                                                      color: Color(0xFF4F4F4F),
                                                    ),
                                                  ),
                                                  Text(
                                                    ':',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                                NumberFormat
                                                    .simpleCurrency(
                                                    locale: 'id',
                                                    decimalDigits: 0)
                                                    .format(int.parse(data[index].nominal))
                                                    .toString(),
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'opensans regular',
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF27AE60),
                                              ),
                                            ),
                                          ],
                                        ),
                                        _dash(context),
                                        // Row(
                                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //   children: [
                                        //     Container(
                                        //       width: 132,
                                        //       child: Row(
                                        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //         children: [
                                        //           Text(
                                        //             'Status',
                                        //             style: TextStyle(
                                        //               fontSize: 12,
                                        //               fontFamily: 'opensans regular',
                                        //               fontWeight: FontWeight.w400,
                                        //               color: Color(0xFF4F4F4F),
                                        //             ),
                                        //           ),
                                        //           Text(
                                        //             ':',
                                        //             style: TextStyle(
                                        //               fontSize: 12,
                                        //             ),
                                        //           ),
                                        //         ],
                                        //       ),
                                        //     ),
                                        //     Text(
                                        //       'Lunas',
                                        //       style: TextStyle(
                                        //         fontSize: 12,
                                        //         fontFamily: 'opensans regular',
                                        //         fontWeight: FontWeight.w600,
                                        //         color: Color(0xFF27AE60),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          );
                        },
                      );
                    }
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          )),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
