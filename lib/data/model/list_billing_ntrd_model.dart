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