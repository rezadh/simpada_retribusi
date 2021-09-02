import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:simpada/screen/dashboard/dashboard_screen.dart';

class GenerateCodeScreen extends StatefulWidget {
  const GenerateCodeScreen({Key? key}) : super(key: key);

  @override
  _GenerateCodeScreenState createState() => _GenerateCodeScreenState();
}

class _GenerateCodeScreenState extends State<GenerateCodeScreen> {
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
              height: 76,
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
                      '20210330000106500',
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
                      '06-08-2021',
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'STRD/3984/ad',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'opensans regular',
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF757F8C),
                    ),
                  ),
                  Text(
                    'Rp 20.000',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'opensans regular',
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF757F8C),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 7,),
            Text(
              'Periode Agustus 2021',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'opensans regular',
                fontWeight: FontWeight.w400,
                color: Color(0xFF757F8C),
              ),
            ),
            SizedBox(height: 138,),
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
          ],
        ),
      ),
    );
  }
}
