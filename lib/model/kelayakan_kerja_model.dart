class KelayakanKerjaModel {
  String? layakBekerjaSesuaiPosisi;
  String? layakBekerjaDenganCatatan;
  String? layakBekerjaDenganPenyesuaian;
  String? layakuntukBekerja;
  String? resikoCardioVascular;

  KelayakanKerjaModel(
      {this.layakBekerjaSesuaiPosisi,
      this.layakBekerjaDenganCatatan,
      this.layakBekerjaDenganPenyesuaian,
      this.layakuntukBekerja,
      this.resikoCardioVascular});

  factory KelayakanKerjaModel.fromJson(String? id, Map<String, dynamic> json) {
    return KelayakanKerjaModel(
      layakBekerjaSesuaiPosisi: json['layakBekerjaSesuaiPosisi'],
      layakBekerjaDenganCatatan: json['layakBekerjaDenganCatatan'],
      layakBekerjaDenganPenyesuaian: json['layakBekerjaDenganPenyesuaian'],
      layakuntukBekerja: json['layakuntukBekerja'],
      resikoCardioVascular: json['resikoCardioVascular'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'layakBekerjaSesuaiPosisi': layakBekerjaSesuaiPosisi,
      'layakBekerjaDenganCatatan': layakBekerjaDenganCatatan,
      'layakBekerjaDenganPenyesuaian': layakBekerjaDenganPenyesuaian,
      'layakuntukBekerja': layakuntukBekerja,
      'resikoCardioVascular': resikoCardioVascular,
    };
  }
}
