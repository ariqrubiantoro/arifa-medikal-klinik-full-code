class PenyakitTerdahuluModel {
  String? id;
  String? darahTinggi;
  String? paru;
  String? asamLambung;
  String? alergi;
  String? riwayatOperasi;
  String? riwayatKecelakaan;
  String? riwayatRawatRs;
  String? hepatitis;
  String? kencingManis;
  String? patahTulang;

  PenyakitTerdahuluModel({
    this.id,
    this.darahTinggi,
    this.paru,
    this.asamLambung,
    this.alergi,
    this.riwayatOperasi,
    this.riwayatKecelakaan,
    this.riwayatRawatRs,
    this.hepatitis,
    this.kencingManis,
    this.patahTulang,
  });

  factory PenyakitTerdahuluModel.fromJson(
      String? id, Map<String, dynamic> json) {
    return PenyakitTerdahuluModel(
      id: id,
      darahTinggi: json['darahTinggi'],
      paru: json['paru'],
      asamLambung: json['asamLambung'],
      alergi: json['alergi'],
      riwayatOperasi: json['riwayatOperasi'],
      riwayatKecelakaan: json['riwayatKecelakaan'],
      riwayatRawatRs: json['riwayatRawatRs'],
      hepatitis: json['hepatitis'],
      kencingManis: json['kencingManis'],
      patahTulang: json['patahTulang'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'darahTinggi': darahTinggi,
      'paru': paru,
      'asamLambung': asamLambung,
      'alergi': alergi,
      'riwayatOperasi': riwayatOperasi,
      'riwayatKecelakaan': riwayatKecelakaan,
      'riwayatRawatRs': riwayatRawatRs,
      'hepatitis': hepatitis,
      'kencingManis': kencingManis,
      'patahTulang': patahTulang,
    };
  }
}
