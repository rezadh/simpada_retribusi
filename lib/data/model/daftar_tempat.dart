import 'daftar_produk_model.dart';

class DaftarTempat {
  String nama;
  int id;
  List<DaftarProdukBawah> daftarProdukBawah;

  DaftarTempat({this.nama, this.id, this.daftarProdukBawah});

  DaftarTempat.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    id = json['id'];
    if (json['daftar_produk'] != null) {
      daftarProdukBawah = <DaftarProdukBawah>[];
      json['daftar_produk'].forEach((v) {
        daftarProdukBawah.add(new DaftarProdukBawah.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama'] = this.nama;
    data['id'] = this.id;
    if (this.daftarProdukBawah != null) {
      data['daftar_produk'] =
          this.daftarProdukBawah.map((v) => v.toJson()).toList();
    }
    return data;
  }
}