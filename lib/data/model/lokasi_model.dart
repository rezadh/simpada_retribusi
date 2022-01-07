import 'daftar_tempat.dart';

class Lokasi {
  String nama;
  int id;
  List<DaftarTempat> daftarTempat;

  Lokasi({this.nama, this.id, this.daftarTempat});

  Lokasi.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    id = json['id'];
    if (json['daftar_tempat'] != null) {
      daftarTempat = <DaftarTempat>[];
      json['daftar_tempat'].forEach((v) {
        daftarTempat.add(new DaftarTempat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama'] = this.nama;
    data['id'] = this.id;
    if (this.daftarTempat != null) {
      data['daftar_tempat'] = this.daftarTempat.map((v) => v.toJson()).toList();
    }
    return data;
  }
}