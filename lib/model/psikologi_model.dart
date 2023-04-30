class PsikologiModel {
  String? bebanKerja;
  String? pekerjaanTidakSesuai;
  String? ketidakjelasanTugas;
  String? hamabatanJenjangKarir;
  String? shift;
  String? konflikRekanKerja;
  String? konflikKeluarga;
  String? lainLain;

  PsikologiModel({
    this.bebanKerja,
    this.pekerjaanTidakSesuai,
    this.ketidakjelasanTugas,
    this.hamabatanJenjangKarir,
    this.shift,
    this.konflikRekanKerja,
    this.konflikKeluarga,
    this.lainLain,
  });

  factory PsikologiModel.fromJson(String idPasien, Map<String, dynamic> json) {
    return PsikologiModel(
      bebanKerja: json['beban_kerja'],
      pekerjaanTidakSesuai: json['pekerjaan_tidak_sesuai'],
      ketidakjelasanTugas: json['ketidakjelasan_tugas'],
      hamabatanJenjangKarir: json['hamabatan_jenjang_karir'],
      shift: json['shift'],
      konflikRekanKerja: json['konflik_rekan_kerja'],
      konflikKeluarga: json['konflik_keluarga'],
      lainLain: json['lain_lain'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'beban_kerja': bebanKerja,
      'pekerjaan_tidak_sesuai': pekerjaanTidakSesuai,
      'ketidakjelasan_tugas': ketidakjelasanTugas,
      'hamabatan_jenjang_karir': hamabatanJenjangKarir,
      'shift': shift,
      'konflik_rekan_kerja': konflikRekanKerja,
      'konflik_keluarga': konflikKeluarga,
      'lain_lain': lainLain,
    };
  }
}
