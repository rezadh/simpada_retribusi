import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpada/data/model/history_bill_model.dart';
import 'detail_penyetoran_screen.dart';

class RiwayatPenyetoranPage extends StatefulWidget {
  const RiwayatPenyetoranPage({Key key}) : super(key: key);

  @override
  _RiwayatPenyetoranPageState createState() => _RiwayatPenyetoranPageState();
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

class _RiwayatPenyetoranPageState extends State<RiwayatPenyetoranPage> {
  var _name;
  var _username;
  var _tglBayar;
  var _kodeBilling;
  List daftarNTRD = [];
  List daftarTanggal = [];
  List daftarNilai = [];
  bool loading = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString('name');
    _username = prefs.getString('noHp');
    _tglBayar = prefs.getString('tanggal_bayar');
    _kodeBilling = prefs.getString('billcode');
    return _name;
  }

  _getDateTime(String date) {
    DateTime dateFormat = DateFormat('dd-MM-yyyy').parse(date);
    var day = DateFormat('dd').format(dateFormat);
    var month = DateFormat('MM').format(dateFormat);
    var year = DateFormat('yyyy').format(dateFormat);
    var parseMonth = getMonth(month);
    String dateTime = '$day $parseMonth $year';
    return dateTime;
  }

  String getMonth(String month) {
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
      getUser();
      postRequestHistoryBill();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: postRequestHistoryBill,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: Container(
              child: FutureBuilder<List<HistoryBill>>(
                future: postRequestHistoryBill(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<HistoryBill> data = snapshot.data;
                    return ListView.builder(
                        itemCount: data.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.only(top: 15),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    daftarNTRD.clear();
                                    daftarTanggal.clear();
                                    daftarNilai.clear();
                                    for(int i = 0; i < data[index].listBilingNTRD.length; i++){
                                      daftarNTRD.add(
                                          data[index].listBilingNTRD[i].ntrd);
                                      print(data[index].listBilingNTRD[i].ntrd);
                                      daftarTanggal.add(data[index]
                                          .listBilingNTRD[i]
                                          .tglCollect);
                                      daftarNilai.add(data[index]
                                          .listBilingNTRD[i]
                                          .nominalTagihan);
                                    }
                                    Navigator.of(context, rootNavigator: true).push(
                                      MaterialPageRoute(
                                        builder: (context) => DetailPenyetoranScreen(
                                          ntrd: daftarNTRD,
                                          nilai: daftarNilai,
                                          tanggal: daftarTanggal,
                                        ),),
                                    );
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         BuktiBayarRiwayatScreen(
                                    //       kodeBilling: data[index].kodeBilling,
                                    //       name: _name,
                                    //       nominalPajak: data[index].nominal,
                                    //       status: data[index].status,
                                    //       kadaluarsa: _getDateTime(
                                    //           data[index].tglKedaluwarsa),
                                    //       tanggalBayar: _getDateTime(
                                    //           data[index].tglDibentuk),
                                    //       namaRetribusi: data[index].namaWp,
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                  child: Card(
                                    margin:
                                        EdgeInsets.only(left: 25, right: 25),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    elevation: 2,
                                    child: Container(
                                      padding: EdgeInsets.all(14),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 132,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Kode Billing',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'opensans regular',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xFF4F4F4F),
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
                                                data[index].kodeBilling,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily:
                                                      'opensans regular',
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF4F4F4F),
                                                ),
                                              ),
                                            ],
                                          ),
                                          _dash(context),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 132,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Tanggal Penyetoran',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'opensans regular',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xFF4F4F4F),
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
                                                    data[index].tglBayar,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily:
                                                          'opensans regular',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xFF4F4F4F),
                                                    ),
                                                  ),
                                                  // Container(
                                                  //   margin: EdgeInsets.only(left: 3.0),
                                                  //   padding: EdgeInsets.all(1.0),
                                                  //   decoration: BoxDecoration(
                                                  //     color: Color(0xFFFFE38C),
                                                  //     borderRadius: BorderRadius.circular(9.0),
                                                  //     // border: Border.all(width: 2, color: Colors.white),
                                                  //   ),
                                                  //   child: Text(
                                                  //     '11:00',
                                                  //     style: TextStyle(
                                                  //       fontSize: 12,
                                                  //       fontFamily: 'opensans regular',
                                                  //       fontWeight: FontWeight.w600,
                                                  //       color: Color(0xFF4F4F4F),
                                                  //     ),
                                                  //   ),
                                                  // )
                                                ],
                                              ),
                                            ],
                                          ),
                                          _dash(context),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 132,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Total Nilai Retribusi',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'opensans regular',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xFF4F4F4F),
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
                                                NumberFormat.simpleCurrency(
                                                        locale: 'id',
                                                        decimalDigits: 0)
                                                    .format(double.parse(
                                                        data[index].nominal)),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily:
                                                      'opensans regular',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          _dash(context),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 132,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Status',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'opensans regular',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xFF4F4F4F),
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
                                                data[index].status == '0'
                                                    ? 'Menunggu Penyetoran'
                                                    : data[index].status == '1'
                                                        ? 'Selesai'
                                                        : 'Expired',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily:
                                                      'opensans regular',
                                                  fontWeight: FontWeight.w600,
                                                  color: data[index].status ==
                                                          '0'
                                                      ? Color(0xFFF2994A)
                                                      : data[index].status ==
                                                              '1'
                                                          ? Color(0xFF27AE60)
                                                          : Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              // border: Border.all(width: 2, color: Colors.white),
                                            ),
                                            padding: EdgeInsets.all(5),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Text(
                                              'Detail',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  } else {
                    return Container(
                      height: MediaQuery.of(context).size.height - 165,
                      child: Center(
                        child: Text('Data tidak ada'),
                      ),
                    );
                  }
                  // return Container(
                  //   height: MediaQuery.of(context).size.height,
                  //   child: Center(
                  //       child: CircularProgressIndicator(
                  //     color: Colors.blue,
                  //   )),
                  // );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
