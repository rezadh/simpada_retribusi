import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpada/data/api/api_service.dart';
import 'package:simpada/data/model/simpada_retribusi.dart';
import 'package:simpada/screen/riwayat/bukti_bayar_riwayat_screen.dart';

class BillingPage extends StatefulWidget {
  const BillingPage({Key key}) : super(key: key);

  @override
  _BillingPageState createState() => _BillingPageState();
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


class _BillingPageState extends State<BillingPage> {
  var _name;
  var _username;
  var _tglBayar;
  var _kodeBilling;
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
              child: FutureBuilder<HistoryBill>(
                future: postRequestHistoryBill(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    HistoryBill data = snapshot.data;
                    return Container(
                      padding: EdgeInsets.only(top: 19, bottom: 19),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BuktiBayarRiwayatScreen(
                                    kodeBilling: _kodeBilling,
                                    name: _name,
                                    nominalPajak: data.nominal,
                                    status: data.status,
                                    kadaluarsa: _getDateTime(data.tglKedaluwarsa),
                                    tanggalBayar: _getDateTime(_tglBayar),
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
                                                'Tanggal Kedaluwarsa',
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
                                              data.tglKedaluwarsa,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'opensans regular',
                                                fontWeight: FontWeight.w600,
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
                                          NumberFormat.simpleCurrency(locale: 'id', decimalDigits: 0)
                                                  .format(double.parse(data.nominal)),
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'opensans regular',
                                            fontWeight: FontWeight.w600,
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
                                                'Status',
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
                                          data.status == '0' ? 'Menunggu Pembayaran' : data.status == '1' ? 'Lunas' : 'Expired',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'opensans regular',
                                            fontWeight: FontWeight.w600,
                                            color: data.status == '0' ? Color(0xFFF2994A) : data.status == '1' ? Color(0xFF27AE60) : Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
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
            ),
          ),
        ),
      ),
    );

  }
}
