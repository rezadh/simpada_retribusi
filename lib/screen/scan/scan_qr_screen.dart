import 'package:flutter/material.dart';
import 'package:simpada/screen/scan/detail_retribusi_screen.dart';
import 'package:simpada/screen/scan/preview_scan_screen.dart';

class ScanQRScreen extends StatefulWidget {
  const ScanQRScreen({Key? key}) : super(key: key);

  @override
  _ScanQRScreenState createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
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
            Positioned(
              bottom: 0,
              left: 0,
              child: MaterialButton(
                color: Color(0xFF01A190),
                minWidth: size.width,
                height: 50,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PreviewScanScreen(),
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
                  SizedBox(height: 5,),
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
                            child: Icon(Icons.qr_code_2, size: 150,),
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.only(
                            //     bottomLeft: Radius.circular(27.0),
                            //     bottomRight: Radius.circular(27.0),
                            //   ),
                            // ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
