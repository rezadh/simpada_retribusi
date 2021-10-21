class Registration {
  String rc;
  String description;
  String apiKey;

  Registration({this.rc, this.description, this.apiKey});

  Registration.fromJson(Map<String, dynamic> object) {
    rc = object['rc'];
    description = object['description'];
    apiKey = object['apiKey'];
  }
}

class GenerateToken {
  String rc;
  String description;
  String accessToken;

  GenerateToken({this.rc, this.description, this.accessToken});

  GenerateToken.fromJson(Map<String, dynamic> object) {
    rc = object['rc'];
    description = object['description'];
    accessToken = object['access_token'];
  }
}

class Login {
  String rc;
  String description;
  String tanggal;
  String name;

  Login({this.rc, this.description, this.tanggal, this.name});

  Login.fromJson(Map<String, dynamic> object) {
    rc = object['rc'];
    description = object['description'];
    tanggal = object['tgl'];
    name = object['name'];
  }
}

class CollectTax {
  String rc;
  String description;
  String npwrd;
  String tanggalPenagihan;
  String nominal;
  String periode;
  String jumlahBayar;
  String satuanPeriode;
  String ntrd;

  CollectTax(
      {this.rc,
      this.description,
      this.npwrd,
      this.tanggalPenagihan,
      this.nominal,
      this.periode,
      this.jumlahBayar,
      this.satuanPeriode,
      this.ntrd});

  CollectTax.fromJson(Map<String, dynamic> object) {
    rc = object['rc'];
    description = object['description'];
    npwrd = object['npwrd'];
    tanggalPenagihan = object['tgl_pungut'];
    nominal = object['nominal'];
    periode = object['periode'];
    jumlahBayar = object['jumlah_bayar_maju'];
    satuanPeriode = object['satuan_periode'];
    ntrd = object['ntrd'];
  }
}

class ListNTRD {
  String rc;
  String description;
  String tanggalPenagihan;
  String nominal;
  String periode;
  String jumlahBayar;
  String satuanPeriode;
  String ntrd;
  bool selected = false;

  ListNTRD(
      {this.ntrd,
      this.tanggalPenagihan,
      this.nominal,
      this.periode,
      this.jumlahBayar,
      this.satuanPeriode,
      this.description,
      this.rc,
      this.selected});

  ListNTRD.fromJson(Map<String, dynamic> object) {
    rc = object['rc'];
    description = object['description'];
    tanggalPenagihan = object['tgl_pungut'];
    nominal = object['nominal'];
    periode = object['periode'];
    jumlahBayar = object['jumlah_bayar_maju'];
    satuanPeriode = object['satuan_periode'];
    ntrd = object['ntrd'];
  }
}

class BillCode {
  String rc;
  String description;
  List<String> daftarNTRD;
  String billCode;
  String tanggalKadaluarsa;

  BillCode(
      {this.rc,
      this.description,
      this.daftarNTRD,
      this.billCode,
      this.tanggalKadaluarsa});

  BillCode.fromJson(Map<String, dynamic> object) {
    rc = object['rc'];
    daftarNTRD = object['daftar_ntrd'].cast<String>();
    description = object['description'];
    billCode = object['billing_code'];
    tanggalKadaluarsa = object['tgl_kadaluarsa'];
  }
}

class Profile {
  String rc;
  String description;
  List<String> daftarWr;
  String npwrd;
  String namaWr;
  String alamat;
  String noTelp;

  Profile(
      {this.rc,
      this.description,
      this.daftarWr,
      this.npwrd,
      this.namaWr,
      this.alamat,
      this.noTelp});
  Profile.fromJson(Map<String, dynamic> object){
    rc = object['rc'];
    description = object['description'];
    daftarWr = object['daftar_wr'];
    npwrd = object['npwrd'];
    namaWr = object['nama_wr'];
    alamat = object['alamat'];
    noTelp = object['tlpn'];
  }
}

class HistoryBill {
  String tglKedaluwarsa;
  String status;
  String nominal;
  HistoryBill({this.tglKedaluwarsa, this.status, this.nominal});
  HistoryBill.fromJson(Map<String, dynamic> object){
    tglKedaluwarsa = object['tgl_kadaluarsa'];
    status = object['status'].toString();
    nominal = object['nominal'];
  }
}
class Produk {
  String rc;
  String description;
  String npwrd;
  // List<String> daftarProduk;
  String namaProduk;
  String type;
  int tarif;
  String satuanPeriode;
  Produk({this.rc, this.description, this.npwrd});
  Produk.fromJson(Map<String, dynamic> object){
    rc = object['rc'];
    description = object['description'];
    // daftarProduk = object['daftar_produk'];
    npwrd = object['npwrd'];
    namaProduk = object['nama_produk'];
    type = object['type'];
    tarif = object['tarif'];
    satuanPeriode = object['satuan_periode'];
  }
}
class LastPayment {
  String tanggalPenagihan;
  String nominal;
  String periode;
  String satuanPeriode;
  String ntrd;

  LastPayment(
      {this.ntrd,
        this.tanggalPenagihan,
        this.nominal,
        this.periode,
        this.satuanPeriode,
      });

  LastPayment.fromJson(Map<String, dynamic> object) {
    tanggalPenagihan = object['tgl_pungut'];
    nominal = object['nominal'];
    periode = object['periode'];
    satuanPeriode = object['satuan_periode'];
    ntrd = object['ntrd'];
  }
}
// class Produk {
//   String rc;
//   String description;
//   String npwrd;
//   List<DaftarProdukFirst> daftarProduk;
//
//   Produk({this.rc, this.description, this.npwrd, this.daftarProduk});
//
//   Produk.fromJson(Map<String, dynamic> json) {
//     rc = json['rc'];
//     description = json['description'];
//     npwrd = json['npwrd'];
//     if (json['daftar_produk'] != null) {
//       daftarProduk = new List<DaftarProdukFirst>();
//       json['daftar_produk'].forEach((v) {
//         daftarProduk.add(new DaftarProdukFirst.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['rc'] = this.rc;
//     data['description'] = this.description;
//     data['npwrd'] = this.npwrd;
//     if (this.daftarProduk != null) {
//       data['daftar_produk'] = this.daftarProduk.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class DaftarProdukFirst {
//   Lokasi lokasi;
//
//   DaftarProdukFirst({this.lokasi});
//
//   DaftarProdukFirst.fromJson(Map<String, dynamic> json) {
//     lokasi =
//     json['lokasi'] != null ? new Lokasi.fromJson(json['lokasi']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.lokasi != null) {
//       data['lokasi'] = this.lokasi.toJson();
//     }
//     return data;
//   }
// }
//
// class Lokasi {
//   String nama;
//   int id;
//   List<DaftarTempat> daftarTempat;
//
//   Lokasi({this.nama, this.id, this.daftarTempat});
//
//   Lokasi.fromJson(Map<String, dynamic> json) {
//     nama = json['nama'];
//     id = json['id'];
//     if (json['daftar_tempat'] != null) {
//       daftarTempat = new List<DaftarTempat>();
//       json['daftar_tempat'].forEach((v) {
//         daftarTempat.add(new DaftarTempat.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['nama'] = this.nama;
//     data['id'] = this.id;
//     if (this.daftarTempat != null) {
//       data['daftar_tempat'] = this.daftarTempat.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class DaftarTempat {
//   String nama;
//   int id;
//   List<DaftarProduk> daftarProduk;
//
//   DaftarTempat({this.nama, this.id, this.daftarProduk});
//
//   DaftarTempat.fromJson(Map<String, dynamic> json) {
//     nama = json['nama'];
//     id = json['id'];
//     if (json['daftar_produk'] != null) {
//       daftarProduk = new List<DaftarProduk>();
//       json['daftar_produk'].forEach((v) {
//         daftarProduk.add(new DaftarProduk.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['nama'] = this.nama;
//     data['id'] = this.id;
//     if (this.daftarProduk != null) {
//       data['daftar_produk'] = this.daftarProduk.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class DaftarProduk {
//   String namaProduk;
//   String type;
//   int tarif;
//   String satuanPeriode;
//
//   DaftarProduk({this.namaProduk, this.type, this.tarif, this.satuanPeriode});
//
//   DaftarProduk.fromJson(Map<String, dynamic> json) {
//     namaProduk = json['nama_produk'];
//     type = json['type'];
//     tarif = json['tarif'];
//     satuanPeriode = json['satuan_periode'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['nama_produk'] = this.namaProduk;
//     data['type'] = this.type;
//     data['tarif'] = this.tarif;
//     data['satuan_periode'] = this.satuanPeriode;
//     return data;
//   }
// }