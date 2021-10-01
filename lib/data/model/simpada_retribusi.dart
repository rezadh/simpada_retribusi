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

  BillCode({this.rc, this.description, this.daftarNTRD, this.billCode});

  BillCode.fromJson(Map<String, dynamic> object) {
    rc = object['rc'];
    daftarNTRD = object['daftar_ntrd'].cast<String>();
    description = object['description'];
    billCode = object['billing_code'];
    tanggalKadaluarsa = object['tgl_kadaluarsa'];
  }
}
