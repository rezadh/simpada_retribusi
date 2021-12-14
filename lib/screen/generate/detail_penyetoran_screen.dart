import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simpada/data/api/api_service.dart';
import 'package:simpada/data/model/simpada_retribusi.dart';

class DetailPenyetoranScreen extends StatefulWidget {
  DetailPenyetoranScreen({List<dynamic> ntrd, List<dynamic> nilai, List<
      dynamic> tanggal, this.billingCode, this.tanggalKadaluarsa})
      : this.ntrd = ntrd ?? [],
        this.tanggal = tanggal ?? [],
        this.nilai = nilai ?? [];
  final List<dynamic> ntrd;
  final List<dynamic> tanggal;
  final List<dynamic> nilai;
  final billingCode;
  final tanggalKadaluarsa;

  @override
  _DetailPenyetoranScreenState createState() => _DetailPenyetoranScreenState();
}

class _DetailPenyetoranScreenState extends State<DetailPenyetoranScreen> {
  Future<List<HistoryBill>> futureData;
  List<dynamic> _ntrd;
  List<dynamic> _nilai;
  List<dynamic> _tanggal;
  getWidget(){
    _ntrd = widget.ntrd;
    _tanggal = widget.tanggal;
    _nilai = widget.nilai;
    print(_ntrd);
  }
  @override
  void initState() {
    setState(() {
      getWidget();
      futureData = postRequestHistoryBill();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2F89E8),
        title: Text('Penyetoran'),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Card(
              margin: EdgeInsets.all(24),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('No. NTRD',style: TextStyle(fontWeight: FontWeight.w600),),
                      SizedBox(height: 23),
                      Container(
                        width: 110,
                        child: ListView.builder(
                          physics:
                          NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _ntrd.length,
                          itemBuilder: (context, index) {
                            // print(data[index].listBilingNTRD[index].ntrd);
                            return Container(
                              child: Column(
                                children: [
                                  Text(_ntrd[index], style: TextStyle(fontSize: 10),),
                                  SizedBox(height: 10),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Tanggal', style: TextStyle(fontWeight: FontWeight.w600)),
                      SizedBox(height: 23),
                      Container(
                        width: 110,
                        child: ListView.builder(
                          physics:
                          NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _tanggal.length,
                          itemBuilder: (context, index) {
                            // print(data[index].listBilingNTRD[index].ntrd);
                            return Container(
                              child: Column(
                                children: [
                                  Text(_tanggal[index], style: TextStyle(fontSize: 10),),
                                  SizedBox(height: 10),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Nilai', style: TextStyle(fontWeight: FontWeight.w600)),
                      SizedBox(height: 23),
                      Container(
                        width: 70,
                        child: ListView.builder(
                          physics:
                          NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _nilai.length,
                          itemBuilder: (context, index) {
                            // print(data[index].listBilingNTRD[index].ntrd);
                            return Container(
                              width: 70,
                              child: Column(
                                children: [
                                  Text(NumberFormat
                                  .simpleCurrency(
                              locale: 'id',
                                  decimalDigits:
                                  0)
                                  .format(int.parse(
                                  _nilai[
                                  index])), style: TextStyle(fontSize: 10),),
                                  SizedBox(height: 10),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            // List<HistoryBill> data = snapshot.data;
            // for(int i = 0; i <= data.length; i++){

            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Column(
            //       children: [
            //         Text('No. NTRD'),
            //       ],
            //     ),
            //     Column(
            //       children: [
            //         Text('Tanggal'),
            //       ],
            //     ),
            //     Column(
            //       children: [
            //         Text('Nilai'),
            //       ],
            //     ),
            //   ],
            // ),

          ),
        ),
      ),
    ),);
  }
}
