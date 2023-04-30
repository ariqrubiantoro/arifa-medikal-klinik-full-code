class PasienModel {
  String? id;
  String? nama;
  String? jenisKelamin;
  String? nik;
  String? alamat;
  String? tanggalPemeriksaan;
  String? tempatLahir;
  String? tanggalLahir;
  String? umur;
  String? perusahaan;
  String? bagian;
  String? noHp;
  String? waktu;

  PasienModel({
    this.id,
    this.nama,
    this.jenisKelamin,
    this.nik,
    this.alamat,
    this.tanggalPemeriksaan,
    this.tempatLahir,
    this.tanggalLahir,
    this.umur,
    this.perusahaan,
    this.bagian,
    this.noHp,
    this.waktu,
  });

  PasienModel.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    jenisKelamin = json['jenis_kelamin'];
    nik = json['nik'];
    alamat = json['alamat'];
    tanggalPemeriksaan = json['tanggal_pemeriksaan'];
    tempatLahir = json['tempat_lahir'];
    tanggalLahir = json['tanggal_lahir'];
    umur = json['umur'];
    perusahaan = json['perusahaan'];
    bagian = json['bagian'];
    noHp = json['no_hp'];
    waktu = json['waktu'];
  }

  Map<String, dynamic> toJson() {
    return {
      'namaPasien': nama,
      'jenis_kelamin': jenisKelamin,
      'NIK': nik,
      'alamat': alamat,
      'tanggal_pemeriksaan': tanggalPemeriksaan,
      'tempat_lahir': tempatLahir,
      'tanggal_lahir': tanggalLahir,
      'umur': umur,
      'perusahaan': perusahaan,
      'bagian': bagian,
      'no_hp': noHp,
      'waktu': waktu,
    };
  }
}
