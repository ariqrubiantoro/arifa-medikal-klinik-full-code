class PemeriksaanKelenjarGetahModel {
  String? cervicalKiri;
  String? cervicalKanan;
  String? axilaKiri;
  String? axilaKanan;
  String? supraclaviculaKiri;
  String? supraclaviculaKanan;
  String? infraclaviculaKiri;
  String? infraclaviculaKanan;
  String? inguinalKiri;
  String? inguinalKanan;

  PemeriksaanKelenjarGetahModel({
    this.cervicalKiri,
    this.cervicalKanan,
    this.axilaKiri,
    this.axilaKanan,
    this.supraclaviculaKiri,
    this.supraclaviculaKanan,
    this.infraclaviculaKiri,
    this.infraclaviculaKanan,
    this.inguinalKiri,
    this.inguinalKanan,
  });

  factory PemeriksaanKelenjarGetahModel.fromJson(
      String? id, Map<String, dynamic> json) {
    return PemeriksaanKelenjarGetahModel(
      cervicalKiri: json['cervical_kiri'],
      cervicalKanan: json['cervical_kanan'],
      axilaKiri: json['axila_kiri'],
      axilaKanan: json['axila_kanan'],
      supraclaviculaKiri: json['supraclavicula_kiri'],
      supraclaviculaKanan: json['supraclavicula_kanan'],
      infraclaviculaKiri: json['infraclavicula_kiri'],
      infraclaviculaKanan: json['infraclavicula_kanan'],
      inguinalKiri: json['inguinal_kiri'],
      inguinalKanan: json['inguinal_kanan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cervical_kiri': cervicalKiri,
      'cervical_kanan': cervicalKanan,
      'axila_kiri': axilaKiri,
      'axila_kanan': axilaKanan,
      'supraclavicula_kiri': supraclaviculaKiri,
      'supraclavicula_kanan': supraclaviculaKanan,
      'infraclavicula_kiri': infraclaviculaKiri,
      'infraclavicula_kanan': infraclaviculaKanan,
      'inguinal_kiri': inguinalKiri,
      'inguinal_kanan': inguinalKanan,
    };
  }
}
