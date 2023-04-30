class KimiaModel {
  String? debuAnorganik;
  String? debuOrganik;
  String? asap;
  String? logamBerat;
  String? pelarutOrganik;
  String? iritanAsam;
  String? iritanBasa;
  String? cairanPembersih;
  String? pestisida;
  String? uapLogam;
  String? lainLain;

  KimiaModel({
    this.debuAnorganik,
    this.debuOrganik,
    this.asap,
    this.logamBerat,
    this.pelarutOrganik,
    this.iritanAsam,
    this.iritanBasa,
    this.cairanPembersih,
    this.pestisida,
    this.uapLogam,
    this.lainLain,
  });

  factory KimiaModel.fromJson(String idPasien, Map<String, dynamic> json) {
    return KimiaModel(
      debuAnorganik: json['debu_anorganik'],
      debuOrganik: json['debu_organik'],
      asap: json['asap'],
      logamBerat: json['logam_berat'],
      pelarutOrganik: json['pelarut_organik'],
      iritanAsam: json['iritan_asam'],
      iritanBasa: json['iritan_basa'],
      cairanPembersih: json['cairan_pembersih'],
      pestisida: json['pestisida'],
      uapLogam: json['uap_logam'],
      lainLain: json['lain_lain'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'debu_anorganik': debuAnorganik,
      'debu_organik': debuOrganik,
      'asap': asap,
      'logam_berat': logamBerat,
      'pelarut_organik': pelarutOrganik,
      'iritan_asam': iritanAsam,
      'iritan_basa': iritanBasa,
      'cairan_pembersih': cairanPembersih,
      'pestisida': pestisida,
      'uap_logam': uapLogam,
      'lain_lain': lainLain,
    };
  }
}
