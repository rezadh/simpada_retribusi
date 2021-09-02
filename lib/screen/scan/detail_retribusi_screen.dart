import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:simpada/screen/transaksi/transaksi_screen.dart';

class DetailRetribusiScreen extends StatefulWidget {
  const DetailRetribusiScreen({Key? key}) : super(key: key);

  @override
  _DetailRetribusiScreenState createState() => _DetailRetribusiScreenState();
}

class _DetailRetribusiScreenState extends State<DetailRetribusiScreen> {
  TextEditingController totalBayarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFECECEC),
      appBar: AppBar(
        backgroundColor: Color(0xFF2E93E1),
        centerTitle: true,
        title: Text(
          'Detail Retribusi',
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
                                'Total Bayar : Rp 5.000',
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
                                      side: BorderSide(color: Color(0xFF01A190,), width: 1.0,),
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
                                      // Navigator.pushAndRemoveUntil(
                                      //   context,
                                      //   MaterialPageRoute(builder: (context) => TransaksiScreen()),
                                      //       (route) => false,
                                      // );
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => TransaksiScreen(),
                                        ),
                                      );
                                    },
                                    color: Color(0xFF01A190),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Color(0xFF01A190,), width: 1.0,),
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

                  // Alert(
                  //   context: context,
                  //   content: Column(
                  //     children: [
                  //       Container(
                  //         width: 92,
                  //         height: 92,
                  //         alignment: Alignment.center,
                  //         // padding: EdgeInsets.all(10),
                  //         decoration: BoxDecoration(
                  //             color: Color(0xFFF2994A),
                  //             borderRadius: BorderRadius.circular(50),
                  //             border:
                  //                 Border.all(width: 2, color: Colors.white)),
                  //         child: FaIcon(
                  //           FontAwesomeIcons.exclamation,
                  //           size: 50,
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //       Text(
                  //         'Total Bayar : Rp 5.000',
                  //         style: TextStyle(
                  //             fontSize: 18,
                  //             fontWeight: FontWeight.w800,
                  //             color: Color(0xFF252B42),
                  //             fontFamily: 'opensans regular'),
                  //       ),
                  //     ],
                  //   ),
                  //   buttons: [
                  //     DialogButton(
                  //       child: Text(
                  //         "FLAT",
                  //         style: TextStyle(color: Colors.white, fontSize: 20),
                  //       ),
                  //       onPressed: () => Navigator.pop(context),
                  //       color: Color.fromRGBO(0, 179, 134, 1.0),
                  //     ),
                  //     DialogButton(
                  //       child: Text(
                  //         "GRADIENT",
                  //         style: TextStyle(color: Colors.white, fontSize: 20),
                  //       ),
                  //       onPressed: () => Navigator.pop(context),
                  //       gradient: LinearGradient(colors: [
                  //         Color.fromRGBO(116, 116, 191, 1.0),
                  //         Color.fromRGBO(52, 138, 199, 1.0)
                  //       ]),
                  //     )
                  //   ],
                  // ).show();
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => DetailRetribusiScreen(),
                  //   ),
                  // );
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
                                  Container(
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
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Tidak boleh kosong';
                                        }
                                        return null;
                                      },
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
