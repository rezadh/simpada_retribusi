import 'package:flutter/material.dart';
import 'package:simpada/screen/dashboard/dashboard_screen.dart';

class RegistrasiScreen extends StatefulWidget {
  const RegistrasiScreen({Key? key}) : super(key: key);

  @override
  _RegistrasiScreenState createState() => _RegistrasiScreenState();
}

class _RegistrasiScreenState extends State<RegistrasiScreen> {
  TextEditingController registrasiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFF2E93E1),
        centerTitle: true,
        title: Text(
          'Generate Code',
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 45.0, right: 30.0, left: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'images/generate_code.png',
                  width: 120,
                ),
                SizedBox(
                  height: 60,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kode Registrasi',
                      style: TextStyle(fontFamily: 'Poppins regular'),
                    ),
                  ],
                ),
                TextFormField(
                  controller: registrasiController,
                  decoration: InputDecoration(
                    hintText: 'Kode Registrasi',
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white)),
                    filled: true,
                    fillColor: Color(0xFFFFFFFF),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        '*) Silahkan Input Kode Registrasi Terlebih Dahulu sebelum Anda Masuk.',
                        style:
                            TextStyle(fontSize: 10.0, color: Color(0xFFEB5757)),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 49,
                ),
                MaterialButton(
                  color: Color(0xFF01A190),
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Masuk',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
