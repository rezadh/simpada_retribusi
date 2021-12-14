import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpada/data/api/api_service.dart';
import 'package:simpada/data/model/simpada_retribusi.dart';
import 'package:simpada/screen/scan/preview_scan_screen.dart';
import 'package:simpada/screen/scan/tagihan_retribusi_screen.dart';

class ScanQRScreen extends StatefulWidget {
  @override
  _ScanQRScreenState createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
  // final GlobalKey qrKey = GlobalKey();
  String barcode = "";
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;
  String _npwrd;
  List _listNpwrd = [];
  Future<List<Profile>> _listProfile;
  String _namaWajibRetribusi;
  String _username;
  String _jenisRetribusi;
  String _jenisProduk;
  String _nominalPajak;
  String _periodePenagihan;
  String _lokasiRetribusi;
  String _name;
  String _dateNow;
  String _alamat;
  String _noHp;

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString('name');
    _username = prefs.getString('noHp');
    return _name;
  }

  getDate() async {
    var dateNow = DateTime.now();
    var date = DateFormat('dd').format(dateNow);
    var month = DateFormat('MM').format(dateNow);
    var year = DateFormat('yyyy').format(dateNow);
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

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;

        // print(_npwrd);
        // print(_periodePenagihan);
        _getResult();
        print(result.code);
      });
    });
  }

  void _getResult() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => PreviewScanScreen(
    //       npwrd: _npwrd,
    //       jenisRetribusi: _jenisRetribusi,
    //       jenisProduk: _jenisProduk,
    //       namaWajibRetribusi: _namaWajibRetribusi,
    //       nominalPajak: _nominalPajak,
    //       periodePenagihan: _periodePenagihan,
    //       lokasiRetribusi: _lokasiRetribusi,
    //       name: _name,
    //       dateNow: _dateNow,
    //     ),
    //   ),
    //   (Route<dynamic> route) => false,
    // );
    // _namaWajibRetribusi = parts[1].trim();
    // _alamat = parts[2].trim();
    // _noHp = parts[3].trim();
    _listNpwrd.clear();
    var parts = result.code.split('|');
    _npwrd = parts[0].trim();
    _jenisRetribusi = parts[1].trim();
    _jenisProduk = parts[2].trim();
    _namaWajibRetribusi = parts[3].trim();
    _nominalPajak = parts[4].trim();
    _periodePenagihan = parts[5].trim();
    _lokasiRetribusi = parts[6].trim();
    _listNpwrd.add(_npwrd);
    print(_listNpwrd);
    prefs.setString('npwrd',_npwrd);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TagihanRetribusiScreen(
          listProfile: _listNpwrd,
          // npwrd: _npwrd,
          // alamat: _alamat,
          // noHp: _noHp,
          // namaWajibRetribusi: _namaWajibRetribusi,
          // username: _username,
          // name: _name,
          // dateNow: _dateNow,
        ),
      ),
    );

    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => PreviewScanScreen(
    //       npwrd: _npwrd,
    //       jenisRetribusi: _jenisRetribusi,
    //       jenisProduk: _jenisProduk,
    //       namaWajibRetribusi: _namaWajibRetribusi,
    //       nominalPajak: _nominalPajak,
    //       periodePenagihan: _periodePenagihan,
    //       lokasiRetribusi: _lokasiRetribusi,
    //       name: _name,
    //       dateNow: _dateNow,
    //     ),
    //   ),
    // );
  }

  @override
  void initState() {
    setState(() {
      getUser();
      getDate();
    });
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  bool shouldPop = true;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return shouldPop;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFFFFFFF),
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
          child: Stack(
            children: [
              // Positioned(
              //   bottom: 0,
              //   left: 0,
              //   child: result == null
              //       ? MaterialButton(
              //           color: Color(0xFFBDBDBD),
              //           minWidth: size.width,
              //           height: 50,
              //           onPressed: () {},
              //           child: Text(
              //             'Bayar',
              //             style: TextStyle(
              //                 color: Color(0xFFFFFFFF),
              //                 fontFamily: 'poppins regular',
              //                 fontWeight: FontWeight.w700,
              //                 fontSize: 14),
              //           ),
              //         )
              //       : MaterialButton(
              //           color: Color(0xFF01A190),
              //           minWidth: size.width,
              //           height: 50,
              //           onPressed: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => PreviewScanScreen(
              //                   npwrd: _npwrd,
              //                   jenisRetribusi: _jenisRetribusi,
              //                   jenisProduk: _jenisProduk,
              //                   namaWajibRetribusi: _namaWajibRetribusi,
              //                   nominalPajak: _nominalPajak,
              //                   periodePenagihan: _periodePenagihan,
              //                   lokasiRetribusi: _lokasiRetribusi,
              //                   name: _name,
              //                   dateNow: _dateNow,
              //                 ),
              //               ),
              //             );
              //           },
              //           child: Text(
              //             'Bayar',
              //             style: TextStyle(
              //                 color: Color(0xFFFFFFFF),
              //                 fontFamily: 'poppins regular',
              //                 fontWeight: FontWeight.w700,
              //                 fontSize: 14),
              //           ),
              //         ),
              // ),
              Container(
                width: size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      'Scan QR Code',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'opensans regular',
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 191,
                      child: Text(
                        'Align the QR code within the frame to scan.',
                        style: TextStyle(
                            color: Color(0xFF757F8C),
                            fontSize: 14,
                            fontFamily: 'opensans regular',
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
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
                      child: Stack(
                        children: [
                          Container(
                            width: size.width,
                            height: 395,
                          ),
                          Positioned(
                            top: 49,
                            left: 44,
                            child: Container(
                              alignment: Alignment.center,
                              color: Color(0xFFCCECE9),
                              width: 224,
                              height: 209,
                              child: result == null
                                  ? QRView(
                                      key: qrKey,
                                      onQRViewCreated: _onQRViewCreated,
                                    )
                                  : Icon(
                                      Icons.qr_code_2,
                                      size: 150,
                                    ),
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.only(
                              //     bottomLeft: Radius.circular(27.0),
                              //     bottomRight: Radius.circular(27.0),
                              //   ),
                              // ),
                            ),
                          ),
                          // Positioned(
                          //   top: 300,
                          //   child: Center(
                          //     child: (result != null)
                          //         ? Text(
                          //             'Barcode Type: ${describeEnum(result.format)}   Data: ${result.code}')
                          //         : Text('Scan a code'),
                          //   ),
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
