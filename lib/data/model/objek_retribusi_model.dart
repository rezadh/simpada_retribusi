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
