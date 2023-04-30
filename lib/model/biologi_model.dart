class BiologiModel {
  String? bakteri;
  String? darah;
  String? nyamuk;
  String? limbah;
  String? lainLain;

  BiologiModel({
    this.bakteri,
    this.darah,
    this.nyamuk,
    this.limbah,
    this.lainLain,
  });

  factory BiologiModel.fromJson(String idPasien, Map<String, dynamic> json) {
    return BiologiModel(
      bakteri: json['bakteri'],
      darah: json['darah'],
      nyamuk: json['nyamuk'],
      limbah: json['limbah'],
      lainLain: json['lainLain'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bakteri': bakteri,
      'darah': darah,
      'nyamuk': nyamuk,
      'limbah': limbah,
      'lainLain': lainLain,
    };
  }
}
