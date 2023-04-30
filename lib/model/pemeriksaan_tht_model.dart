class PemeriksaanTHTModel {
  Telinga? telinga;
  Hidung? hidung;
  Kerongkongan? kerongkongan;

  PemeriksaanTHTModel({
    this.telinga,
    this.hidung,
    this.kerongkongan,
  });

  factory PemeriksaanTHTModel.fromJson(String? id, Map<String, dynamic> json) =>
      PemeriksaanTHTModel(
        telinga: Telinga.fromJson(json["telinga"]),
        hidung: Hidung.fromJson(json["hidung"]),
        kerongkongan: Kerongkongan.fromJson(json["kerongkongan"]),
      );

  Map<String, dynamic> toJson() {
    return {
      'telinga': telinga?.toJson(),
      'hidung': hidung?.toJson(),
      'kerongkongan': kerongkongan?.toJson(),
    };
  }
}

class Telinga {
  String? membranTympKiri;
  String? membranTympKanan;
  String? penyakitTelingaKiri;
  String? serumenKiri;
  String? penyakitTelingaKanan;
  String? serumenKanan;

  Telinga({
    this.membranTympKiri,
    this.membranTympKanan,
    this.penyakitTelingaKiri,
    this.serumenKiri,
    this.penyakitTelingaKanan,
    this.serumenKanan,
  });

  factory Telinga.fromJson(Map<String, dynamic> json) => Telinga(
        membranTympKiri: json["membran_tymp_kiri"],
        membranTympKanan: json["membran_tymp_kanan"],
        penyakitTelingaKiri: json["penyakit_telinga_kiri"],
        serumenKiri: json["serumen_kiri"],
        penyakitTelingaKanan: json["penyakit_telinga_kanan"],
        serumenKanan: json["serumen_kanan"],
      );

  Map<String, dynamic> toJson() {
    return {
      'membran_tymp_kiri': membranTympKiri,
      'membran_tymp_kanan': membranTympKanan,
      'penyakit_telinga_kiri': penyakitTelingaKiri,
      'serumen_kiri': serumenKiri,
      'penyakit_telinga_kanan': penyakitTelingaKanan,
      'serumen_kanan': serumenKanan,
    };
  }
}

class Hidung {
  String? pilekTersumbat;
  String? lidah;
  String? lainLain;

  Hidung({
    this.pilekTersumbat,
    this.lidah,
    this.lainLain,
  });

  factory Hidung.fromJson(Map<String, dynamic> json) => Hidung(
        pilekTersumbat: json["pilek_tersumbat"],
        lidah: json["lidah"],
        lainLain: json["lain_lain"],
      );

  Map<String, dynamic> toJson() {
    return {
      'pilek_tersumbat': pilekTersumbat,
      'lidah': lidah,
      'lain_lain': lainLain,
    };
  }
}

class Kerongkongan {
  String? tonsilKanan;
  String? tonsilKiri;
  String? pharing;
  String? tiroid;
  String? lainLain;

  Kerongkongan({
    this.tonsilKanan,
    this.tonsilKiri,
    this.pharing,
    this.tiroid,
    this.lainLain,
  });

  factory Kerongkongan.fromJson(Map<String, dynamic> json) => Kerongkongan(
        tonsilKanan: json["tonsil_kanan"],
        tonsilKiri: json["tonsil_kiri"],
        pharing: json["pharing"],
        tiroid: json["tiroid"],
        lainLain: json["lain_lain"],
      );

  Map<String, dynamic> toJson() {
    return {
      'tonsil_kanan': tonsilKanan,
      'tonsil_kiri': tonsilKiri,
      'pharing': pharing,
      'tiroid': tiroid,
      'lain_lain': lainLain,
    };
  }
}
