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