class FisikModel {
  String? kebisingan;
  String? suhuPanas;
  String? suhuDingin;
  String? radiasiBukanPengion;
  String? radiasiPengion;
  String? getaranLokal;
  String? getaranSeluruhTubuh;
  String? ketinggian;
  String? lainLain;

  FisikModel({
    this.kebisingan,
    this.suhuPanas,
    this.suhuDingin,
    this.radiasiBukanPengion,
    this.radiasiPengion,
    this.getaranLokal,
    this.getaranSeluruhTubuh,
    this.ketinggian,
    this.lainLain,
  });

  factory FisikModel.fromJson(String id, Map<String, dynamic> json) {
    return FisikModel(
      kebisingan: json['kebisingan'],
      suhuPanas: json['suhuPanas'],
      suhuDingin: json['suhuDingin'],
      radiasiBukanPengion: json['radiasiBukanPengion'],
      radiasiPengion: json['radiasiPengion'],
      getaranLokal: json['getaranLokal'],
      getaranSeluruhTubuh: json['getaranSeluruhTubuh'],
      ketinggian: json['ketinggian'],
      lainLain: json['lainLain'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kebisingan': kebisingan,
      'suhuPanas': suhuPanas,
      'suhuDingin': suhuDingin,
      'radiasiBukanPengion': radiasiBukanPengion,
      'radiasiPengion': radiasiPengion,
      'getaranLokal': getaranLokal,
      'getaranSeluruhTubuh': getaranSeluruhTubuh,
      'ketinggian': ketinggian,
      'lainLain': lainLain,
    };
  }
}
