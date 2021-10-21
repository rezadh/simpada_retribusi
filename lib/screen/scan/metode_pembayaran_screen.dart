import 'package:flutter/material.dart';

class MetodePembayaranScreen extends StatefulWidget {
  @override
  _MetodePembayaranScreenState createState() => _MetodePembayaranScreenState();
}

class _MetodePembayaranScreenState extends State<MetodePembayaranScreen> {
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
          'Metode Pembayaran',
          style: TextStyle(
              fontFamily: 'poppins regular',
              fontSize: 14.0,
              fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              width: size.width,
              padding:
                  EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Pembayaran Tunai',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'poppins regular'),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xFFFFFFFF),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0),
                                blurRadius: 2.0),
                          ],
                        ),
                        child: Image.asset('images/cash.png', width: 22, height: 22),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Pembayaran Cash',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Container(
              width: size.width,
              padding:
              EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Virtual Account (Dicek Otomatis)',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'poppins regular'),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xFFFFFFFF),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0),
                                blurRadius: 2.0),
                          ],
                        ),
                        child: Image.asset('images/bank_sulselbar.png', width: 22, height: 22),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Bank Sulselbar',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
