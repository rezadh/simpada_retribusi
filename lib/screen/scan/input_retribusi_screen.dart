import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:simpada/screen/scan/detail_retribusi_screen.dart';

class InputRetribusiScreen extends StatefulWidget {
  @override
  _InputRetribusiScreenState createState() => _InputRetribusiScreenState();
}

class _InputRetribusiScreenState extends State<InputRetribusiScreen> {
  TextEditingController mobilController = TextEditingController();
  TextEditingController motorController = TextEditingController();
  TextEditingController totalController = TextEditingController();

  String _valRetribusi;
  String _valLokasi;
  String _valPenanggungJawab;
  String _valTanggal;
  String _valBulan;

  List _tanggal = ['01', '02', '03', '04'];
  List _bulan = ['01', '02', '03', '04'];
  List _retribusi = ["Retribusi Parkir", "Retribusi Pasar"];
  List _lokasiRetribusi = ['Parkir RS Bungsu', 'Tanah Abang'];
  List _penanggungJawab = ["Nopi Nurhayati", "Reza Dwi"];

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
                      fontSize: 14),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 23,
                right: 24,
                bottom: 50,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jenis Retribusi',
                      style: TextStyle(
                        fontFamily: 'poppins regular',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 17),
                      decoration: BoxDecoration(
                          color: Color(0xFFF9F9F9),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Color(0xFFE5E5E5))),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          hint: Text("Jenis Retribusi"),
                          value: _valRetribusi,
                          items: _retribusi.map((value) {
                            return DropdownMenuItem(
                              child: Text(
                                value,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'poppins regular',
                                    color: Color(0xFF333333)),
                              ),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _valRetribusi = value.toString();
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Lokasi Retribusi',
                      style: TextStyle(
                        fontFamily: 'poppins regular',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 17),
                      decoration: BoxDecoration(
                          color: Color(0xFFF9F9F9),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Color(0xFFE5E5E5))),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          hint: Text("Lokasi Retribusi"),
                          value: _valLokasi,
                          items: _lokasiRetribusi.map((value) {
                            return DropdownMenuItem(
                              child: Text(
                                value,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'poppins regular',
                                    color: Color(0xFF333333)),
                              ),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _valLokasi = value.toString();
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Penanggung Jawab',
                      style: TextStyle(
                        fontFamily: 'poppins regular',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 17),
                      decoration: BoxDecoration(
                          color: Color(0xFFF9F9F9),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Color(0xFFE5E5E5))),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          hint: Text("Penanggung Jawab"),
                          value: _valPenanggungJawab,
                          items: _penanggungJawab.map((value) {
                            return DropdownMenuItem(
                              child: Text(
                                value,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'poppins regular',
                                    color: Color(0xFF333333)),
                              ),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _valPenanggungJawab = value.toString();
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Tanggal Penagihan',
                      style: TextStyle(
                        fontFamily: 'poppins regular',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 90,
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 17),
                          decoration: BoxDecoration(
                              color: Color(0xFFF9F9F9),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Color(0xFFE5E5E5))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Text("Tgl"),
                              value: _valRetribusi,
                              items: _tanggal.map((value) {
                                return DropdownMenuItem(
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'poppins regular',
                                        color: Color(0xFF333333)),
                                  ),
                                  value: value,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _valTanggal = value.toString();
                                });
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: 212,
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 17),
                          decoration: BoxDecoration(
                              color: Color(0xFFF9F9F9),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Color(0xFFE5E5E5))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: true,
                              hint: Text("Bulan"),
                              value: _valRetribusi,
                              items: _tanggal.map((value) {
                                return DropdownMenuItem(
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'poppins regular',
                                        color: Color(0xFF333333)),
                                  ),
                                  value: value,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _valTanggal = value.toString();
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
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
                                        borderSide: BorderSide(
                                            color: Color(0xFFE7E7E7))),
                                    filled: true,
                                    fillColor: Color(0xFFF9F9F9),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
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
                                        borderSide: BorderSide(
                                            color: Color(0xFFE7E7E7))),
                                    filled: true,
                                    fillColor: Color(0xFFF9F9F9),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
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
                          if (value.isEmpty) {
                            return 'Tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 28,
                    ),
                    DottedBorder(
                      borderType: BorderType.RRect,
                      color: Color(0xFFFFE562),
                      strokeWidth: 2,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        width: 313,
                        height: 46,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              // color: Colors.white,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Color(0xFFF2C94C),
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  width: 2,
                                  color: Color(0xFFFFF5D8),
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Tambah Tagihan Lainnya',
                              style: TextStyle(
                                  color: Color(0xFFF2994A),
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'poppins regular',
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      radius: Radius.circular(30.0),
                      padding: EdgeInsets.all(6),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
            fontFamily: 'poppins regular',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFF333333),
          ),
        ),
      );
}
