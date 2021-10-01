import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpada/data/api/api_service.dart';
import 'package:simpada/data/model/simpada_retribusi.dart';
import 'package:simpada/screen/dashboard/dashboard_screen.dart';
import 'package:simpada/screen/login/registrasi_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool checkBoxValue = false;
  bool _isShowPassword = true;
  TextEditingController noHpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _noHp;
  String _password;
  Login login;

  getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt('value');
    String code = prefs.getString('code');
    if (value == 1) {
      if (code != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RegistrasiScreen()),
        );
      }
    }
    return value;
  }

  void _checkStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(_noHp != null && _password != null){
      await getToken(noHpController.text, passwordController.text).then((value) async {
        if (value != null) {
          await postRequestLogin(_noHp, _password).then((value) {
            if (value != null) {
              setState(() {
                if (_noHp != null && _password != null) {
                  prefs.setString('noHp', _noHp);
                  prefs.setString('password', _password);
                  prefs.setInt('value', 1);
                  prefs.setString('name', value.name);
                  String code = prefs.getString('code');
                  //TODO tambahkan validasi jika kode registrasi sudah ada
                  if(code != null){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => DashboardScreen()),
                    );
                  }else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => RegistrasiScreen()),
                    );
                  }
                }
              });
            } else {}
          });
        } else {
          showPop('Login gagal', 'username dan password salah');
        }
      });
    }

  }

  Future<bool> showPop(String title, String message) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          content: Text(
            message,
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('TUTUP'),
            ),
          ],
        ),
      );

  @override
  void initState() {
    setState(() {
      getValue();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFF7F7F7),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xFF2E93E1),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.only(top: 45.0, right: 30.0, left: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/logo.png',
                      width: 182,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Koleksi Retribusi',
                      style: TextStyle(fontFamily: 'poppins bold'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: noHpController,
                      decoration: InputDecoration(
                        hintText: 'Nomor Ponsel',
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.white)),
                        filled: true,
                        fillColor: Color(0xFFFFFFFF),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _noHp = noHpController.text;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: _isShowPassword,
                      decoration: InputDecoration(
                        hintText: 'Kata Sandi',
                        suffixIcon: GestureDetector(
                          child: Icon(
                            _isShowPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color(0xFFBDBDBD),
                          ),
                          onTap: () {
                            setState(() {
                              _isShowPassword = !_isShowPassword;
                            });
                          },
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.white)),
                        filled: true,
                        fillColor: Color(0xFFFFFFFF),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _password = passwordController.text;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Lupa Kata Sandi?',
                          style: TextStyle(fontFamily: 'poppins regular'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 65,
                    ),
                    MaterialButton(
                      color: Color(0xFF01A190),
                      minWidth: double.infinity,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      onPressed: () {
                        setState(() {
                          _checkStatus();
                          // getToken();
                          // postRegistration();
                          // postRequestLogin(noHpController.text);
                        });
                      },
                      child: Text(
                        'Masuk',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
