import 'daftar_produk_model.dart';

class Produk {
  String rc;
  String description;
  String npwrd;
  List<DaftarProdukAtas> daftarProdukAtas;

  Produk({this.rc, this.description, this.npwrd, this.daftarProdukAtas});

  Produk.fromJson(Map<String, dynamic> json) {
    rc = json['rc'];
    description = json['description'];
    npwrd = json['npwrd'];
    if (json['daftar_produk'] != null) {
      daftarProdukAtas = new List<DaftarProdukAtas>();
      json['daftar_produk'].forEach((v) {
        daftarProdukAtas.add(new DaftarProdukAtas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rc'] = this.rc;
    data['description'] = this.description;
    data['npwrd'] = this.npwrd;
    if (this.daftarProdukAtas != null) {
      data['daftar_produk'] =
          this.daftarProdukAtas.map((v) => v.toJson()).toList();
    }
    return data;
  }
}