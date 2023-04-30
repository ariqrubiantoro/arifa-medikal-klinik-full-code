class PemeriksaanAnggotaGerakModel {
  String? atasKanan;
  String? atasKiri;
  String? bawahKanan;
  String? bawahKiri;
  String? sembabOedemKanan;
  String? sembabOedemKiri;
  String? cacatKanan;
  String? cacatKiri;

  PemeriksaanAnggotaGerakModel({
    this.atasKanan,
    this.atasKiri,
    this.bawahKanan,
    this.bawahKiri,
    this.sembabOedemKanan,
    this.sembabOedemKiri,
    this.cacatKanan,
    this.cacatKiri,
  });

  factory PemeriksaanAnggotaGerakModel.fromJson(
      String? id, Map<String, dynamic> json) {
    return PemeriksaanAnggotaGerakModel(
      atasKanan: json['atas_kanan'],
      atasKiri: json['atas_kiri'],
      bawahKanan: json['bawah_kanan'],
      bawahKiri: json['bawah_kiri'],
      sembabOedemKanan: json['sembab_oedem_kanan'],
      sembabOedemKiri: json['sembab_oedem_kiri'],
      cacatKanan: json['cacat_kanan'],
      cacatKiri: json['cacat_kiri'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'atas_kanan': atasKanan,
      'atas_kiri': atasKiri,
      'bawah_kanan': bawahKanan,
      'bawah_kiri': bawahKiri,
      'sembab_oedem_kanan': sembabOedemKanan,
      'sembab_oedem_kiri': sembabOedemKiri,
      'cacat_kanan': cacatKanan,
      'cacat_kiri': cacatKiri,
    };
  }
}
