import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simpada/screen/dashboard/dashboard_screen.dart';

class GenerateCodeScreen extends StatefulWidget {

  GenerateCodeScreen({List<dynamic> ntrd,List<dynamic> nilai, this.billingCode, this.tanggalKadaluarsa}) : this.ntrd = ntrd ?? [], this.nilai = nilai ?? [];
  final List<dynamic> ntrd;
  final List<dynamic> nilai;
  final billingCode;
  final tanggalKadaluarsa;
  @override
  _GenerateCodeScreenState createState() => _GenerateCodeScreenState();
}

class _GenerateCodeScreenState extends State<GenerateCodeScreen> {
  List<dynamic> _ntrd;
  List<dynamic> _nilai;
  String _billingCode;
  var _total;
  String _parseMonth;
  var _yearDateNow;
  var _tanggalKadaluarsa;
  _getWidget(){
    _ntrd = widget.ntrd;
    _nilai = widget.nilai;
    _billingCode = widget.billingCode;
    _tanggalKadaluarsa = widget.tanggalKadaluarsa;
    var sum = 0;
    for (var i = 0; i < _nilai.length; i++) {
      sum += int.parse(_nilai[i]);
    }
    _total = NumberFormat.simpleCurrency(locale: 'id', decimalDigits: 0).format(sum);
    print(_total);
    print(_ntrd);
    print(_nilai.length);
  }
  void _getDate(){
    var dateNow = DateTime.now();
    var monthDateNow = DateFormat('MM').format(dateNow);
    _yearDateNow = DateFormat('yyyy').format(dateNow);
    _parseMonth = getMonth(monthDateNow);
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
      _getWidget();
      _getDate();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2E93E1),
        centerTitle: true,
        title: Text(
          'Generate',
          style: TextStyle(
            fontFamily: 'poppins regluar',
            fontSize: 14.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 25),
              Image.asset(
                'images/bank_sulselbar.png',
                width: 100,
                height: 50,
              ),
              SizedBox(
                height: 37,
              ),
              DottedBorder(
                borderType: BorderType.RRect,
                color: Color(0xFFFFE562),
                strokeWidth: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE562),
                    borderRadius: BorderRadius.circular(9.0),
                  ),
                  width: 263,
                  height: 97,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 13,
                      ),
                      Text(
                        'KODE BILLING',
                        style: TextStyle(
                            fontFamily: 'roboto regular',
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        _billingCode,
                        style: TextStyle(
                            fontFamily: 'roboto regular',
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'TANGGAL KEDALUWARSA',
                        style: TextStyle(
                            color: Color(0xFFDB6A06),
                            fontFamily: 'roboto regular',
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        _tanggalKadaluarsa,
                        style: TextStyle(
                            color: Color(0xFFDB6A06),
                            fontFamily: 'roboto regular',
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                radius: Radius.circular(8.0),
                padding: EdgeInsets.all(6),
              ),
              SizedBox(height: 36,),
              Container(
                width: size.width,
                margin: EdgeInsets.only(left: 40, right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 135,
                      child: ListView.builder(
                        physics:
                        NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _ntrd.length,
                        itemBuilder: (BuildContext context,
                            int index) {
                          return Container(
                            child: Column(
                              children: [
                                Text(
                                  _ntrd[index],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'opensans regular',
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF757F8C),
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      width: 75,
                      child: ListView.builder(
                        physics:
                        NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _nilai.length,
                        itemBuilder: (BuildContext context,
                            int index) {
                          return Container(
                            child: Column(
                              children: [
                                Text(
                                  NumberFormat.simpleCurrency(
                                      locale: 'id',
                                      decimalDigits: 0)
                                      .format(int.parse(_nilai[index])),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'opensans regular',
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF757F8C),
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 7,),
              Text(
                'Total Setor Retribusi $_total',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'opensans regular',
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF757F8C),
                ),
              ),
              Text(
                'Periode $_parseMonth $_yearDateNow',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'opensans regular',
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF757F8C),
                ),
              ),
              SizedBox(height: 43,),
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardScreen(),
                      ),
                    );
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
              SizedBox(height: 33),
            ],
          ),
        ),
      ),
    );
  }
}
