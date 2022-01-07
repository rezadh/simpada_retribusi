import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpada/data/model/history_bill_model.dart';
import 'package:simpada/screen/generate/detail_penyetoran_screen.dart';
import 'dart:convert';

class DaftarBillingPage extends StatefulWidget {
  const DaftarBillingPage({Key key}) : super(key: key);

  @override
  _DaftarBillingPageState createState() => _DaftarBillingPageState();
}

Widget _dash(BuildContext context) {
  final Size size = MediaQuery
      .of(context)
      .size;
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

class _DaftarBillingPageState extends State<DaftarBillingPage> {
  var _name;
  List daftarNTRD = [];
  List daftarTanggal = [];
  List daftarNilai = [];
  bool loading = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString('name');
    return _name;
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

  Future<bool> showPopGagal(String title, String message) =>
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text(
                title,
                style: TextStyle(fontSize: 18),
              ),
              content: Text(
                message,
                style: TextStyle(fontSize: 14),
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


  static const platformMethodChannel = const MethodChannel('com.pac.print/edc');

  Future<bool> _initPrinter() async {
    try {
      final bool result = await platformMethodChannel.invokeMethod('connect');
      return result;
    } on PlatformException {
      return false;
    }
  }

  Future _printData(String kodeBilling, String tglKedaluarsa, String periode,
      String nominal) async {
    await _initPrinter().then((value) {
      if (!value) {
        return;
      }
    });
    var formatTanggal = DateFormat('dd-MM-yyyy');
    var tglDibentuk = formatTanggal.parse(periode);
    var bulan = DateFormat('MM').format(tglDibentuk);
    var tahun = DateFormat('yyyy').format(tglDibentuk);
    List<String> items = [
      '\n-------------------------------\n',
    ];
    Map data = {
      'header': 'Kode Billing\n',
      'kode': kodeBilling,
      'info': 'Tanggal Kedaluarsa',
      'tanggal': tglKedaluarsa,
      'items': items,
      'info2': 'Total Setor Retribusi',
      'periode': 'Periode ${getMonth(bulan)} $tahun',
      'nominal': nominal
    };
    String payload = json.encode(data);
    try {
      final int result = await platformMethodChannel.invokeMethod(payload);
      if (result != 0) {
        showPopGagal('GAGAL', 'Gagal print struk');
      }
    } on PlatformException {
      showPopGagal('GAGAL', 'Gagal print struk');
    }
  }

  @override
  void initState() {
    setState(() {
      getUser();
      postRequestSetoranBill();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: postRequestSetoranBill,
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: Container(
              child: FutureBuilder<List<HistoryBill>>(
                future: postRequestSetoranBill(),
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
                                    for (int i = 0;
                                    i < data[index].listBilingNTRD.length;
                                    i++) {
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
                                    Navigator.of(context, rootNavigator: true)
                                        .push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailPenyetoranScreen(
                                              ntrd: daftarNTRD,
                                              nilai: daftarNilai,
                                              tanggal: daftarTanggal,
                                            ),
                                      ),
                                    );
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         DetailPenyetoranScreen(
                                    //       ntrd: daftarNTRD,
                                    //       nilai: daftarNilai,
                                    //       tanggal: daftarTanggal,
                                    //     ),
                                    //   ),
                                    // );

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
                                              GestureDetector(
                                                  onTap: () {
                                                    _printData(data[index]
                                                        .kodeBilling, data[index].tglKedaluwarsa, data[index].tglDibentuk, NumberFormat.simpleCurrency(
                                                    locale: 'id',
                                                        decimalDigits: 0)
                                                        .format(double.parse(
                                                        data[index].nominal)));
                                                  },
                                                  child: Image.asset(
                                                      'images/cetak.png')),
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
                                                      'Tanggal Kedaluwarsa',
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
                                                    data[index].tglKedaluwarsa,
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
                                            width: MediaQuery
                                                .of(context)
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
                      height: MediaQuery
                          .of(context)
                          .size
                          .height - 165,
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
