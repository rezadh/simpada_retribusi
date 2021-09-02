import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:simpada/models/bottom_bar.dart';
import 'package:simpada/screen/generate/generate_screen.dart';
import 'package:simpada/screen/profile/akun_screen.dart';
import 'package:simpada/screen/riwayat/riwayat_screen.dart';
import 'package:simpada/screen/scan/scan_screen.dart';

final List<String> imagesList = [
  // 'https://cdn.pixabay.com/photo/2020/11/01/23/22/breakfast-5705180_1280.jpg',
  // 'https://cdn.pixabay.com/photo/2016/11/18/19/00/breads-1836411_1280.jpg',
  // 'https://cdn.pixabay.com/photo/2019/01/14/17/25/gelato-3932596_1280.jpg',
  // 'https://cdn.pixabay.com/photo/2017/04/04/18/07/ice-cream-2202561_1280.jpg',
  'images/banner_app_langgananta.png',
  'images/clock.png',
  'images/logo.png',
];
final List<String> titles = [
  ' Coffee ',
  ' Bread ',
  ' Gelato ',
];

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

enum BottomIcons { Beranda, Akun }

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  BottomIcons bottomIcons = BottomIcons.Beranda;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: size.width,
                height: 60,
                child: Stack(
                  children: [
                    CustomPaint(
                      size: Size(size.width, 60),
                      painter: BNBCustomPainter(),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 5, left: 14, right: 14, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BottomBar(
                                  onPressed: () {
                                    setState(() {
                                      bottomIcons = BottomIcons.Beranda;
                                    });
                                  },
                                  bottomIcons:
                                      bottomIcons == BottomIcons.Beranda
                                          ? true
                                          : false,
                                  text: 'Beranda',
                                  icons: Icons.dashboard_outlined),
                              BottomBar(
                                  onPressed: () {
                                    setState(() {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AkunScreen()),
                                        (route) => false,
                                      );
                                      bottomIcons = BottomIcons.Akun;
                                    });
                                  },
                                  bottomIcons: bottomIcons == BottomIcons.Akun
                                      ? true
                                      : false,
                                  text: 'Akun',
                                  icons: Icons.person_outline),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      heightFactor: 0.3,
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScanScreen()),
                          );
                        },
                        backgroundColor: Color(0xFFF2994A),
                        child: Icon(
                          Icons.qr_code_2,
                          size: 40,
                        ),
                        elevation: 0.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  height: 200,
                  child: Stack(
                    children: [
                      Container(
                        height: 140,
                        color: Color(0xFF2E8CE5),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 45,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 25, right: 30),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Simpada Retribusi',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'poppins regular',
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFFFFFFFF)),
                                      ),
                                      Text(
                                        'Senin, 1 Maret 2021',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFFFFFFFF)),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    // color: Colors.white,
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                            width: 2, color: Colors.white)),
                                    child: Icon(
                                      Icons.notifications,
                                      color: Color(0xFF2E8DE5),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: 105,
                        left: 25,
                        right: 25,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 1,
                          child: Container(
                            height: 72,
                            width: 311,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              // border: Border.all(width: 2, color: Colors.white),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(27.0),
                                      bottomRight: Radius.circular(27.0),
                                    ),
                                    child: Image.asset(
                                      'images/shape_blue.png',
                                    ),
                                  ),
                                  left: -5,
                                  top: 37,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 8),
                                      Text(
                                        'Daftar Setoran Retribusi',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: 'poppins regular',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Flexible(
                                        child: FlatButton(
                                          color: Color(0xFF2E8DE5),
                                          minWidth: 100,
                                          height: 25,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    GenerateScreen(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Masuk',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'poppins regular',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: 35),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 1,
                  child: Container(
                    height: 101,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      // border: Border.all(width: 2, color: Colors.white),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15.0),
                            ),
                            child: Container(width: 311,child: Image.asset('images/shape_orange.png')),
                          ),
                          top: 50,
                        ),
                        Positioned(
                          top: 18,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15.0),
                            ),
                            child: Container(width: 109,child: Image.asset('images/clock.png')),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 40),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Riwayat',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontFamily: 'poppins regular',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Flexible(
                                    child: FlatButton(
                                      color: Colors.white,
                                      minWidth: 100,
                                      height: 25,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                            color: Color(0xFF2E8DE5),
                                          )),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RiwayatScreen(),
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
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    height: 130,
                    // scrollDirection: Axis.vertical,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: imagesList
                      .map(
                        (item) => Container(
                          // width: 230,
                          child: Card(
                            margin: EdgeInsets.only(
                              top: 10.0,
                              bottom: 10.0,
                            ),
                            elevation: 6.0,
                            shadowColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    item,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                  // Center(
                                  //   child: Text(
                                  //     '${titles[_currentIndex]}',
                                  //     style: TextStyle(
                                  //       fontSize: 24.0,
                                  //       fontWeight: FontWeight.bold,
                                  //       backgroundColor: Colors.black45,
                                  //       color: Colors.white,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imagesList.map((urlOfItem) {
                    int index = imagesList.indexOf(urlOfItem);
                    return Container(
                      width: 10.0,
                      height: 10.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentIndex == index
                            ? Color.fromRGBO(0, 0, 0, 0.8)
                            : Color.fromRGBO(0, 0, 0, 0.3),
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
          ],
        ),
      ),
      // floatingActionButton: ClipRRect(
      //   borderRadius: BorderRadius.circular(80),
      //   child: Container(
      //     color: Colors.black,
      //     padding: EdgeInsets.all(8),
      //     child: FloatingActionButton(
      //       onPressed: () {},
      //     ),
      //   ),
      // ),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterDocked,
      // bottomNavigationBar: Container(
      //   margin: EdgeInsets.only(left: 16, right: 16),
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     borderRadius: BorderRadius.only(
      //         topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      //   ),
      //   child: BottomNavigationBar(
      //     backgroundColor: Colors.transparent,
      //     showUnselectedLabels: true,
      //     type: BottomNavigationBarType.fixed,
      //     elevation: 0,
      //     items: [
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.home), title: Text('Home')),
      //       // BottomNavigationBarItem(
      //       //     icon: Icon(Icons.local_activity), title: Text('Activity')),
      //       // BottomNavigationBarItem(
      //       //     icon: Icon(Icons.inbox), title: Text('Inbox')),
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.person), title: Text('Profile')),
      //     ],
      //   ),
      // ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xFF01A190)
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 0);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 10);
    path.arcToPoint(Offset(size.width * 0.60, 10),
        radius: Radius.circular(10.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    // canvas.drawShadow(path, Colors.black,5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
