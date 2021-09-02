import 'package:flutter/material.dart';
import 'package:simpada/screen/generate/generate_code_screen.dart';

class GenerateScreen extends StatefulWidget {
  const GenerateScreen({Key? key}) : super(key: key);

  @override
  _GenerateScreenState createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  bool checkBoxValue = false;

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
            SizedBox(height: 25),
            Text(
              'Generate Kode Billing',
              style: TextStyle(fontSize: 16, fontFamily: 'opensans regular', fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 28,
            ),
            Card(
              margin: EdgeInsets.only(left: 25, right: 25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9.0),
              ),
              elevation: 2,
              child: Container(
                padding:
                    EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9.0),
                  // border: Border.all(width: 2, color: Colors.white),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 19,
                        ),
                        Text(
                          'No. STRD',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'opensans regular',
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          'STRD/3984/ad',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'opensans regular',
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF757F8C),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'STRD/3984/ad',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'opensans regular',
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF757F8C),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'STRD/3984/ad',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'opensans regular',
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF757F8C),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'STRD/3984/ad',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'opensans regular',
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF757F8C),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 19,
                        ),
                        Text(
                          'Tanggal',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'opensans regular',
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          '01-08-21',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'opensans regular',
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF757F8C),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          '01-08-21',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'opensans regular',
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF757F8C),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          '01-08-21',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'opensans regular',
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF757F8C),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          '01-08-21',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'opensans regular',
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF757F8C),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 19,
                        ),
                        Text(
                          'Nilai',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'opensans regular',
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          '5.000',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'opensans regular',
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF757F8C),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          '5.000',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'opensans regular',
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF757F8C),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          '5.000',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'opensans regular',
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF757F8C),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          '5.000',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'opensans regular',
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF757F8C),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          'Check All',
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'opensans regular',
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: Transform.scale(
                            scale: 0.8,
                            child: Checkbox(
                              value: checkBoxValue,
                              onChanged: (bool? value) {
                                setState(() {
                                  checkBoxValue = value!;
                                  print(checkBoxValue);
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: Transform.scale(
                            scale: 0.8,
                            child: Checkbox(
                              value: checkBoxValue,
                              onChanged: (bool? value) {
                                setState(() {
                                  checkBoxValue = value!;
                                  print(checkBoxValue);
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: Transform.scale(
                            scale: 0.8,
                            child: Checkbox(
                              value: checkBoxValue,
                              onChanged: (bool? value) {
                                setState(() {
                                  checkBoxValue = value!;
                                  print(checkBoxValue);
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: Transform.scale(
                            scale: 0.8,
                            child: Checkbox(
                              value: checkBoxValue,
                              onChanged: (bool? value) {
                                setState(() {
                                  checkBoxValue = value!;
                                  print(checkBoxValue);
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: Transform.scale(
                            scale: 0.8,
                            child: Checkbox(
                              value: checkBoxValue,
                              onChanged: (bool? value) {
                                setState(() {
                                  checkBoxValue = value!;
                                  print(checkBoxValue);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
            Container(
              margin: EdgeInsets.only(left: 25, right: 25),
              child: MaterialButton(
                color: Color(0xFFF2994A),
                minWidth: size.width,
                height: 45,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(37.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GenerateCodeScreen(),
                    ),
                  );
                },
                child: Text(
                  'Generate',
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
