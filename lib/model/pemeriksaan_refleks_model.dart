class PemeriksaanRefleksModel {
  PupilModel? pupil;
  PatellaModel? patella;
  AchillesModel? achilles;

  PemeriksaanRefleksModel({this.pupil, this.patella, this.achilles});

  factory PemeriksaanRefleksModel.fromJson(
      String? id, Map<String, dynamic> json) {
    return PemeriksaanRefleksModel(
      pupil: json['pupil'] != null ? PupilModel.fromJson(json['pupil']) : null,
      patella: json['patella'] != null
          ? PatellaModel.fromJson(json['patella'])
          : null,
      achilles: json['achilles'] != null
          ? AchillesModel.fromJson(json['achilles'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pupil': pupil?.toJson(),
      'patella': patella?.toJson(),
      'achilles': achilles?.toJson(),
    };
  }
}

class PupilModel {
  String? pupil;
  String? bicepsKanan;
  String? bicepsKiri;

  PupilModel({this.pupil, this.bicepsKanan, this.bicepsKiri});

  PupilModel.fromJson(Map<String, dynamic> json) {
    pupil = json['pupil'];
    bicepsKanan = json['biceps_kanan'];
    bicepsKiri = json['biceps_kiri'];
  }

  Map<String, dynamic> toJson() {
    return {
      'pupil': pupil,
      'biceps_kanan': bicepsKanan,
      'biceps_kiri': bicepsKiri,
    };
  }
}

class PatellaModel {
  String? patella;
  String? tricepsKanan;
  String? tricepsKiri;

  PatellaModel({this.patella, this.tricepsKanan, this.tricepsKiri});

  PatellaModel.fromJson(Map<String, dynamic> json) {
    patella = json['patella'];
    tricepsKanan = json['triceps_kanan'];
    tricepsKiri = json['triceps_kiri'];
  }

  Map<String, dynamic> toJson() {
    return {
      'patella': patella,
      'triceps_kanan': tricepsKanan,
      'triceps_kiri': tricepsKiri,
    };
  }
}

class AchillesModel {
  String? acciles;
  String? babinskiKanan;
  String? babinskiKiri;

  AchillesModel({this.acciles, this.babinskiKanan, this.babinskiKiri});

  AchillesModel.fromJson(Map<String, dynamic> json) {
    acciles = json['acciles'];
    babinskiKanan = json['babinski_kanan'];
    babinskiKiri = json['babinski_kiri'];
  }

  Map<String, dynamic> toJson() {
    return {
      'acciles': acciles,
      'babinski_kanan': babinskiKanan,
      'babinski_kiri': babinskiKiri,
    };
  }
}
