import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpada/data/model/generate_token_model.dart';
import 'package:simpada/data/model/login_model.dart';
import 'package:simpada/data/model/registrasi_model.dart';
import 'package:simpada/screen/dashboard/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool checkBoxValue = false;
  bool _isShowPassword = true;
  TextEditingController noHpController = TextEditingController();
  TextEditingController kodeRegistrasiController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _noHp;
  String _password;
  String _kodeRegistrasi;
  Login login;
  String code;
  int _values;

  getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt('value');
    var _code = prefs.getString('code');
    code = prefs.getString('code');
    if (value == 1) {
      if (_code != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      }
      // else {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => RegistrasiScreen()),
      //   );
      // }
    }
    return _code;
  }

  void _checkStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (code == null) {
      if (_noHp != null && _password != null) {
        await postRegistration(noHpController.text, passwordController.text,
                kodeRegistrasiController.text)
            .then((value) async {
          if (value != null) {
            await getToken(noHpController.text, passwordController.text)
                .then((value) async {
              if (value != null) {
                await postRequestLogin(_noHp, _password).then((value) {
                  if (value != null) {
                    setState(() {
                      prefs.setString('noHp', _noHp);
                      prefs.setString('password', _password);
                      prefs.setString('code', _kodeRegistrasi);
                      prefs.setInt('value', 1);
                      prefs.setInt('values', 1);
                      prefs.setString('name', value.name);
                      print(_kodeRegistrasi);
                      // String code = prefs.getString('code');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardScreen()),
                      );
                      // code = prefs.getString('code');
                    });
                  } else {
                    showPop('Login gagal',
                        'Masukkan Nomor Telepon dan Kata Sandi login');
                  }
                });
              } else {
                showPop('Login gagal', 'Nomor Telepon dan Kata Sandi salah');
              }
            });
          } else {
            showPop('Login Gagal', 'Masukkan kode registrasi');
          }
        });
      } else {
        showPop('Login gagal', 'Masukkan Nomor Telepon dan Kata Sandi');
      }
    } else {
      await postRegistration(noHpController.text, passwordController.text, code)
          .then((value) async {
        if (value != null) {
          await getToken(noHpController.text, passwordController.text)
              .then((value) async {
            if (value != null) {
              await postRequestLogin(_noHp, _password).then((value) {
                if (value != null) {
                  setState(() {
                    prefs.setString('noHp', _noHp);
                    prefs.setString('password', _password);
                    prefs.setInt('value', 1);
                    prefs.setString('name', value.name);
                    print(value.name);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashboardScreen()),
                    );
                  });
                } else {
                  showPop('Login gagal',
                      'Masukkan Nomor Telepon dan Kata Sandi login');
                }
              });
            } else {
              showPop('Login gagal', 'Nomor Telepon dan Kata Sandi salah');
            }
          });
        } else {
          showPop('Login gagal', 'Nomor Telepon salah');
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
    setState(() {});
    getValue().then((id) {
      setState(() {
        print('ini code $code');
        code = id;
      });
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
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Color(0xFF2E93E1),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                      Visibility(
                        visible: code == null ? true : false,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: kodeRegistrasiController,
                          decoration: InputDecoration(
                            hintText: 'Masukkan Kode Registrasi',
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
                              _kodeRegistrasi = kodeRegistrasiController.text;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ),
                      Visibility(
                          visible: code == null ? true : false,
                          child: SizedBox(height: 20)),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: noHpController,
                        decoration: InputDecoration(
                          hintText: 'Masukkan Nomor Telepon',
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
                          hintText: 'Masukkan Kata Sandi',
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
                        height: 35,
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
                      SizedBox(height: 30),
                      Text(
                        '1.0.5',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
