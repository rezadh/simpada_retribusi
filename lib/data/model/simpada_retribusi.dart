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
  List<ObjekRetribusi> objekRetribusi;

  CollectTax(
      {this.rc,
      this.description,
      this.npwrd,
      this.tanggalPenagihan,
      this.nominal,
      this.periode,
      this.jumlahBayar,
      this.satuanPeriode,
      this.ntrd,
      this.objekRetribusi});

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
    if (object['objek_retribusi'] != null) {
      objekRetribusi = [];
      object['objek_retribusi'].forEach((v) {
        objekRetribusi.add(new ObjekRetribusi.fromJson(v));
      });
    }
  }
}

class ObjekRetribusi {
  String namaLokasi;
  String namaRetribusi;
  String namaTempat;
  String nominal;
  String periode;
  String jumlahBayarMaju;

  ObjekRetribusi(
      {this.namaLokasi,
      this.namaRetribusi,
      this.namaTempat,
      this.nominal,
      this.periode,
      this.jumlahBayarMaju});

  ObjekRetribusi.fromJson(Map<String, dynamic> json) {
    namaLokasi = json['nama_lokasi'];
    namaRetribusi = json['nama_retribusi'];
    namaTempat = json['nama_tempat'];
    nominal = json['nominal'];
    periode = json['periode'];
    jumlahBayarMaju = json['jumlah_bayar_maju'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama_lokasi'] = this.namaLokasi;
    data['nama_retribusi'] = this.namaRetribusi;
    data['nama_tempat'] = this.namaTempat;
    data['nominal'] = this.nominal;
    data['periode'] = this.periode;
    data['jumlah_bayar_maju'] = this.jumlahBayarMaju;
    return data;
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
  var status;
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
      this.selected,
      this.status});

  ListNTRD.fromJson(Map<String, dynamic> object) {
    rc = object['rc'];
    description = object['description'];
    tanggalPenagihan = object['tgl_pungut'];
    nominal = object['nominal'];
    periode = object['periode'];
    jumlahBayar = object['jumlah_bayar_maju'];
    satuanPeriode = object['satuan_periode'];
    ntrd = object['ntrd'];
    status = object['status'];
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
  List<DaftarWr> daftarWr;
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

  Profile.fromJson(Map<String, dynamic> object) {
    rc = object['rc'];
    description = object['description'];
    daftarWr = object['daftar_wr'];
    npwrd = object['npwrd'];
    namaWr = object['nama_wr'];
    alamat = object['alamat'];
    noTelp = object['tlpn'];
  }
}
class DaftarWr {
  String npwrd;
  String namaWr;
  String alamat;
  String tlpn;

  DaftarWr({this.npwrd, this.namaWr, this.alamat, this.tlpn});

  DaftarWr.fromJson(Map<String, dynamic> json) {
    npwrd = json['npwrd'];
    namaWr = json['nama_wr'];
    alamat = json['alamat'];
    tlpn = json['tlpn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['npwrd'] = this.npwrd;
    data['nama_wr'] = this.namaWr;
    data['alamat'] = this.alamat;
    data['tlpn'] = this.tlpn;
    return data;
  }
}
class HistoryBill {
  String tglKedaluwarsa;
  String status;
  String nominal;
  String tglDibentuk;
  String tglBayar;
  String kodeBilling;
  List<ListBillingNTRD> listBilingNTRD;

  HistoryBill(
      {this.tglKedaluwarsa,
      this.status,
      this.nominal,
      this.tglDibentuk,
      this.tglBayar,
      this.kodeBilling,
      this.listBilingNTRD});

  HistoryBill.fromJson(Map<String, dynamic> object) {
    tglKedaluwarsa = object['tgl_kadaluarsa'];
    status = object['status'].toString();
    nominal = object['nominal_tagihan'];
    tglDibentuk = object['tgl_dibentuk'];
    tglBayar = object['tgl_bayar'];
    kodeBilling = object['kode_billing'];
    if (object['list_ntrd'] != null) {
      listBilingNTRD = new List<ListBillingNTRD>();
      object['list_ntrd'].forEach((v) {
        listBilingNTRD.add(new ListBillingNTRD.fromJson(v));
      });
    }
  }
}

class ListBillingNTRD {
  String ntrd;
  String tglCollect;
  String nominalTagihan;

  ListBillingNTRD({this.ntrd, this.tglCollect, this.nominalTagihan});

  ListBillingNTRD.fromJson(Map<String, dynamic> json) {
    ntrd = json['ntrd'];
    tglCollect = json['tgl_collect'];
    nominalTagihan = json['nominal_tagihan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ntrd'] = this.ntrd;
    data['tgl_collect'] = this.tglCollect;
    data['nominal_tagihan'] = this.nominalTagihan;
    return data;
  }
}

// class ListBillingNTRD{
//   String ntrd;
//   String tanggal;
//   String nominal;
//   ListBillingNTRD({this.ntrd, this.tanggal, this.nominal});
//   ListBillingNTRD.fromJson(Map<String, dynamic> object){
//     ntrd = object['ntrd'];
//     tanggal = object['tgl_collect'];
//     nominal = object['nominal_tagihan'];
//   }
// }
// class Produk {
//   String rc;
//   String description;
//   String npwrd;
//   // List<String> daftarProduk;
//   String namaProduk;
//   String type;
//   int tarif;
//   String satuanPeriode;
//   Produk({this.rc, this.description, this.npwrd});
//   Produk.fromJson(Map<String, dynamic> object){
//     rc = object['rc'];
//     description = object['description'];
//     // daftarProduk = object['daftar_produk'];
//     npwrd = object['npwrd'];
//     namaProduk = object['nama_produk'];
//     type = object['type'];
//     tarif = object['tarif'];
//     satuanPeriode = object['satuan_periode'];
//   }
// }
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

class DaftarProdukAtas {
  Lokasi lokasi;

  DaftarProdukAtas({this.lokasi});

  DaftarProdukAtas.fromJson(Map<String, dynamic> json) {
    lokasi =
        json['lokasi'] != null ? new Lokasi.fromJson(json['lokasi']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lokasi != null) {
      data['lokasi'] = this.lokasi.toJson();
    }
    return data;
  }
}

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

class DaftarProdukBawah {
  int idProduk;
  String namaProduk;
  String type;
  int tarif;
  String satuanPeriode;
  String terakhirBayar;
  String periodeTerakhirBayar;

  DaftarProdukBawah(
      {this.idProduk,
      this.namaProduk,
      this.type,
      this.tarif,
      this.satuanPeriode,
      this.terakhirBayar,
      this.periodeTerakhirBayar});

  DaftarProdukBawah.fromJson(Map<String, dynamic> json) {
    idProduk = json['id_produk'];
    namaProduk = json['nama_produk'];
    type = json['type'];
    tarif = json['tarif'];
    satuanPeriode = json['satuan_periode'];
    terakhirBayar = json['terakhir_pungut'];
    periodeTerakhirBayar = json['periode_terakhir_bayar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama_produk'] = this.namaProduk;
    data['type'] = this.type;
    data['tarif'] = this.tarif;
    data['satuan_periode'] = this.satuanPeriode;
    return data;
  }
}

class LastPayment {
  String tanggalPenagihan;
  String nominal;
  String periode;
  String satuanPeriode;
  String ntrd;
  String status;
  String npwrd;

  LastPayment({
    this.ntrd,
    this.tanggalPenagihan,
    this.nominal,
    this.periode,
    this.satuanPeriode,
    this.status,
    this.npwrd
  });

  LastPayment.fromJson(Map<String, dynamic> object) {
    tanggalPenagihan = object['tgl_pungut'];
    nominal = object['nominal'];
    periode = object['periode_bayar'];
    satuanPeriode = object['satuan_periode'];
    ntrd = object['ntrd'];
    status = object['status'].toString();
    npwrd = object['npwrd'].toString();
  }
}
