import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simpada/screen/transaksi/bukti_bayar_screen.dart';

class TransaksiScreen extends StatefulWidget {
  const TransaksiScreen({Key? key}) : super(key: key);

  @override
  _TransaksiScreenState createState() => _TransaksiScreenState();
}

class _TransaksiScreenState extends State<TransaksiScreen> {
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
        child: Stack(
          children: [
            Positioned(
              bottom: 23,
              left: 0,
              child: Container(
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BuktiBayarScreen(),
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
            ),
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
                    elevation: 2,
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
                                'Retribusi parkir',
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
                                'Harian',
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
                                '04 Agustus 2021',
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
                                'Nopi Nurhayati',
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
                                'Pasar Antang',
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
                                'Rp 5.000',
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
                                  Text('1'),
                                  SizedBox(
                                    width: 15,
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
                  )
                ],
              ),
            )
          ],
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
