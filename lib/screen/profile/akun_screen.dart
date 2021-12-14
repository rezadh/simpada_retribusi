import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpada/models/bottom_bar.dart';
import 'package:simpada/screen/dashboard/dashboard_screen.dart';
import 'package:simpada/screen/login/login_screen.dart';
import 'package:simpada/screen/scan/scan_screen.dart';

class AkunScreen extends StatefulWidget {

  @override
  _AkunScreenState createState() => _AkunScreenState();
}

enum BottomIcons { Beranda, Akun }

class _AkunScreenState extends State<AkunScreen> {
  BottomIcons bottomIcons = BottomIcons.Akun;
  String _name;
  getName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var nama = prefs.getString('name');
    _name = prefs.getString('name');
    return _name;
  }
  @override
  void initState() {
    setState(() {
      getName().then((id){
        setState(() {
          _name = id;
        });
      });
    });
    // print(_name);
    super.initState();
  }
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
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DashboardScreen()),
                                        (route) => false,
                                      );
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
            Stack(
              children: [
                Container(
                  width: 360,
                  height: 318,
                  child: Image.asset('images/bg_profile.png'),
                ),
                Container(
                  width: size.width,
                  padding: EdgeInsets.only(
                    top: 35,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Profil',
                        style: TextStyle(
                            fontFamily: 'poppins regular',
                            color: Colors.white,
                            fontSize: 14),
                      ),
                      SizedBox(height: 30),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Color(0xFFF2C94C),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 5, color: Colors.white),
                        ),
                        child: Image.asset(
                          'images/profile.png',
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        _name ?? '',
                        style: TextStyle(
                            fontFamily: 'poppins regular',
                            color: Colors.white,
                            fontSize: 14),
                      ),
                      SizedBox(height: 45),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 2,
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 12, right: 12, top: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            // border: Border.all(width: 2, color: Colors.white),
                          ),
                          width: 312,
                          height: 144,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Image.asset('images/ic_user.png'),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text('Ubah Kata Sandi', style: TextStyle(
                                      fontFamily: 'poppins regular',
                                      fontWeight: FontWeight.w700,
                                    ),),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Icon(Icons.chevron_right),
                                  ),
                                ],
                              ),
                              Container(
                                width: size.width,
                                height: 1,
                                margin: EdgeInsets.only(left: 15, right: 25),
                                decoration: BoxDecoration(
                                  color: Color(0xFFE7E7E7),
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Color(0xFFE7E7E7), width: 2),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Image.asset('images/ic_info.png'),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text('Bantuan', style: TextStyle(
                                      fontFamily: 'poppins regular',
                                      fontWeight: FontWeight.w700,
                                    ),),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Icon(Icons.chevron_right),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.only(left: 25, right: 25),
                        child: MaterialButton(
                          color: Colors.white,
                          minWidth: size.width,
                          height: 50,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(18.0),
                          ),
                          onPressed: () async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setInt('value', 0);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Keluar',
                            style: TextStyle(
                              color: Colors.red,
                              fontFamily: 'poppins regular',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
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
