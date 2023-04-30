class KesimpulanDerajatKesehatanModel {
  String? ditemukanKelainanMedis;
  String? ditemukanKelainanYangTidakSerius;
  String? ditemukanKelainanResikoKesehatanRendah;
  String? ditemukanKelainanResikoKesehatanSedang;
  String? ditemukanKelainanResikoKesehatanTinggi;
  String? ditemukanKelainanMenyebabkanKeterbatasan;
  String? tidakDapatBekerja;

  KesimpulanDerajatKesehatanModel(
      {this.ditemukanKelainanMedis,
      this.ditemukanKelainanYangTidakSerius,
      this.ditemukanKelainanResikoKesehatanRendah,
      this.ditemukanKelainanResikoKesehatanSedang,
      this.ditemukanKelainanResikoKesehatanTinggi,
      this.ditemukanKelainanMenyebabkanKeterbatasan,
      this.tidakDapatBekerja});

  factory KesimpulanDerajatKesehatanModel.fromJson(
      String? id, Map<String, dynamic> json) {
    return KesimpulanDerajatKesehatanModel(
      ditemukanKelainanMedis: json['ditemukanKelainanMedis'],
      ditemukanKelainanYangTidakSerius:
          json['ditemukanKelainanYangTidakSerius'],
      ditemukanKelainanResikoKesehatanRendah:
          json['ditemukanKelainanResikoKesehatanRendah'],
      ditemukanKelainanResikoKesehatanSedang:
          json['ditemukanKelainanResikoKesehatanSedang'],
      ditemukanKelainanResikoKesehatanTinggi:
          json['ditemukanKelainanResikoKesehatanTinggi'],
      ditemukanKelainanMenyebabkanKeterbatasan:
          json['ditemukanKelainanMenyebabkanKeterbatasan'],
      tidakDapatBekerja: json['tidakDapatBekerja'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ditemukanKelainanMedis': ditemukanKelainanMedis,
      'ditemukanKelainanYangTidakSerius': ditemukanKelainanYangTidakSerius,
      'ditemukanKelainanResikoKesehatanRendah':
          ditemukanKelainanResikoKesehatanRendah,
      'ditemukanKelainanResikoKesehatanSedang':
          ditemukanKelainanResikoKesehatanSedang,
      'ditemukanKelainanResikoKesehatanTinggi':
          ditemukanKelainanResikoKesehatanTinggi,
      'ditemukanKelainanMenyebabkanKeterbatasan':
          ditemukanKelainanMenyebabkanKeterbatasan,
      'tidakDapatBekerja': tidakDapatBekerja,
    };
  }
}
