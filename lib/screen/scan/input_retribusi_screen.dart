import 'package:flutter/material.dart';
import 'package:simpada/screen/scan/detail_retribusi_screen.dart';

class InputRetribusiScreen extends StatefulWidget {
  const InputRetribusiScreen({Key? key}) : super(key: key);

  @override
  _InputRetribusiScreenState createState() => _InputRetribusiScreenState();
}

class _InputRetribusiScreenState extends State<InputRetribusiScreen> {
  TextEditingController mobilController = TextEditingController();
  TextEditingController motorController = TextEditingController();
  TextEditingController totalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xFF2E93E1),
        centerTitle: true,
        title: Text(
          'Input Retribusi',
          style: TextStyle(
              fontFamily: 'poppins regluar',
              fontSize: 14.0,
              fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        height: size.height,
        padding: EdgeInsets.only(top: 13),
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
                      builder: (context) => DetailRetribusiScreen(),
                    ),
                  );
                },
                child: Text(
                  'Kirim',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontFamily: 'poppins regular',
                    fontWeight: FontWeight.w700,
                    fontSize: 14
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 23, right: 24,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jumlah Kendaraan',
                    style: TextStyle(
                      fontFamily: 'poppins regular',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mobil',
                              style: TextStyle(
                                fontFamily: 'poppins regular',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF737373),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              width: 150,
                              height: 40,
                              child: TextFormField(
                                controller: mobilController,
                                maxLines: 1,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  // hintText: 'Nomor Ponsel',
                                  contentPadding: EdgeInsets.all(10),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide:
                                        BorderSide(color: Color(0xFFE7E7E7)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide:
                                        BorderSide(color: Color(0xFFE7E7E7)),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide:
                                          BorderSide(color: Color(0xFFE7E7E7))),
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
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Motor',
                              style: TextStyle(
                                fontFamily: 'poppins regular',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF737373),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              width: 150,
                              height: 40,
                              child: TextFormField(
                                controller: motorController,
                                maxLines: 1,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  // hintText: 'Nomor Ponsel',
                                  contentPadding: EdgeInsets.all(10),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide:
                                        BorderSide(color: Color(0xFFE7E7E7)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide:
                                        BorderSide(color: Color(0xFFE7E7E7)),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide:
                                          BorderSide(color: Color(0xFFE7E7E7))),
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
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 21,
                  ),
                  Text(
                    'Total Transaksi',
                    style: TextStyle(
                      fontFamily: 'poppins regular',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF737373),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    width: size.width,
                    height: 40,
                    child: TextFormField(
                      controller: totalController,
                      maxLines: 1,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        // hintText: 'Nomor Ponsel',
                        contentPadding: EdgeInsets.all(10),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Color(0xFFE7E7E7)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Color(0xFFE7E7E7)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Color(0xFFE7E7E7))),
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
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
