import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFF2F2F2),
        body: Container(
          padding: EdgeInsets.only(top: 19, bottom: 19),
          child: Column(
            children: [
              Card(
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
                            'Nopi Nurhayati',
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
                                '3 Nov 2020',
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
                                  '11:00',
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
                            'Rp 5.000',
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
                            'Lunas',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'opensans regular',
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF27AE60),
                            ),
                          ),
                        ],
                      ),
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
