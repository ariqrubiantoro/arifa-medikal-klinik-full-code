class AjuranModel {
  String? konsumsiAir;
  String? olahragaTeratur;

  AjuranModel({this.konsumsiAir, this.olahragaTeratur});

  factory AjuranModel.fromJson(String? id, Map<String, dynamic> json) {
    return AjuranModel(
      konsumsiAir: json['konsumsiAir'],
      olahragaTeratur: json['olahragaTeratur'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'konsumsiAir': konsumsiAir,
      'olahragaTeratur': olahragaTeratur,
    };
  }
}
