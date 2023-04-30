class PemeriksaanUmumModel {
  String? tinggiBadan;
  String? beratBadan;
  String? beratBadanIdeal;
  String? imt;
  String? lingkarPerut;
  String? tekananDarah;
  String? denyutNadi;
  String? pernapasan;
  String? suhu;

  PemeriksaanUmumModel({
    this.tinggiBadan,
    this.beratBadan,
    this.beratBadanIdeal,
    this.imt,
    this.lingkarPerut,
    this.tekananDarah,
    this.denyutNadi,
    this.pernapasan,
    this.suhu,
  });

  factory PemeriksaanUmumModel.fromJson(String? id, Map<String, dynamic> json) {
    return PemeriksaanUmumModel(
      tinggiBadan: json['tinggi_badan'],
      beratBadan: json['berat_badan'],
      beratBadanIdeal: json['berat_badan_ideal'],
      imt: json['imt'],
      lingkarPerut: json['lingkar_perut'],
      tekananDarah: json['tekanan_darah'],
      denyutNadi: json['denyut_nadi'],
      pernapasan: json['pernapasan'],
      suhu: json['suhu'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tinggi_badan': tinggiBadan,
      'berat_badan': beratBadan,
      'berat_badan_ideal': beratBadanIdeal,
      'imt': imt,
      'lingkar_perut': lingkarPerut,
      'tekanan_darah': tekananDarah,
      'denyut_nadi': denyutNadi,
      'pernapasan': pernapasan,
      'suhu': suhu,
    };
  }
}
