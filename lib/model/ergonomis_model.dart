class ErgonomisModel {
  String? gerakanBerulang;
  String? angkatBerat;
  String? dudukLama;
  String? berdiriLama;
  String? posisiTubuh;
  String? pencahayaanTidakSesuai;
  String? bekerjaDenganLayar;
  String? lainLain;

  ErgonomisModel({
    this.gerakanBerulang,
    this.angkatBerat,
    this.dudukLama,
    this.berdiriLama,
    this.posisiTubuh,
    this.pencahayaanTidakSesuai,
    this.bekerjaDenganLayar,
    this.lainLain,
  });

  factory ErgonomisModel.fromJson(String idPasiend, Map<String, dynamic> json) {
    return ErgonomisModel(
      gerakanBerulang: json['gerakan_berulang'],
      angkatBerat: json['angkat_berat'],
      dudukLama: json['duduk_lama'],
      berdiriLama: json['berdiri_lama'],
      posisiTubuh: json['posisi_tubuh'],
      pencahayaanTidakSesuai: json['pencahayaan_tidak_sesuai'],
      bekerjaDenganLayar: json['bekerja_dengan_layar'],
      lainLain: json['lain_lain'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gerakan_berulang': gerakanBerulang,
      'angkat_berat': angkatBerat,
      'duduk_lama': dudukLama,
      'berdiri_lama': berdiriLama,
      'posisi_tubuh': posisiTubuh,
      'pencahayaan_tidak_sesuai': pencahayaanTidakSesuai,
      'bekerja_dengan_layar': bekerjaDenganLayar,
      'lain_lain': lainLain,
    };
  }
}
