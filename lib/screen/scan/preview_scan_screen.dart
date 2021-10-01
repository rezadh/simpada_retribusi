import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpada/data/api/api_service.dart';
import 'package:simpada/screen/transaksi/transaksi_screen.dart';

class PreviewScanScreen extends StatefulWidget {
  final npwrd;
  final jenisRetribusi;
  final jenisProduk;
  final namaWajibRetribusi;
  final nominalPajak;
  final periodePenagihan;
  final lokasiRetribusi;
  final name;
  final dateNow;

  PreviewScanScreen(
      {this.npwrd,
      this.jenisRetribusi,
      this.jenisProduk,
      this.namaWajibRetribusi,
      this.nominalPajak,
      this.periodePenagihan,
      this.lokasiRetribusi,
      this.name,
      this.dateNow});

  @override
  _PreviewScanScreenState createState() => _PreviewScanScreenState();
}

class _PreviewScanScreenState extends State<PreviewScanScreen> {
  TextEditingController totalBayarController = TextEditingController(text: '1');
  String _npwrd;
  String _jenisRetribusi;
  String _jenisProduk;
  String _namaWajibRetribusi;
  String _nominalPajak;
  String _periodePenagihan;
  String _lokasiRetribusi;
  int _totalNilai;
  String _totalBayar;
  String _name;
  var _dateNow;
  var _parseNominalPajak;
  var _parseTotalNilai;
  final _formKey = GlobalKey<FormState>();
  var _formatPeriode;
  var _periodeBayar;
  var _newDate;
  String _parseMonth;

  void getWidgetData() {
    _npwrd = widget.npwrd;
    _jenisRetribusi = widget.jenisRetribusi;
    _jenisProduk = widget.jenisProduk;
    _namaWajibRetribusi = widget.namaWajibRetribusi;
    _nominalPajak = widget.nominalPajak;
    _periodePenagihan = widget.periodePenagihan;
    _lokasiRetribusi = widget.lokasiRetribusi;
    _totalNilai = int.parse(widget.nominalPajak);
    _name = widget.name;
    _dateNow = widget.dateNow;
    _parseNominalPajak =
        NumberFormat.simpleCurrency(locale: 'id', decimalDigits: 0)
            .format(int.parse(_nominalPajak));
  }

  void _getPeriodePenagihan() {
    var dateNow = DateTime.now();
    var dayDateNow = DateFormat('dd').format(dateNow);
    var monthDateNow = DateFormat('MM').format(dateNow);
    var yearDateNow = DateFormat('yyyy').format(dateNow);
    var formatDateNow = DateFormat('ddMMyyyy').format(dateNow);
    var parseMonthDateNow;
    parseMonthDateNow = getMonth(monthDateNow);
    if (_periodePenagihan.toLowerCase() == 'harian') {
      _newDate = dateNow.add(Duration(
        days: _totalBayar == null ? 1 : int.parse(_totalBayar),
      ));
    } else if (_periodePenagihan.toLowerCase() == 'mingguan') {
      _newDate = dateNow.add(Duration(
        days: _totalBayar == null ? 1 * 7 : int.parse(_totalBayar) * 7,
      ));
    } else if (_periodePenagihan.toLowerCase() == 'bulanan') {
      _newDate = DateTime(
        dateNow.year,
        dateNow.month + (_totalBayar == null ? 1 : int.parse(_totalBayar)),
        dateNow.day,
      );
    } else if (_periodePenagihan.toLowerCase() == 'tahunan') {
      _newDate = DateTime(
        dateNow.year + (_totalBayar == null ? 1 : int.parse(_totalBayar)),
        dateNow.month,
        dateNow.day,
      );
    }
    var _newDay = DateFormat('dd').format(_newDate);
    var _newMonth = DateFormat('MM').format(_newDate);
    var _newYear = DateFormat('yyyy').format(_newDate);
    var _formatNewDate = DateFormat('ddMMyyyy').format(_newDate);
    _parseMonth = getMonth(_newMonth);
    if (int.parse(_newMonth) == int.parse(monthDateNow)) {
      _periodeBayar = '$dayDateNow - $_newDay $_parseMonth $_newYear';
    } else if (int.parse(_newMonth) > int.parse(monthDateNow)) {
      _periodeBayar =
          '$dayDateNow $parseMonthDateNow - $_newDay $_parseMonth $_newYear';
    } else if (int.parse(_newYear) > int.parse(yearDateNow)) {
      _periodeBayar =
          '$dayDateNow $parseMonthDateNow $yearDateNow - $_newDay $_parseMonth $_newYear';
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

  @override
  void initState() {
    getWidgetData();
    // getUser().then((id) {
    //   _name = id;
    // });
    super.initState();
  }

  void _postRequestCollect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var noHp = prefs.getString('noHp');
    var password = prefs.getString('password');
    Map body = {
      'npwrd': _npwrd,
      'tanggal_penagihan': _dateNow,
      'nominal':
          _parseTotalNilai == null ? _parseNominalPajak : _parseTotalNilai,
      'periode': _formatPeriode,
      'jumlah_bayar': _totalBayar == null ? '1' : _totalBayar,
      'satuan_periode': _periodePenagihan,
    };
    await postCollectTax(noHp, password, body).then((value) {
      if (value != null) {
        // postCollectTax(noHp, password, body);
        // print(postCollectTax(noHp, password, body));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TransaksiScreen(
              npwrd: _npwrd,
              tanggalPenagihan: _dateNow,
              nominalPajak: _parseNominalPajak,
              jenisProduk: _jenisProduk,
              jenisRetribusi: _jenisRetribusi,
              lokasiRetribusi: _lokasiRetribusi,
              namaWajibRetribusi: _namaWajibRetribusi,
              name: _name,
              periodePenagihan: _periodePenagihan,
              totalNilai: _parseTotalNilai == null
                  ? _parseNominalPajak
                  : _parseTotalNilai,
              dibayarkan: _totalBayar == null ? '1' : _totalBayar,
              periodeBayar: _periodeBayar,
            ),
          ),
        );
      } else {
        showPop('Pembayaran Gagal', 'Silahkan cek kembali data pembayaran');
      }
    });
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
  bool shouldPop = true;
  // Future<bool> _onWillPopScope() async {
  //   return Navigator.of(context).pop(true);
  // }
  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
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
                fontFamily: 'poppins regluar',
                fontSize: 14.0,
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        ),
        body: Container(
          height: size.height,
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
                    _getPeriodePenagihan();
                    print(_formatPeriode);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 92,
                                  height: 92,
                                  alignment: Alignment.center,
                                  // padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF2994A),
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          width: 2, color: Colors.white)),
                                  child: FaIcon(
                                    FontAwesomeIcons.exclamation,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  _parseTotalNilai == null
                                      ? 'Total Bayar : $_parseNominalPajak'
                                      : 'Total Bayar : $_parseTotalNilai',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
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
                                      fontWeight: FontWeight.w700,
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
                                        borderRadius: BorderRadius.circular(18.0),
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
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF009A8A),
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
                                        borderRadius: BorderRadius.circular(18.0),
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
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFFFFFFFF),
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
                                    _dateNow.toString(),
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
                                    _parseNominalPajak.toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'opensans regular'),
                                  ),
                                ],
                              ),
                              _dash(context),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 135,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Dibayarkan',
                                          style: TextStyle(
                                              color: Color(0xFF757F8C),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'opensans regular'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Form(
                                        key: _formKey,
                                        child: Container(
                                          margin: EdgeInsets.only(top: 5),
                                          width: 67,
                                          height: 28,
                                          child: TextFormField(
                                            controller: totalBayarController,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              // hintText: 'Nomor Ponsel',
                                              contentPadding: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                              ),
                                              disabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                    color: Color(0xFFE7E7E7)),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                    color: Color(0xFFE7E7E7)),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  borderSide: BorderSide(
                                                      color: Color(0xFFE7E7E7))),
                                              filled: true,
                                              fillColor: Color(0xFFF9F9F9),
                                            ),
                                            onFieldSubmitted: (value) {
                                              setState(() {
                                                final FormState form =
                                                    _formKey.currentState;
                                                if (form.validate()) {
                                                  _totalBayar =
                                                      totalBayarController.text;
                                                  _totalNilai =
                                                      int.parse(_nominalPajak) *
                                                          int.parse(_totalBayar);
                                                }

                                                print(_nominalPajak);
                                                print(_totalNilai);
                                                _parseTotalNilai =
                                                    NumberFormat.simpleCurrency(
                                                            locale: 'id',
                                                            decimalDigits: 0)
                                                        .format(_totalNilai);
                                              });
                                            },
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Tidak valid';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Kali',
                                        style: TextStyle(
                                            color: Color(0xFF757F8C),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'opensans regular'),
                                      ),
                                    ],
                                  ),
                                ],
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
                                          'Total Nilai Retribusi',
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
                                    _parseTotalNilai == null
                                        ? _parseNominalPajak
                                        : _parseTotalNilai.toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'opensans regular'),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 13,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'images/bank_sulselbar.png',
                                    width: 100,
                                  ),
                                  Image.asset(
                                    'images/logo.png',
                                    width: 110,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 19),
                      Text(
                        'Terakhir Bayar : 01 Agustus 2021',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'opensans regular',
                          color: Color(0xFF757F8C),
                        ),
                      ),
                      SizedBox(height: 18),
                    ],
                  ),
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
