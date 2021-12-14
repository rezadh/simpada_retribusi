import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpada/data/api/api_service.dart';
import 'package:simpada/screen/dashboard/dashboard_screen.dart';
import 'package:simpada/screen/login/registrasi_screen.dart';

import 'login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var noHp = prefs.getString('noHp');
    var password = prefs.getString('password');
    if (noHp == null && password == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      await getToken(noHp, password).then((value) async {
        if (value != null) {
          return;
        }
      });
    }
  }

  @override
  void initState() {
    splashScreenStart();
    setState(() {
      _getToken();
    });
    super.initState();
  }

  void splashScreenStart() async {
    var duration = const Duration(milliseconds: 100);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getInt('value');
    // var code = prefs.getString('code');
    Timer(duration, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                value == 1 ? DashboardScreen() : LoginScreen()),
      );
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) =>
      //           value == 1 ? code != null ? DashboardScreen() : LoginScreen() : LoginScreen()),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    );
  }
}
