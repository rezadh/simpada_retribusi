import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpada/data/api/api_service.dart';
import 'package:simpada/data/model/simpada_retribusi.dart';
import 'package:simpada/screen/scan/preview_scan_screen.dart';

import '../../constants.dart';

class TagihanRetribusiScreen extends StatefulWidget {
  // final npwrd;
  // final namaWajibRetribusi;
  // final alamat;
  // final noHp;
  // final username;
  // final jenisRetribusi;
  // final jenisProduk;
  // final nominalPajak;
  // final periodePenagihan;
  // final lokasiRetribusi;
  // final name;
  // final dateNow;
  final List<dynamic> listProfile;

  TagihanRetribusiScreen({List<dynamic> listProfile
      // {this.npwrd,
      // this.namaWajibRetribusi,
      // this.alamat,
      // this.noHp,
      // this.name,
      // this.username,
      // this.dateNow,
      // this.jenisRetribusi,
      // this.jenisProduk,
      // this.nominalPajak,
      // this.periodePenagihan,
      // this.lokasiRetribusi
      })
      : this.listProfile = listProfile ?? [];

  @override
  _TagihanRetribusiScreenState createState() => _TagihanRetribusiScreenState();
}

class _TagihanRetribusiScreenState extends State<TagihanRetribusiScreen> {
  // String _npwrd;
  // String _namaWajibRetribusi;
  // String _alamat;
  // String _noHp;
  String _name;
  String _username;
  String _dateNow;
  List<dynamic> _listProfile;
  Future<List<Profile>> futureProfile;

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString('name');
    _username = prefs.getString('noHp');
    return _name;
  }

  void getWidgetData() {
    _listProfile = widget.listProfile;
    print('ini list $_listProfile');
    futureProfile = postRequestProfile(_listProfile);
    // _npwrd = widget.npwrd;
    // _namaWajibRetribusi = widget.namaWajibRetribusi;
    // _alamat = widget.alamat;
    // _noHp = widget.noHp;
    //   _name = widget.name;
    //   _username = widget.username;
    //   _dateNow = widget.dateNow;
  }
//TODO jenis retribusi masih statis
  String _jenisRetribusi(int index) {
    if (index == 0) {
      return 'Pasar';
    }
    return null;
  }
  getDate() async {
    var dateNow = DateTime.now();
    var date = DateFormat('dd').format(dateNow);
    var month = DateFormat('MM').format(dateNow);
    var year = DateFormat('yyyy').format(dateNow);
    String parseMonth;
    if (month == '01') {
      parseMonth = 'Januari';
    } else if (month == '02') {
      parseMonth = 'Februari';
    } else if (month == '03') {
      parseMonth = 'Maret';
    } else if (month == '04') {
      parseMonth = 'April';
    } else if (month == '05') {
      parseMonth = 'Mei';
    } else if (month == '06') {
      parseMonth = 'Juni';
    } else if (month == '07') {
      parseMonth = 'Juli';
    } else if (month == '08') {
      parseMonth = 'Agustus';
    } else if (month == '09') {
      parseMonth = 'September';
    } else if (month == '10') {
      parseMonth = 'Oktober';
    } else if (month == '11') {
      parseMonth = 'November';
    } else if (month == '12') {
      parseMonth = 'Desember';
    }
    _dateNow = '$date $parseMonth $year';
    return _dateNow;
  }

  @override
  void initState() {
    setState(() {
      getWidgetData();
      getUser();
      getDate();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xFF2E93E1),
        centerTitle: true,
        title: Text(
          'Daftar Tagihan Retribusi',
          style: TextStyle(
              fontFamily: 'poppins regluar',
              fontSize: 14.0,
              fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 23, right: 23, top: 15),
        child: FutureBuilder<List<Profile>>(
          future: futureProfile,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Profile> data = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            color: Color(0xFFE4EDFF),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(width: 2, color: Colors.white)),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 150,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'NPWRD',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF00237E),
                                            fontFamily: 'opensans regular'),
                                      ),
                                      Text(
                                        ': ',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF00237E),
                                            fontFamily: 'opensans regular'),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  data[index].npwrd,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF00237E),
                                      fontFamily: 'opensans regular'),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 150,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Nama Wajib Retribusi',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF00237E),
                                            fontFamily: 'opensans regular'),
                                      ),
                                      Text(
                                        ': ',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF00237E),
                                            fontFamily: 'opensans regular'),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Text(data[index].namaWr,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF00237E),
                                          fontFamily: 'opensans regular'),
                                      maxLines: 2),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 150,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Alamat',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF00237E),
                                            fontFamily: 'opensans regular'),
                                      ),
                                      Text(
                                        ': ',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF00237E),
                                            fontFamily: 'opensans regular'),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Text(data[index].alamat,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF00237E),
                                          fontFamily: 'opensans regular'),
                                      maxLines: 2),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 150,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'No Telp',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF00237E),
                                            fontFamily: 'opensans regular'),
                                      ),
                                      Text(
                                        ': ',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF00237E),
                                            fontFamily: 'opensans regular'),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Text(data[index].noTelp,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF00237E),
                                          fontFamily: 'opensans regular'),
                                      maxLines: 2),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 17),
                      Text(
                          'Berikut daftar objek retribusi yang harus anda bayar',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF828282),
                              fontFamily: 'poppins regular')),
                      GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: 1,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            // _priceVehicle.add(data[index].price);
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PreviewScanScreen(
                                        npwrd: data[index].npwrd,
                                        namaWajibRetribusi: data[index].namaWr,
                                        name: _name,
                                        username: _username,
                                        jenisRetribusi: _jenisRetribusi(index),
                                        dateNow: _dateNow,
                                      ),
                                    ),
                                  );
                                });
                              },
                              child: Container(
                                padding:
                                    EdgeInsets.only(top: 15.0, bottom: 20.0),
                                margin: EdgeInsets.only(top: 20.0, right: 10),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFEFE1),
                                  // border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Column(
                                  children: [
                                    Image.asset('images/pasar.png',
                                        width: 100.0, height: 75.0),
                                    Text('Pasar',
                                        style: TextStyle(
                                            fontFamily: 'roboto regular',
                                            color: Color(0xFF4F4F4F))),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ],
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 47),
                    Image.asset('images/connection_lost.png'),
                    Text(
                      'Jaringan Tidak Tersedia. Mohon Periksa Koneksi Anda',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              );
            }
            return Text('');
          },
        ),
      ),
    );
  }
}
