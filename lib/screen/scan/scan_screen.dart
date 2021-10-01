import 'package:flutter/material.dart';
import 'package:simpada/screen/scan/input_retribusi_screen.dart';
import 'package:simpada/screen/scan/scan_qr_screen.dart';

class ScanScreen extends StatefulWidget {

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.only(left: 25, right: 25, top: 25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 1,
              child: Container(
                width: 311,
                height: 101,
                child: Stack(
                  children: [
                    Positioned(
                      child: Image.asset(
                        'images/shape_pink.png',
                        width: 311,
                      ),
                      top: 50,
                    ),
                    Container(
                      height: 101,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.qr_code_2,
                            size: 70,
                            color: Color(0xFFEB5252),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Scan QR',
                                style: TextStyle(
                                  fontFamily: 'poppins regular',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Flexible(
                                child: FlatButton(
                                  color: Colors.white,
                                  minWidth: 100,
                                  height: 25,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                        color: Color(0xFF2E8DE5),
                                      )),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ScanQRScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Buka',
                                    style: TextStyle(
                                      color: Color(0xFF2E8DE5),
                                      fontFamily: 'poppins regular',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.only(left: 25, right: 25, top: 25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 1,
              child: Container(
                width: 311,
                height: 101,
                child: Stack(
                  children: [
                    Positioned(
                      child: Image.asset(
                        'images/shape_pink.png',
                        width: 311,
                      ),
                      top: 50,
                    ),
                    Container(
                      height: 101,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'images/input.png',
                            width: 71,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Input Retribusi',
                                style: TextStyle(
                                  fontFamily: 'poppins regular',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Flexible(
                                child: FlatButton(
                                  color: Colors.white,
                                  minWidth: 100,
                                  height: 25,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                        color: Color(0xFF2E8DE5),
                                      )),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            InputRetribusiScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Buka',
                                    style: TextStyle(
                                      color: Color(0xFF2E8DE5),
                                      fontFamily: 'poppins regular',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
