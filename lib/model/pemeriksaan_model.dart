class PemeriksaanModel {
  String? pemeriksaanFisik;
  String? pemeriksaanMata;
  String? pemeriksaanGigiMulut;
  String? pemeriksaanAudioMetri;
  String? pemeriksaanSpirometri;
  String? pemeriksaanTreadmill;
  String? pemeriksaanLaboratorium;
  String? pemeriksaanXrayJantung;
  String? paru;

  PemeriksaanModel({
    this.pemeriksaanFisik,
    this.pemeriksaanMata,
    this.pemeriksaanGigiMulut,
    this.pemeriksaanAudioMetri,
    this.pemeriksaanSpirometri,
    this.pemeriksaanTreadmill,
    this.pemeriksaanLaboratorium,
    this.pemeriksaanXrayJantung,
    this.paru,
  });

  factory PemeriksaanModel.fromJson(String? id, Map<String, dynamic> json) {
    return PemeriksaanModel(
      pemeriksaanFisik: json['pemeriksaan_fisik'],
      pemeriksaanMata: json['pemeriksaan_mata'],
      pemeriksaanGigiMulut: json['pemeriksaan_gigi_mulut'],
      pemeriksaanAudioMetri: json['pemeriksaan_audio_metri'],
      pemeriksaanSpirometri: json['pemeriksaan_spirometri'],
      pemeriksaanTreadmill: json['pemeriksaan_treadmill'],
      pemeriksaanLaboratorium: json['peemriksaan_laboratorium'],
      pemeriksaanXrayJantung: json['pemeriksaan_xray_jantung'],
      paru: json['paru'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'pemeriksaan_fisik': pemeriksaanFisik,
      'pemeriksaan_mata': pemeriksaanMata,
      'pemeriksaan_gigi_mulut': pemeriksaanGigiMulut,
      'pemeriksaan_audio_metri': pemeriksaanAudioMetri,
      'pemeriksaan_spirometri': pemeriksaanSpirometri,
      'pemeriksaan_treadmill': pemeriksaanTreadmill,
      'peemriksaan_laboratorium': pemeriksaanLaboratorium,
      'pemeriksaan_xray_jantung': pemeriksaanXrayJantung,
      'paru': paru,
    };
  }
}
