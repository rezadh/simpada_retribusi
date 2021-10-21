import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpada/data/api/api_service.dart';
import 'package:simpada/data/model/simpada_retribusi.dart';
import 'package:simpada/screen/generate/generate_code_screen.dart';

class GenerateScreen extends StatefulWidget {
  @override
  _GenerateScreenState createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  final checkBoxValue = CheckBoxModel();
  var checked = false;
  Future<List<ListNTRD>> futureData;
  final selectedIndexes = [];
  final selectedNTRD = [];
  final selectedNilai = [];
  List<bool> checkBoxValues;
  BillCode _billCode;

  _getDateFormat(String date) {
    DateTime dateParse = DateFormat('dd-MM-yy').parse(date);
    String dateFormat = DateFormat('dd-MM-yy').format(dateParse);
    return dateFormat;
  }

  void _checkData() {
    if (selectedNTRD.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FaIcon(
                    FontAwesomeIcons.timesCircle,
                    size: 90,
                    color: Colors.red,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Silahkan pilih NTRD terlebih dahulu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF252B42),
                        fontFamily: 'opensans regular'),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 11,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      _postBillCode();
    }
  }

  void _postBillCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime dateNow = DateTime.now();
    await postRequestBillCode(selectedNTRD).then((value) {
      if (value != null) {
        _billCode = value;
        var _billingCode = _billCode.billCode;
        var _tanggalKadaluarsa = _billCode.tanggalKadaluarsa;
        var clientTime = DateFormat('dd-MM-yyyy').format(dateNow);
        prefs.setString('billcode', _billingCode);
        prefs.setString('tanggal_bayar', clientTime);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GenerateCodeScreen(
              ntrd: selectedNTRD,
              nilai: selectedNilai,
              billingCode: _billingCode,
              tanggalKadaluarsa: _tanggalKadaluarsa,
            ),
          ),
        );
        return;
      }
    });
  }

  @override
  void initState() {
    setState(() {
      selectedNTRD.clear();
      selectedNilai.clear();
      futureData = postRequestNTRD();
      postRequestNTRD();
    });
    super.initState();
  }

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
        child: SingleChildScrollView(
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
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'opensans regular',
                    fontWeight: FontWeight.w600),
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
                  padding: EdgeInsets.only(left: 7, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9.0),
                    // border: Border.all(width: 2, color: Colors.white),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FutureBuilder<List<ListNTRD>>(
                            future: futureData,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<ListNTRD> data = snapshot.data;
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 19,
                                        ),
                                        Text(
                                          'No. NTRD',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'opensans regular',
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          width: 110,
                                          child: ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: data.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      data[index].ntrd,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'opensans regular',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xFF757F8C),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 10),
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
                                        SizedBox(height: 5),
                                        Container(
                                          width: 50,
                                          child: ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: data.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      _getDateFormat(data[index]
                                                              .tanggalPenagihan)
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'opensans regular',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xFF757F8C),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 10),
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
                                        SizedBox(height: 5),
                                        Container(
                                          width: 55,
                                          child: ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: data.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      NumberFormat
                                                              .simpleCurrency(
                                                                  locale: 'id',
                                                                  decimalDigits:
                                                                      0)
                                                          .format(int.parse(
                                                              data[index]
                                                                  .nominal)),
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'opensans regular',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xFF757F8C),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 10),
                                    Column(
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
                                              value: checked,
                                              onChanged: (value) {
                                                setState(() {
                                                  checked = value;
                                                  data.forEach((element) {
                                                    element.selected = value;
                                                  });
                                                  if (checked) {
                                                    for (int i = 0;
                                                        i < data.length;
                                                        i++) {
                                                      selectedNTRD
                                                          .add(data[i].ntrd);
                                                      selectedNilai
                                                          .add(data[i].nominal);
                                                    }
                                                  } else {
                                                    for (int i = 0;
                                                        i < data.length;
                                                        i++) {
                                                      selectedNTRD
                                                          .remove(data[i].ntrd);
                                                      selectedNilai.remove(
                                                          data[i].nominal);
                                                    }
                                                    selectedNilai.clear();
                                                    selectedNTRD.clear();
                                                  }
                                                  print(selectedNTRD);
                                                  print(checkBoxValue);
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 20,
                                          child: ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: data.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    SizedBox(
                                                      width: 16,
                                                      height: 16,
                                                      child: Transform.scale(
                                                        scale: 0.8,
                                                        child: Checkbox(
                                                          // value: userStatus[index],
                                                          // value: checkBoxValues[index],
                                                          value: data[index]
                                                              .selected,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              print(data[index]
                                                                  .selected);
                                                              data[index]
                                                                      .selected =
                                                                  value;
                                                              // if (!value) {
                                                              final check = data
                                                                  .every((element) =>
                                                                      element
                                                                          .selected);
                                                              checked = check;
                                                              print(checked);
                                                              // }

                                                              if (!data[index]
                                                                  .selected) {
                                                                selectedIndexes
                                                                    .remove(
                                                                        index);
                                                                selectedNTRD
                                                                    .remove(data[
                                                                            index]
                                                                        .ntrd);
                                                                selectedNilai
                                                                    .remove(data[
                                                                            index]
                                                                        .nominal);
                                                              } else {
                                                                selectedNTRD.add(
                                                                    data[index]
                                                                        .ntrd);
                                                                selectedNilai.add(
                                                                    data[index]
                                                                        .nominal);
                                                              }
                                                              selectedNTRD.sort(
                                                                  (a, b) => a
                                                                      .compareTo(
                                                                          b));
                                                              selectedNilai.sort(
                                                                  (a, b) => a
                                                                      .compareTo(
                                                                          b));
                                                              selectedIndexes
                                                                  .sort((a,
                                                                          b) =>
                                                                      a.compareTo(
                                                                          b));
                                                              print(
                                                                  selectedNTRD);
                                                              // print(
                                                              //     selectedIndexes);
                                                              // print(
                                                              //     selectedNTRD);
                                                              // print(
                                                              //     selectedNilai);
                                                              // checkBoxValue = value;
                                                              // print(checkBoxValue);
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                              } else {
                                return Text('Data Tidak ditemukan');
                              }
                              // else if(!snapshot.hasData){
                              //   return Text('Data Not Found');
                              // }
                              return Center(child: CircularProgressIndicator());
                            },
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
                    _checkData();
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
              SizedBox(height: 33),
            ],
          ),
        ),
      ),
    );
  }
}

class CheckBoxModel {
  bool selected;

  CheckBoxModel({this.selected = false});
}
