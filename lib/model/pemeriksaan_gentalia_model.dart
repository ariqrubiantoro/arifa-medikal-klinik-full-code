class PemeriksaanGentaliaModel {
  String? hernia;
  String? hemorhoid;
  String? sikatriks;
  String? spincter;
  String? efidymisTestisProstat;
  String? ekskresi;

  PemeriksaanGentaliaModel({
    this.hernia,
    this.hemorhoid,
    this.sikatriks,
    this.spincter,
    this.efidymisTestisProstat,
    this.ekskresi,
  });

  factory PemeriksaanGentaliaModel.fromJson(
      String? id, Map<String, dynamic> json) {
    return PemeriksaanGentaliaModel(
      hernia: json['hernia'],
      hemorhoid: json['hemorhoid'],
      sikatriks: json['sikatriks'],
      spincter: json['spincter'],
      efidymisTestisProstat: json['efidymisTestisProstat'],
      ekskresi: json['ekskresi'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hernia': hernia,
      'hemorhoid': hemorhoid,
      'sikatriks': sikatriks,
      'spincter': spincter,
      'efidymisTestisProstat': efidymisTestisProstat,
      'ekskresi': ekskresi,
    };
  }
}
