class RiwayatKebiasaanModel {
  String? id;
  String? strMerokok;

  String? strMiras;

  MerokokModel? merokok;
  MirasModel? miras;
  String? olahraga;

  RiwayatKebiasaanModel(
      {this.id,
      this.strMerokok,
      this.strMiras,
      this.merokok,
      this.miras,
      this.olahraga});

  factory RiwayatKebiasaanModel.fromJson(
      String? id, Map<String, dynamic> json) {
    return RiwayatKebiasaanModel(
      id: id,
      strMerokok: json['strMerokok'],
      strMiras: json['strMiras'],
      merokok: json['merokok'] != "Tidak"
          ? MerokokModel.fromJson(json['merokok'])
          : null,
      miras:
          json['miras'] != "Tidak" ? MirasModel.fromJson(json['miras']) : null,
      olahraga: json['olahraga'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'strMerokok': strMerokok,
      'strMiras': strMiras,
      'merokok': merokok != null ? merokok?.toJson() : "Tidak",
      'miras': miras != null ? miras?.toJson() : "Tidak",
      'olahraga': olahraga,
    };
  }
}

class MerokokModel extends RiwayatKebiasaanModel {
  String? lama;
  String? batang;
  String? bungkus;

  MerokokModel({this.lama, this.batang, this.bungkus});

  MerokokModel.fromJson(Map<String, dynamic> json) {
    lama = json['lama'];
    batang = json['batang'];
    bungkus = json['bungkus'];
  }

  Map<String, dynamic> toJson() {
    return {
      'lama': lama,
      'batang': batang,
      'bungkus': bungkus,
    };
  }
}

class MirasModel extends RiwayatKebiasaanModel {
  String? lama;
  String? gelas;
  String? botol;

  MirasModel({this.lama, this.gelas, this.botol});

  MirasModel.fromJson(Map<String, dynamic> json) {
    lama = json['lama'];
    gelas = json['gelas'];
    botol = json['botol'];
  }

  Map<String, dynamic> toJson() {
    return {
      'lama': lama,
      'gelas': gelas,
      'botol': botol,
    };
  }
}
