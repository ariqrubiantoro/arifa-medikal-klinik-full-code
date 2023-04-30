import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/ajuran_model.dart';
import '../model/biologi_model.dart';
import '../model/ergonomis_model.dart';
import '../model/fisik_model.dart';
import '../model/kelayakan_kerja_model.dart';
import '../model/kesimpulan_derajat_kesehatan.dart';
import '../model/kimia_model.dart';
import '../model/pasien_model.dart';
import '../model/pemeriksaan_anggota_gerak_model.dart';
import '../model/pemeriksaan_gentalia_model.dart';
import '../model/pemeriksaan_kelenjar_getah_model.dart';
import '../model/pemeriksaan_mata_model.dart';
import '../model/pemeriksaan_model.dart';
import '../model/pemeriksaan_refleks_model.dart';
import '../model/pemeriksaan_rongga_dada_model.dart';
import '../model/pemeriksaan_rongga_perut_model.dart';
import '../model/pemeriksaan_tht_model.dart';
import '../model/pemeriksaan_umum_model.dart';
import '../model/penyakit_keluarga_mode.dart';
import '../model/penyakit_terdahulu_model.dart';
import '../model/psikologi_model.dart';
import '../model/riwayat_kebiasaan_model.dart';

class FirebaseFirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<PasienModel> setPasien(PasienModel pasien) async {
    DocumentReference doc = firestore.collection('pasien').doc(pasien.id);
    pasien.id = doc.id;

    await doc.set(pasien.toJson());

    return pasien;
  }

  Future<PenyakitTerdahuluModel> setPenyakitTerdahulu(
      PenyakitTerdahuluModel penyakitTerdahulu, String idPasien) async {
    DocumentReference doc =
        firestore.collection('penyakitTerdahulu').doc(idPasien);

    await doc.set(penyakitTerdahulu.toJson());

    return penyakitTerdahulu;
  }

  Future<PenyakitTerdahuluModel?> getPenyakitTerdahulu(String idPasien) async {
    DocumentReference doc =
        firestore.collection('penyakitTerdahulu').doc(idPasien);
    DocumentSnapshot snapshot = await doc.get();

    if (snapshot.data() == null) {
      return null;
    } else {
      return PenyakitTerdahuluModel.fromJson(
          snapshot.id, snapshot.data() as Map<String, dynamic>);
    }
  }

  Future<PenyakitKeluargaModel> setPenyakitKeluarga(
      PenyakitKeluargaModel penyakitKeluarga, String idPasien) async {
    DocumentReference doc =
        firestore.collection('penyakitKeluarga').doc(idPasien);

    await doc.set(penyakitKeluarga.toJson());

    return penyakitKeluarga;
  }

  Future<PenyakitKeluargaModel?> getPenyakitKeluarga(String idPasien) async {
    DocumentReference doc =
        firestore.collection('penyakitKeluarga').doc(idPasien);
    DocumentSnapshot snapshot = await doc.get();
    if (snapshot.data() == null) {
      return null;
    } else {
      return PenyakitKeluargaModel.fromJson(
          snapshot.id, snapshot.data() as Map<String, dynamic>);
    }
  }

  Future<RiwayatKebiasaanModel> setRiwayatKebiasaan(
      RiwayatKebiasaanModel riwayatKebiasaan, String idPasien) async {
    DocumentReference doc =
        firestore.collection('riwayatKebiasaan').doc(idPasien);

    await doc.set(riwayatKebiasaan.toJson());

    return riwayatKebiasaan;
  }

  Future<RiwayatKebiasaanModel?> getRiwayatKebiasaan(String idPasien) async {
    DocumentReference doc =
        firestore.collection('riwayatKebiasaan').doc(idPasien);
    DocumentSnapshot snapshot = await doc.get();

    if (snapshot.data() == null) {
      return null;
    } else {
      return RiwayatKebiasaanModel.fromJson(
          snapshot.id, snapshot.data() as Map<String, dynamic>);
    }
  }

  Future<PemeriksaanUmumModel> setPemeriksaanUmum(
      {required PemeriksaanUmumModel pemeriksaanUmum,
      required String idPasien}) async {
    DocumentReference doc = firestore
        .collection('keluhan')
        .doc('keadaanUmum')
        .collection('pemeriksaanUmum')
        .doc(idPasien);

    await doc.set(pemeriksaanUmum.toJson());

    return pemeriksaanUmum;
  }

  Future<PemeriksaanUmumModel?> getPemeriksaanUmum(String idPasien) async {
    DocumentReference doc = firestore
        .collection('keluhan')
        .doc('keadaanUmum')
        .collection('pemeriksaanUmum')
        .doc(idPasien);
    DocumentSnapshot snapshot = await doc.get();

    if (snapshot.data() == null) {
      return null;
    } else {
      return PemeriksaanUmumModel.fromJson(
          snapshot.id, snapshot.data() as Map<String, dynamic>);
    }
  }

  Future<PemeriksaanMataModel> setPemeriksaanMata(
      {required PemeriksaanMataModel pemeriksaanMata,
      required String idPasien}) async {
    DocumentReference doc = firestore
        .collection('keluhan')
        .doc('keadaanUmum')
        .collection('pemeriksaanMata')
        .doc(idPasien);

    await doc.set(pemeriksaanMata.toJson());

    return pemeriksaanMata;
  }

  Future<PemeriksaanMataModel?> getPemeriksaanMata(String idPasien) async {
    DocumentReference doc = firestore
        .collection('keluhan')
        .doc('keadaanUmum')
        .collection('pemeriksaanMata')
        .doc(idPasien);
    DocumentSnapshot snapshot = await doc.get();
    if (snapshot.data() == null) {
      return null;
    } else {
      return PemeriksaanMataModel.fromJson(
          snapshot.id, snapshot.data() as Map<String, dynamic>);
    }
  }

  Future<PemeriksaanTHTModel> setPemeriksaanTHT(
      {required PemeriksaanTHTModel pemeriksaanTHT,
      required String idPasien}) async {
    DocumentReference doc = firestore
        .collection('keluhan')
        .doc('keadaanUmum')
        .collection('pemeriksaanTHT')
        .doc(idPasien);

    await doc.set(pemeriksaanTHT.toJson());

    return pemeriksaanTHT;
  }

  Future<PemeriksaanTHTModel?> getPemeriksaanTHT(String idPasien) async {
    DocumentReference doc = firestore
        .collection('keluhan')
        .doc('keadaanUmum')
        .collection('pemeriksaanTHT')
        .doc(idPasien);
    DocumentSnapshot snapshot = await doc.get();
    if (snapshot.data() == null) {
      return null;
    } else {
      return PemeriksaanTHTModel.fromJson(
          snapshot.id, snapshot.data() as Map<String, dynamic>);
    }
  }

  Future<PemeriksaanRonggaDadaModel> setPemeriksaanRonggaDada(
      {required PemeriksaanRonggaDadaModel pemeriksaanRonggaDada,
      required String idPasien}) async {
    DocumentReference doc = firestore
        .collection('keluhan')
        .doc('keadaanUmum')
        .collection('pemeriksaanRonggaDada')
        .doc(idPasien);

    await doc.set(pemeriksaanRonggaDada.toJson());

    return pemeriksaanRonggaDada;
  }

  Future<PemeriksaanRonggaDadaModel?> getPemeriksaanRonggaDada(
      String idPasien) async {
    DocumentReference doc = firestore
        .collection('keluhan')
        .doc('keadaanUmum')
        .collection('pemeriksaanRonggaDada')
        .doc(idPasien);
    DocumentSnapshot snapshot = await doc.get();
    if (snapshot.data() == null) {
      return null;
    } else {
      return PemeriksaanRonggaDadaModel.fromJson(
          snapshot.id, snapshot.data() as Map<String, dynamic>);
    }
  }

  Future<PemeriksaanRonggaPerutModel> setPemeriksaanRonggaPerut(
      {required PemeriksaanRonggaPerutModel pemeriksaanRonggaPerut,
      required String idPasien}) async {
    DocumentReference doc = firestore
        .collection('keluhan')
        .doc('keadaanUmum')
        .collection('pemeriksaanRonggaPerut')
        .doc(idPasien);

    await doc.set(pemeriksaanRonggaPerut.toJson());

    return pemeriksaanRonggaPerut;
  }

  Future<PemeriksaanRonggaPerutModel?> getPemeriksaanRonggaPerut(
      String idPasien) async {
    DocumentReference doc = firestore
        .collection('keluhan')
        .doc('keadaanUmum')
        .collection('pemeriksaanRonggaPerut')
        .doc(idPasien);
    DocumentSnapshot snapshot = await doc.get();
    if (snapshot.data() == null) {
      return null;
    } else {
      return PemeriksaanRonggaPerutModel.fromJson(
          snapshot.id, snapshot.data() as Map<String, dynamic>);
    }
  }

  Future<PemeriksaanGentaliaModel> setPemeriksaanGentalia(
      {required PemeriksaanGentaliaModel pemeriksaanGentalia,
      required String idPasien}) async {
    DocumentReference doc = firestore
        .collection('keluhan')
        .doc('keadaanUmum')
        .collection('pemeriksaanGentalia')
        .doc(idPasien);

    await doc.set(pemeriksaanGentalia.toJson());

    return pemeriksaanGentalia;
  }

  Future<PemeriksaanGentaliaModel?> getPemeriksaanGentalia(
      String idPasien) async {
    DocumentReference doc = firestore
        .collection('keluhan')
        .doc('keadaanUmum')
        .collection('pemeriksaanGentalia')
        .doc(idPasien);
    DocumentSnapshot snapshot = await doc.get();
    if (snapshot.data() == null) {
      return null;
    } else {
      return PemeriksaanGentaliaModel.fromJson(
          snapshot.id, snapshot.data() as Map<String, dynamic>);
    }
  }

  Future<PemeriksaanAnggotaGerakModel> setPemeriksaanAnggotaGerak(
      {required PemeriksaanAnggotaGerakModel pemeriksaanAnggotaGerak,
      required String idPasien}) async {
    DocumentReference doc = firestore
        .collection('keluhan')
        .doc('keadaanUmum')
        .collection('pemeriksaanAnggotaGerak')
        .doc(idPasien);

    await doc.set(pemeriksaanAnggotaGerak.toJson());

    return pemeriksaanAnggotaGerak;
  }

  Future<PemeriksaanAnggotaGerakModel?> getPemeriksaanAnggotaGerak(
      String idPasien) async {
    DocumentReference doc = firestore
        .collection('keluhan')
        .doc('keadaanUmum')
        .collection('pemeriksaanAnggotaGerak')
        .doc(idPasien);
    DocumentSnapshot snapshot = await doc.get();
    if (snapshot.data() == null) {
      return null;
    } else {
      return PemeriksaanAnggotaGerakModel.fromJson(
          snapshot.id, snapshot.data() as Map<String, dynamic>);
    }
  }

  Future<PemeriksaanRefleksModel> setPemeriksaanRefleks(
      {required PemeriksaanRefleksModel pemeriksaanRefleks,
      required String idPasien}) async {
    DocumentReference doc = firestore
        .collection('keluhan')
        .doc('keadaanUmum')
        .collection('pemeriksaanRefleks')
        .doc(idPasien);

    await doc.set(pemeriksaanRefleks.toJson());

    return pemeriksaanRefleks;
  }

  Future<PemeriksaanRefleksModel?> getPemeriksaanRefleks(
      String idPasien) async {
    DocumentReference doc = firestore
        .collection('keluhan')
        .doc('keadaanUmum')
        .collection('pemeriksaanRefleks')
        .doc(idPasien);
    DocumentSnapshot snapshot = await doc.get();
    if (snapshot.data() == null) {
      return null;
    } else {
      return PemeriksaanRefleksModel.fromJson(
          snapshot.id, snapshot.data() as Map<String, dynamic>);
    }
  }

  Future<PemeriksaanKelenjarGetahModel> setPemeriksaanKelenjarGetah(
      {required PemeriksaanKelenjarGetahModel pemeriksaanKelenjarGetah,
      required String idPasien}) async {
    DocumentReference doc = firestore
        .collection('keluhan')
        .doc('keadaanUmum')
        .collection('pemeriksaanKelenjarGetah')
        .doc(idPasien);

    await doc.set(pemeriksaanKelenjarGetah.toJson());

    return pemeriksaanKelenjarGetah;
  }

  Future<PemeriksaanKelenjarGetahModel?> getPemeriksaanKelenjarGetah(
      String idPasien) async {
    DocumentReference doc = firestore
        .collection('keluhan')
        .doc('keadaanUmum')
        .collection('pemeriksaanKelenjarGetah')
        .doc(idPasien);
    DocumentSnapshot snapshot = await doc.get();
    if (snapshot.data() == null) {
      return null;
    } else {
      return PemeriksaanKelenjarGetahModel.fromJson(
          snapshot.id, snapshot.data() as Map<String, dynamic>);
    }
  }

  Future<FisikModel> setFisik(
      {required FisikModel fisik, required String idPasien}) async {
    DocumentReference doc = firestore
        .collection('keluhan')
        .doc('riwayatPajananPadaPekerjaan')
        .collection('fisik')
        .doc(idPasien);

    await doc.set(fisik.toJson());

    return fisik;
  }

  Future<FisikModel?> getFisik(String idPasien) async {
    DocumentReference doc = firestore
        .collection('keluhan')
        .doc('riwayatPajananPadaPekerjaan')
        .collection('fisik')
        .doc(idPasien);
    DocumentSnapshot snapshot = await doc.get();
    if (snapshot.data() == null) {
      return null;
    } else {
      return FisikModel.fromJson(
          snapshot.id, snapshot.data() as Map<String, dynamic>);
    }
  }

  Future<KimiaModel> setKimia(
      {required KimiaModel kimia, required String idPasien}) async {
    DocumentReference doc = firestore
        .collection('keluhan')
        .doc('riwayatPajananPadaPekerjaan')
        .collection('kimia')
        .doc(idPasien);

    await doc.set(kimia.toJson());

    return kimia;
  }

  Future<KimiaModel?> getKimia(String idPasien) async {
    DocumentReference doc = firestore
        .collection('keluhan')
        .doc('riwayatPajananPadaPekerjaan')
        .collection('kimia')
        .doc(idPasien);
    DocumentSnapshot snapshot = await doc.get();
    if (snapshot.data() == null) {
      return null;
    } else {
      return KimiaModel.fromJson(
          snapshot.id, snapshot.data() as Map<String, dynamic>);
    }
  }

  Future<BiologiModel> setBiologi(
      {required BiologiModel biologi, required String idPasien}) async {
    DocumentReference doc = firestore
        .collection('keluhan')
        .doc('riwayatPajananPadaPekerjaan')
        .collection('biologi')
        .doc(idPasien);

    await doc.set(biologi.toJson());

    return biologi;
  }

  Future<BiologiModel?> getBiologi(String idPasien) async {
    DocumentReference doc = firestore
        .collection('keluhan')
        .doc('riwayatPajananPadaPekerjaan')
        .collection('biologi')
        .doc(idPasien);
    DocumentSnapshot snapshot = await doc.get();
    if (snapshot.data() == null) {
      return null;
    } else {
      return BiologiModel.fromJson(
          snapshot.id, snapshot.data() as Map<String, dynamic>);
    }
  }

  Future<PsikologiModel> setPsikologi(
      {required PsikologiModel psikologi, required String idPasien}) async {
    DocumentReference doc = firestore
        .collection('keluhan')
        .doc('riwayatPajananPadaPekerjaan')
        .collection('psikologi')
        .doc(idPasien);

    await doc.set(psikologi.toJson());

    return psikologi;
  }

  Future<PsikologiModel?> getPsikologi(String idPasien) async {
    DocumentReference doc = firestore
        .collection('keluhan')
        .doc('riwayatPajananPadaPekerjaan')
        .collection('psikologi')
        .doc(idPasien);
    DocumentSnapshot snapshot = await doc.get();
    if (snapshot.data() == null) {
      return null;
    } else {
      return PsikologiModel.fromJson(
          snapshot.id, snapshot.data() as Map<String, dynamic>);
    }
  }

  Future<ErgonomisModel> setErgonomis(
      {required ErgonomisModel ergonomis, required String idPasien}) async {
    DocumentReference doc = firestore
        .collection('keluhan')
        .doc('riwayatPajananPadaPekerjaan')
        .collection('ergonomis')
        .doc(idPasien);

    await doc.set(ergonomis.toJson());

    return ergonomis;
  }

  Future<ErgonomisModel?> getErgonomis(String idPasien) async {
    DocumentReference doc = firestore
        .collection('keluhan')
        .doc('riwayatPajananPadaPekerjaan')
        .collection('ergonomis')
        .doc(idPasien);
    DocumentSnapshot snapshot = await doc.get();
    if (snapshot.data() == null) {
      return null;
    } else {
      return ErgonomisModel.fromJson(
          snapshot.id, snapshot.data() as Map<String, dynamic>);
    }
  }

  Future<PemeriksaanModel> setPemeriksaan(
      {required PemeriksaanModel pemeriksaan, required String idPasien}) async {
    DocumentReference doc = firestore.collection('pemeriksaan').doc(idPasien);

    await doc.set(pemeriksaan.toJson());

    return pemeriksaan;
  }

  Future<PemeriksaanModel?> getPemeriksaan(String idPasien) async {
    DocumentReference doc = firestore.collection('pemeriksaan').doc(idPasien);
    DocumentSnapshot snapshot = await doc.get();
    if (snapshot.data() == null) {
      return null;
    } else {
      return PemeriksaanModel.fromJson(
          snapshot.id, snapshot.data() as Map<String, dynamic>);
    }
  }

  Future<AjuranModel> setAjuran(
      {required AjuranModel ajuran, required String idPasien}) async {
    DocumentReference doc = firestore.collection('ajuran').doc(idPasien);

    await doc.set(ajuran.toJson());

    return ajuran;
  }

  Future<AjuranModel?> getAjuran(String idPasien) async {
    DocumentReference doc = firestore.collection('ajuran').doc(idPasien);
    DocumentSnapshot snapshot = await doc.get();
    if (snapshot.data() == null) {
      return null;
    } else {
      return AjuranModel.fromJson(
          snapshot.id, snapshot.data() as Map<String, dynamic>);
    }
  }

  Future<KelayakanKerjaModel> setKelayakanKerja(
      {required KelayakanKerjaModel kelayakanKerja,
      required String idPasien}) async {
    DocumentReference doc =
        firestore.collection('kelayakanKerja').doc(idPasien);

    await doc.set(kelayakanKerja.toJson());

    return kelayakanKerja;
  }

  Future<KelayakanKerjaModel?> getKelayakanKerja(String idPasien) async {
    DocumentReference doc =
        firestore.collection('kelayakanKerja').doc(idPasien);
    DocumentSnapshot snapshot = await doc.get();
    if (snapshot.data() == null) {
      return null;
    } else {
      return KelayakanKerjaModel.fromJson(
          snapshot.id, snapshot.data() as Map<String, dynamic>);
    }
  }

  Future<KesimpulanDerajatKesehatanModel> setKesimpulanDerajatKesehatan(
      {required KesimpulanDerajatKesehatanModel kesimpulanDerajatKesehatan,
      required String idPasien}) async {
    DocumentReference doc =
        firestore.collection('kesimpulanDerajatKesehatan').doc(idPasien);

    await doc.set(kesimpulanDerajatKesehatan.toJson());

    return kesimpulanDerajatKesehatan;
  }

  Future<KesimpulanDerajatKesehatanModel?> getKesimpulanDerajatKesehatan(
      String idPasien) async {
    DocumentReference doc =
        firestore.collection('kesimpulanDerajatKesehatan').doc(idPasien);
    DocumentSnapshot snapshot = await doc.get();
    if (snapshot.data() == null) {
      return null;
    } else {
      return KesimpulanDerajatKesehatanModel.fromJson(
          snapshot.id, snapshot.data() as Map<String, dynamic>);
    }
  }

  Future<dynamic> deletePasien(String idPasien) async {
    await firestore.collection('pasien').doc(idPasien).delete();
    await firestore.collection('penyakitTerdahulu').doc(idPasien).delete();
    await firestore.collection('riwayatKebiasaan').doc(idPasien).delete();
    await firestore.collection('penyakitKeluarga').doc(idPasien).delete();
    await firestore.collection('pemeriksaan').doc(idPasien).delete();
    await firestore
        .collection('kesimpulanDerajatKesehatan')
        .doc(idPasien)
        .delete();
    await firestore.collection('kelayakanKerja').doc(idPasien).delete();
    await firestore.collection('ajuran').doc(idPasien).delete();
    await firestore
        .collection('keluhan')
        .doc('keadaanUmum')
        .collection('pemeriksaanUmum')
        .doc(idPasien)
        .delete();
    await firestore
        .collection('keluhan')
        .doc('keadaanUmum')
        .collection('pemeriksaanTHT')
        .doc(idPasien)
        .delete();
    await firestore
        .collection('keluhan')
        .doc('keadaanUmum')
        .collection('pemeriksaanRonggaPerut')
        .doc(idPasien)
        .delete();
    await firestore
        .collection('keluhan')
        .doc('keadaanUmum')
        .collection('pemeriksaanRonggaDada')
        .doc(idPasien)
        .delete();
    await firestore
        .collection('keluhan')
        .doc('keadaanUmum')
        .collection('pemeriksaanRefleks')
        .doc(idPasien)
        .delete();
    await firestore
        .collection('keluhan')
        .doc('keadaanUmum')
        .collection('pemeriksaanMata')
        .doc(idPasien)
        .delete();
    await firestore
        .collection('keluhan')
        .doc('keadaanUmum')
        .collection('pemeriksaanKelenjarGetah')
        .doc(idPasien)
        .delete();
    await firestore
        .collection('keluhan')
        .doc('keadaanUmum')
        .collection('pemeriksaanGentalia')
        .doc(idPasien)
        .delete();
    await firestore
        .collection('keluhan')
        .doc('keadaanUmum')
        .collection('pemeriksaanAnggotaGerak')
        .doc(idPasien)
        .delete();
    await firestore
        .collection('keluhan')
        .doc('riwayatPajananPadaPekerjaan')
        .collection('biologi')
        .doc(idPasien)
        .delete();
    await firestore
        .collection('keluhan')
        .doc('riwayatPajananPadaPekerjaan')
        .collection('ergonomis')
        .doc(idPasien)
        .delete();
    await firestore
        .collection('keluhan')
        .doc('riwayatPajananPadaPekerjaan')
        .collection('fisik')
        .doc(idPasien)
        .delete();
    await firestore
        .collection('keluhan')
        .doc('riwayatPajananPadaPekerjaan')
        .collection('kimia')
        .doc(idPasien)
        .delete();
    await firestore
        .collection('keluhan')
        .doc('riwayatPajananPadaPekerjaan')
        .collection('psikologi')
        .doc(idPasien)
        .delete();
  }
}
