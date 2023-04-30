class PemeriksaanRonggaDadaModel {
  JantungModel? jantung;
  ParuModel? paru;

  PemeriksaanRonggaDadaModel({this.jantung, this.paru});

  factory PemeriksaanRonggaDadaModel.fromJson(
      String? id, Map<String, dynamic> json) {
    return PemeriksaanRonggaDadaModel(
      jantung: json['jantung'] != null
          ? JantungModel.fromJson(json['jantung'])
          : null,
      paru: json['paru'] != null ? ParuModel.fromJson(json['paru']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jantung': jantung?.toJson(),
      'paru': paru?.toJson(),
    };
  }
}

class JantungModel {
  String? batasBatasJantung;
  String? auskultasi;
  String? iktusKordis;
  String? bunyiJantung;
  String? bunyuNafas;
  String? lainLain;

  JantungModel({
    this.batasBatasJantung,
    this.auskultasi,
    this.iktusKordis,
    this.bunyiJantung,
    this.bunyuNafas,
    this.lainLain,
  });

  JantungModel.fromJson(Map<String, dynamic> json) {
    batasBatasJantung = json['batasBatasJantung'];
    auskultasi = json['auskultasi'];
    iktusKordis = json['iktusKordis'];
    bunyiJantung = json['bunyiJantung'];
    bunyuNafas = json['bunyuNafas'];
    lainLain = json['lainLain'];
  }

  Map<String, dynamic> toJson() {
    return {
      'batasBatasJantung': batasBatasJantung,
      'auskultasi': auskultasi,
      'iktusKordis': iktusKordis,
      'bunyiJantung': bunyiJantung,
      'bunyuNafas': bunyuNafas,
      'lainLain': lainLain,
    };
  }
}

class ParuModel {
  String? inspeksiKanan;
  String? inspeksiKiri;
  String? palpasiKanan;
  String? palpasiKiri;
  String? perkusiKanan;
  String? perkusiKiri;
  String? auskultasiKanan;
  String? auskultasiKiri;

  ParuModel({
    this.inspeksiKanan,
    this.inspeksiKiri,
    this.palpasiKanan,
    this.palpasiKiri,
    this.perkusiKanan,
    this.perkusiKiri,
    this.auskultasiKanan,
    this.auskultasiKiri,
  });

  ParuModel.fromJson(Map<String, dynamic> json) {
    inspeksiKanan = json['inspeksiKanan'];
    inspeksiKiri = json['inspeksiKiri'];
    palpasiKanan = json['palpasiKanan'];
    palpasiKiri = json['palpasiKiri'];
    perkusiKanan = json['perkusiKanan'];
    perkusiKiri = json['perkusiKiri'];
    auskultasiKanan = json['auskultasiKanan'];
    auskultasiKiri = json['auskultasiKiri'];
  }

  Map<String, dynamic> toJson() {
    return {
      'inspeksiKanan': inspeksiKanan,
      'inspeksiKiri': inspeksiKiri,
      'palpasiKanan': palpasiKanan,
      'palpasiKiri': palpasiKiri,
      'perkusiKanan': perkusiKanan,
      'perkusiKiri': perkusiKiri,
      'auskultasiKanan': auskultasiKanan,
      'auskultasiKiri': auskultasiKiri,
    };
  }
}
