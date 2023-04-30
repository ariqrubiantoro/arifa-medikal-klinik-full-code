// import 'dart:convert';
// import 'dart:io';
// import 'dart:html' as html;
// import 'package:pdf/widgets.dart' as pw;
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';

// class DownloadHasil extends StatelessWidget {
//   const DownloadHasil({super.key, required this.dataPasien});

//   final Map<String, dynamic> dataPasien;

//   @override
//   Widget build(BuildContext context) {
//     // Future<void> _createPDF() async {
//     //   //Create a PDF document.
//     //   PdfDocument document = PdfDocument();
//     //   //Add a page and draw text

//     //   document.pages.add().graphics.drawString(dataPasien['namaPasien'],
//     //       PdfStandardFont(PdfFontFamily.helvetica, 20),
//     //       brush: PdfSolidBrush(PdfColor(0, 0, 0)),
//     //       bounds: Rect.fromLTWH(20, 60, 150, 30));
//     //   //Save the document
//     //   List<int> bytes = await document.save();
//     //   //Dispose the document
//     //   document.dispose();
//     //   AnchorElement(
//     //       href:
//     //           "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
//     //     ..setAttribute("download", dataPasien['namaPasien'] + ".pdf")
//     //     ..click();
//     // }

// Future<void> testPdf() async {
//   final pdf = pw.Document();

//   pdf.addPage(
//     pw.Page(
//       build: (pw.Context context) => pw.Center(
//         child: pw.Text('Hello World!'),
//       ),
//     ),
//   );

//       final bytes = await pdf.save();
//       final blob = html.Blob([bytes], 'application/pdf');
//       final url = html.Url.createObjectUrlFromBlob(blob);
//       html.window.open(url, '_blank');
//       html.Url.revokeObjectUrl(url);
//       // final file = File('example.pdf');
//       // await file.writeAsBytes(await pdf.save());
//     }

//     return Scaffold(
//       appBar: AppBar(title: Text('Profil Pasien')),
//       body: Center(
//           child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'Data Diri',
//             style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Column(
//                 children: [
//                   Text('Nama: ' + dataPasien['namaPasien']),
//                 ],
//               ),
//               Column(
//                 children: [
//                   Text('NIK: ' + dataPasien['NIK']),
//                 ],
//               )
//             ],
//           ),
//           ElevatedButton(
//             child: Text('Download file'),
//             onPressed: () {
//               // print('NIK: ' + dataPasien['NIK'].toString());
//               // _createPDF();
//               testPdf();
//             },
//           ),
//         ],
//       )),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';

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
import 'service/firebase_firestore_service.dart';
import 'dart:html' as html;

class DownloadHasil extends StatefulWidget {
  const DownloadHasil(
      {super.key, required this.dataPasien, required this.idPasien});

  final Map<String, dynamic> dataPasien;
  final String idPasien;
  @override
  State<DownloadHasil> createState() => _DownloadHasilState();
}

class _DownloadHasilState extends State<DownloadHasil> {
  FirebaseFirestoreService firestore = FirebaseFirestoreService();
  PenyakitTerdahuluModel? _penyakitTerdahulu;
  PenyakitKeluargaModel? _penyakitKeluarga;
  PemeriksaanModel? _pemeriksaan;
  AjuranModel? _ajuran;
  KelayakanKerjaModel? _kelayakanKerja;
  KesimpulanDerajatKesehatanModel? _kesimpulanDerajatKesehatan;
  PemeriksaanUmumModel? _pemeriksaanUmum;
  PemeriksaanMataModel? _pemeriksaanMata;
  PemeriksaanTHTModel? _pemeriksaanTHT;
  PemeriksaanRonggaDadaModel? _pemeriksaanRonggaDada;
  PemeriksaanRonggaPerutModel? _pemeriksaanRonggaPerut;
  PemeriksaanGentaliaModel? _pemeriksaanGentalia;
  PemeriksaanAnggotaGerakModel? _pemeriksaanAnggotaGerak;
  PemeriksaanRefleksModel? _pemeriksaanRefleks;
  PemeriksaanKelenjarGetahModel? _pemeriksaanKelenjarGetah;
  RiwayatKebiasaanModel? _riwayatKebiasaan;
  FisikModel? _fisik;
  KimiaModel? _kimia;
  BiologiModel? _biologi;
  PsikologiModel? _psikologi;
  ErgonomisModel? _ergonomis;

  @override
  void initState() {
    setState(() {
      initializeData();
    });
    super.initState();
  }

  void initializeData() async {
    _penyakitTerdahulu = await firestore.getPenyakitTerdahulu(widget.idPasien);
    _penyakitKeluarga = await firestore.getPenyakitKeluarga(widget.idPasien);
    _pemeriksaan = await firestore.getPemeriksaan(widget.idPasien);
    _ajuran = await firestore.getAjuran(widget.idPasien);
    _kelayakanKerja = await firestore.getKelayakanKerja(widget.idPasien);
    _kesimpulanDerajatKesehatan =
        await firestore.getKesimpulanDerajatKesehatan(widget.idPasien);
    _pemeriksaanUmum = await firestore.getPemeriksaanUmum(widget.idPasien);
    _pemeriksaanMata = await firestore.getPemeriksaanMata(widget.idPasien);
    _pemeriksaanTHT = await firestore.getPemeriksaanTHT(widget.idPasien);
    _pemeriksaanRonggaDada =
        await firestore.getPemeriksaanRonggaDada(widget.idPasien);
    _pemeriksaanRonggaPerut =
        await firestore.getPemeriksaanRonggaPerut(widget.idPasien);
    _pemeriksaanGentalia =
        await firestore.getPemeriksaanGentalia(widget.idPasien);
    _pemeriksaanAnggotaGerak =
        await firestore.getPemeriksaanAnggotaGerak(widget.idPasien);
    _pemeriksaanRefleks =
        await firestore.getPemeriksaanRefleks(widget.idPasien);
    _pemeriksaanKelenjarGetah =
        await firestore.getPemeriksaanKelenjarGetah(widget.idPasien);
    _riwayatKebiasaan = await firestore.getRiwayatKebiasaan(widget.idPasien);
    _fisik = await firestore.getFisik(widget.idPasien);
    _kimia = await firestore.getKimia(widget.idPasien);
    _biologi = await firestore.getBiologi(widget.idPasien);
    _psikologi = await firestore.getPsikologi(widget.idPasien);
    _ergonomis = await firestore.getErgonomis(widget.idPasien);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Future<void> testPdf() async {
      final pdf = pw.Document();
      final ByteData bytesImage1 =
          await rootBundle.load('assets/images/header.jpeg');
      final Uint8List headerImage = bytesImage1.buffer.asUint8List();

      final ByteData bytesImage2 =
          await rootBundle.load('assets/images/footer.jpeg');
      final Uint8List footerImage = bytesImage2.buffer.asUint8List();

      final ByteData bytesImage3 =
          await rootBundle.load('assets/images/ttd.png');
      final Uint8List ttdDokter = bytesImage3.buffer.asUint8List();

      pdf.addPage(
        pw.MultiPage(
            pageFormat: PdfPageFormat.a4,
            maxPages: 20,
            margin: pw.EdgeInsets.all(0),
            header: (context) {
              return pw.Container(
                width: 1000,
                height: 80,
                margin: pw.EdgeInsets.only(bottom: 10),
                decoration: pw.BoxDecoration(),
                child: pw.ClipRRect(
                  child: pw.Container(
                    child: pw.Image(
                      pw.MemoryImage(headerImage),
                      fit: pw.BoxFit.fill,
                    ),
                  ),
                ),
              );
            },
            footer: (context) {
              return pw.Container(
                width: 1000,
                height: 80,
                decoration: pw.BoxDecoration(),
                child: pw.ClipRRect(
                  child: pw.Container(
                    child: pw.Image(
                      pw.MemoryImage(footerImage),
                      fit: pw.BoxFit.fill,
                    ),
                  ),
                ),
              );
            },
            build: (pw.Context context) {
              return [
                pw.Container(
                  padding: pw.EdgeInsets.symmetric(horizontal: 10),
                  child: pw.Column(children: [
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text("ANAMNESA DAN PEMERIKSAAN FISIK",
                              style: pw.TextStyle(
                                  fontSize: 16, fontWeight: pw.FontWeight.bold))
                        ]),
                    pw.SizedBox(height: 10),
                    pw.Row(children: [
                      pw.Container(
                          padding:
                              pw.EdgeInsets.only(left: 5, top: 2, bottom: 2),
                          width: 120,
                          height: 20,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(color: PdfColors.black)),
                          child: pw.Text("Nama",
                              style: pw.TextStyle(fontSize: 14))),
                      pw.Container(
                          padding:
                              pw.EdgeInsets.only(left: 5, top: 2, bottom: 2),
                          width: 120,
                          height: 20,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(color: PdfColors.black)),
                          child: pw.Text(widget.dataPasien['namaPasien'],
                              style: pw.TextStyle(fontSize: 14))),
                      pw.Container(
                          padding:
                              pw.EdgeInsets.only(left: 5, top: 2, bottom: 2),
                          width: 160,
                          height: 20,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(color: PdfColors.black)),
                          child: pw.Text("Tgl. Pemeriksaan",
                              style: pw.TextStyle(fontSize: 14))),
                      pw.Container(
                          padding:
                              pw.EdgeInsets.only(left: 5, top: 2, bottom: 2),
                          width: 160,
                          height: 20,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(color: PdfColors.black)),
                          child: pw.Text(
                              widget.dataPasien['tanggal_pemeriksaan'],
                              style: pw.TextStyle(fontSize: 14))),
                    ]),
                    pw.Row(children: [
                      pw.Container(
                          padding:
                              pw.EdgeInsets.only(left: 5, top: 2, bottom: 2),
                          width: 120,
                          height: 20,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(color: PdfColors.black)),
                          child: pw.Text("Jenis Kelamin",
                              style: pw.TextStyle(fontSize: 14))),
                      pw.Container(
                          padding:
                              pw.EdgeInsets.only(left: 5, top: 2, bottom: 2),
                          width: 120,
                          height: 20,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(color: PdfColors.black)),
                          child: pw.Text(widget.dataPasien['jenis_kelamin'],
                              style: pw.TextStyle(fontSize: 14))),
                      pw.Container(
                          padding:
                              pw.EdgeInsets.only(left: 5, top: 2, bottom: 2),
                          width: 160,
                          height: 20,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(color: PdfColors.black)),
                          child: pw.Text("TTL/Umur",
                              style: pw.TextStyle(fontSize: 14))),
                      pw.Container(
                          padding:
                              pw.EdgeInsets.only(left: 5, top: 2, bottom: 2),
                          width: 160,
                          height: 20,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(color: PdfColors.black)),
                          child: pw.Text(
                              widget.dataPasien['tanggal_lahir'] +
                                  "/" +
                                  "${widget.dataPasien['umur']}",
                              style: pw.TextStyle(fontSize: 14))),
                    ]),
                    pw.Row(children: [
                      pw.Container(
                          padding:
                              pw.EdgeInsets.only(left: 5, top: 2, bottom: 2),
                          width: 120,
                          height: 20,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(color: PdfColors.black)),
                          child: pw.Text("NIK",
                              style: pw.TextStyle(fontSize: 14))),
                      pw.Container(
                          padding:
                              pw.EdgeInsets.only(left: 5, top: 2, bottom: 2),
                          width: 120,
                          height: 20,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(color: PdfColors.black)),
                          child: pw.Text("${widget.dataPasien['NIK']}",
                              style: pw.TextStyle(fontSize: 14))),
                      pw.Container(
                          padding:
                              pw.EdgeInsets.only(left: 5, top: 2, bottom: 2),
                          width: 160,
                          height: 20,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(color: PdfColors.black)),
                          child: pw.Text("Perusahaan",
                              style: pw.TextStyle(fontSize: 14))),
                      pw.Container(
                          padding:
                              pw.EdgeInsets.only(left: 5, top: 2, bottom: 2),
                          width: 160,
                          height: 20,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(color: PdfColors.black)),
                          child: pw.Text(widget.dataPasien['perusahaan'],
                              style: pw.TextStyle(fontSize: 14))),
                    ]),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Container(
                              padding: pw.EdgeInsets.only(
                                  left: 5, top: 2, bottom: 2),
                              width: 120,
                              height: 60,
                              decoration: pw.BoxDecoration(
                                  border:
                                      pw.Border.all(color: PdfColors.black)),
                              child: pw.Text("Alamat",
                                  style: pw.TextStyle(fontSize: 14))),
                          pw.Container(
                              padding: pw.EdgeInsets.only(
                                  left: 5, top: 2, bottom: 2),
                              width: 120,
                              height: 60,
                              decoration: pw.BoxDecoration(
                                  border:
                                      pw.Border.all(color: PdfColors.black)),
                              child: pw.Text(widget.dataPasien['alamat'],
                                  style: pw.TextStyle(fontSize: 14))),
                          pw.Column(children: [
                            pw.Row(children: [
                              pw.Container(
                                  padding: pw.EdgeInsets.only(
                                      left: 5, top: 2, bottom: 2),
                                  width: 160,
                                  height: 20,
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                          color: PdfColors.black)),
                                  child: pw.Text("Bagian / Seksi",
                                      style: pw.TextStyle(fontSize: 14))),
                              pw.Container(
                                  padding: pw.EdgeInsets.only(
                                      left: 5, top: 2, bottom: 2),
                                  width: 160,
                                  height: 20,
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                          color: PdfColors.black)),
                                  child: pw.Text(widget.dataPasien['bagian'],
                                      style: pw.TextStyle(fontSize: 14))),
                            ]),
                            pw.Row(children: [
                              pw.Container(
                                  padding: pw.EdgeInsets.only(
                                      left: 5, top: 2, bottom: 2),
                                  width: 160,
                                  height: 20,
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                          color: PdfColors.black)),
                                  child: pw.Text("No HP",
                                      style: pw.TextStyle(fontSize: 14))),
                              pw.Container(
                                  padding: pw.EdgeInsets.only(
                                      left: 5, top: 2, bottom: 2),
                                  width: 160,
                                  height: 20,
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                          color: PdfColors.black)),
                                  child: pw.Text(widget.dataPasien['no_hp'],
                                      style: pw.TextStyle(fontSize: 14))),
                            ]),
                            pw.Row(children: [
                              pw.Container(
                                  padding: pw.EdgeInsets.only(
                                      left: 5, top: 2, bottom: 2),
                                  width: 160,
                                  height: 20,
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                          color: PdfColors.black)),
                                  child: pw.Text("No MCU",
                                      style: pw.TextStyle(fontSize: 14))),
                              pw.Container(
                                  padding: pw.EdgeInsets.only(
                                      left: 5, top: 2, bottom: 2),
                                  width: 160,
                                  height: 20,
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                          color: PdfColors.black)),
                                  child: pw.Text("",
                                      style: pw.TextStyle(fontSize: 14))),
                            ])
                          ])
                        ]),
                    pw.SizedBox(height: 10),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(width: 10),
                          pw.Text("I.",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(width: 20),
                          pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text("Riwayat Penyakit Terdahulu",
                                    style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.SizedBox(height: 10),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text("a. Darah tinggi",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(
                                      ": ${_penyakitTerdahulu!.darahTinggi ?? ""}",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text(
                                        "b. Penyakit paru (Asma, TBC dll)",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(": ${_penyakitTerdahulu!.paru ?? ""}",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text("c. Asam lambung",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(
                                      ": ${_penyakitTerdahulu!.asamLambung ?? ""}",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text("d. Alergi",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(
                                      ": ${_penyakitTerdahulu!.alergi ?? ""}",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text("e. Riwayat operasi",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(
                                      ": ${_penyakitTerdahulu!.riwayatOperasi ?? ""}",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text("f. Riwayat kecelakaan",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(
                                      ": ${_penyakitTerdahulu!.riwayatKecelakaan ?? ""}",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text("g. Riwayat rawat RS",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(
                                      ": ${_penyakitTerdahulu!.riwayatRawatRs ?? ""}",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text("h. Hepatitis",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(
                                      ": ${_penyakitTerdahulu!.hepatitis ?? ""}",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text("i. Kencing manis",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(
                                      ": ${_penyakitTerdahulu!.kencingManis ?? ""}",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text(
                                        "j. Patah tulang (terpasang PEN)",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(
                                      ": ${_penyakitTerdahulu!.patahTulang ?? ""}",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                              ])
                        ]),
                    pw.SizedBox(height: 10),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(width: 5),
                          pw.Text("II.",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(width: 20),
                          pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text("Riwayat Penyakit Keluarga (Orang Tua)",
                                    style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.SizedBox(height: 10),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text("a. Kencing manis",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(
                                      ": ${_penyakitKeluarga!.kencingManis}",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text("b. Darah tinggi",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(": ${_penyakitKeluarga!.darahTinggi}",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text("c. Asam lambung",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(": ${_penyakitKeluarga!.asamLambung}",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text("d. Alergi",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(": ${_penyakitKeluarga!.alergi}",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text(
                                        "e. Penyakit paru (Asma, TBC, dll)",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(": ${_penyakitKeluarga!.paru}",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text("f. Stroke",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(": ${_penyakitKeluarga!.stroke}",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text("g. Ginjal",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(": ${_penyakitKeluarga!.ginjal}",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text("h. Hemorrhoid",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(": ${_penyakitKeluarga!.hemorhoid}",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text("i. Kanker",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(": ${_penyakitKeluarga!.kanker}",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text("j. Jantung",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(": ${_penyakitKeluarga!.jantung}",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                              ])
                        ]),
                    pw.SizedBox(height: 10),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(width: 5),
                          pw.Text("III.",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(width: 15),
                          pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text("Riwayat Kebiasaan",
                                    style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.SizedBox(height: 10),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text("a. Merokok",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(": ${_riwayatKebiasaan!.strMerokok}",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text("   a). Lama",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(
                                      ": (${_riwayatKebiasaan!.merokok!.lama}) Tahun",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text("   b). Banyak",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(
                                      ": (${_riwayatKebiasaan!.merokok!.batang}) Batang/hari",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text("",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(
                                      ": (${_riwayatKebiasaan!.merokok!.bungkus}) Bungkus/hari",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text("b. Minum Miras",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(
                                      ": ${_riwayatKebiasaan!.miras != null ? 'Ya' : 'Tidak'}",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text("   a). Lama",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(
                                      ": (${_riwayatKebiasaan!.miras != null ? _riwayatKebiasaan!.miras!.lama : '-'}) Tahun",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text("   b). Banyak",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(
                                      ": (${_riwayatKebiasaan!.miras != null ? _riwayatKebiasaan!.miras!.gelas : '-'}) Gelas/hari",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text("",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(
                                      ": (${_riwayatKebiasaan!.miras != null ? _riwayatKebiasaan!.miras!.botol : '-'}) Botol/hari",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                                pw.Row(children: [
                                  pw.Container(
                                    width: 250,
                                    child: pw.Text("c. Olahraga",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ),
                                  pw.Text(
                                      ": ${_riwayatKebiasaan!.olahraga != null ? 'Ya' : 'Tidak'}",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.normal)),
                                ]),
                              ])
                        ]),
                  ]),
                ),
              ];
            }),
      );

      pdf.addPage(pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          maxPages: 20,
          margin: pw.EdgeInsets.all(0),
          header: (context) {
            return pw.Container(
              width: 1000,
              height: 80,
              margin: pw.EdgeInsets.only(bottom: 10),
              decoration: pw.BoxDecoration(),
              child: pw.ClipRRect(
                child: pw.Container(
                  child: pw.Image(
                    pw.MemoryImage(headerImage),
                    fit: pw.BoxFit.fill,
                  ),
                ),
              ),
            );
          },
          footer: (context) {
            return pw.Container(
              width: 1000,
              height: 80,
              decoration: pw.BoxDecoration(),
              child: pw.ClipRRect(
                child: pw.Container(
                  child: pw.Image(
                    pw.MemoryImage(footerImage),
                    fit: pw.BoxFit.fill,
                  ),
                ),
              ),
            );
          },
          build: (pw.Context context) {
            return [
              pw.Container(
                  padding: pw.EdgeInsets.symmetric(horizontal: 10),
                  child: pw.Column(children: [
                    pw.SizedBox(height: 10),
                    pw.Row(children: [
                      pw.SizedBox(width: 5),
                      pw.Text("IV.",
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(width: 15),
                      pw.Text("Keluhan Sekarang",
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.bold)),
                    ]),
                    pw.SizedBox(height: 10),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(width: 5),
                          pw.Text("A.",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(width: 15),
                          pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text("KEADAAN UMUM",
                                    style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text("1.",
                                          style: pw.TextStyle(
                                              fontSize: 14,
                                              fontWeight: pw.FontWeight.bold)),
                                      pw.SizedBox(width: 10),
                                      pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text("Pemeriksaan Umum",
                                                style: pw.TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        pw.FontWeight.bold)),
                                            pw.Row(
                                                mainAxisAlignment:
                                                    pw.MainAxisAlignment.start,
                                                children: [
                                                  pw.Container(
                                                    width: 200,
                                                    child: pw.Text(
                                                        "a. Tinggi Badan",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 100,
                                                    child: pw.Text(
                                                        ": ${_pemeriksaanUmum!.tinggiBadan}",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 100,
                                                    child: pw.Text("cm",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  )
                                                ]),
                                            pw.Row(
                                                mainAxisAlignment:
                                                    pw.MainAxisAlignment.start,
                                                children: [
                                                  pw.Container(
                                                    width: 200,
                                                    child: pw.Text(
                                                        "b. Berat Badan",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 100,
                                                    child: pw.Text(
                                                        ": ${_pemeriksaanUmum!.beratBadan}",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 100,
                                                    child: pw.Text("kg",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  )
                                                ]),
                                            pw.Row(
                                                mainAxisAlignment:
                                                    pw.MainAxisAlignment.start,
                                                children: [
                                                  pw.Container(
                                                    width: 200,
                                                    child: pw.Text(
                                                        "c. Berat Badan Ideal",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 100,
                                                    child: pw.Text(
                                                        ": ${_pemeriksaanUmum!.beratBadanIdeal}",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 100,
                                                    child: pw.Text("kg",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  )
                                                ]),
                                            pw.Row(
                                                mainAxisAlignment:
                                                    pw.MainAxisAlignment.start,
                                                children: [
                                                  pw.Container(
                                                    width: 200,
                                                    child: pw.Text("d. IMT",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 100,
                                                    child: pw.Text(
                                                        ": ${_pemeriksaanUmum!.imt}",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                ]),
                                            pw.Row(
                                                mainAxisAlignment:
                                                    pw.MainAxisAlignment.start,
                                                children: [
                                                  pw.Container(
                                                    width: 200,
                                                    child: pw.Text(
                                                        "e. Lingkaran Perut",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 100,
                                                    child: pw.Text(
                                                        ": ${_pemeriksaanUmum!.lingkarPerut}",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 100,
                                                    child: pw.Text("cm",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  )
                                                ]),
                                            pw.Row(
                                                mainAxisAlignment:
                                                    pw.MainAxisAlignment.start,
                                                children: [
                                                  pw.Container(
                                                    width: 200,
                                                    child: pw.Text(
                                                        "f. Tekanan Darah",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 100,
                                                    child: pw.Text(
                                                        ": ${_pemeriksaanUmum!.tekananDarah}",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 100,
                                                    child: pw.Text("mmHg",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  )
                                                ]),
                                            pw.Row(
                                                mainAxisAlignment:
                                                    pw.MainAxisAlignment.start,
                                                children: [
                                                  pw.Container(
                                                    width: 200,
                                                    child: pw.Text(
                                                        "g. Denyut Nadi",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 100,
                                                    child: pw.Text(
                                                        ": ${_pemeriksaanUmum!.denyutNadi}",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 100,
                                                    child: pw.Text("x/menit",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  )
                                                ]),
                                            pw.Row(
                                                mainAxisAlignment:
                                                    pw.MainAxisAlignment.start,
                                                children: [
                                                  pw.Container(
                                                    width: 200,
                                                    child: pw.Text(
                                                        "h. Frek. Pernafasan",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 100,
                                                    child: pw.Text(
                                                        ": ${_pemeriksaanUmum!.pernapasan}",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 100,
                                                    child: pw.Text("x/menit",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  )
                                                ]),
                                            pw.Row(
                                                mainAxisAlignment:
                                                    pw.MainAxisAlignment.start,
                                                children: [
                                                  pw.Container(
                                                    width: 200,
                                                    child: pw.Text("i. Suhu",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 100,
                                                    child: pw.Text(
                                                        ": ${_pemeriksaanUmum!.suhu}",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 100,
                                                    child: pw.Text("°C",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  )
                                                ]),
                                          ])
                                    ]),
                                pw.SizedBox(
                                  height: 10,
                                ),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text("2.",
                                          style: pw.TextStyle(
                                              fontSize: 14,
                                              fontWeight: pw.FontWeight.bold)),
                                      pw.SizedBox(width: 10),
                                      pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text("Pemeriksaan Mata",
                                                style: pw.TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        pw.FontWeight.bold)),
                                            pw.Row(
                                                mainAxisAlignment:
                                                    pw.MainAxisAlignment.start,
                                                children: [
                                                  pw.Container(
                                                    width: 200,
                                                    child: pw.Text(
                                                        "a. Berkaca mata",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 150,
                                                    child: pw.Text(
                                                        ": ${_pemeriksaanMata!.kacaMata}",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    child: pw.Text(
                                                        "(${_pemeriksaanMata!.kondisi})",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  )
                                                ]),
                                            pw.Row(
                                                mainAxisAlignment:
                                                    pw.MainAxisAlignment.start,
                                                children: [
                                                  pw.Container(
                                                    width: 200,
                                                    child: pw.Text(
                                                        "b. Visus      Os(kiri)",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 150,
                                                    child: pw.Text(
                                                        ": ${_pemeriksaanMata!.visusKiri}",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    child: pw.Text(
                                                        "(Tanpa lensa koreksi)",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  )
                                                ]),
                                            pw.Row(
                                                mainAxisAlignment:
                                                    pw.MainAxisAlignment.start,
                                                children: [
                                                  pw.Container(
                                                    width: 200,
                                                    child: pw.Text(
                                                        "                   Os(kanan)",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 150,
                                                    child: pw.Text(
                                                        ": ${_pemeriksaanMata!.visusKanan}",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    child: pw.Text(
                                                        "(Tanpa lensa koreksi)",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  )
                                                ]),
                                            pw.Row(
                                                mainAxisAlignment:
                                                    pw.MainAxisAlignment.start,
                                                children: [
                                                  pw.Container(
                                                    width: 200,
                                                    child: pw.Text(
                                                        "c. Buta Warna",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 150,
                                                    child: pw.Text(
                                                        ": ${_pemeriksaanMata!.butaWarna}",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                ]),
                                            pw.Row(
                                                mainAxisAlignment:
                                                    pw.MainAxisAlignment.start,
                                                children: [
                                                  pw.Container(
                                                    width: 200,
                                                    child: pw.Text(
                                                        "d. Penyakit Mata",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 150,
                                                    child: pw.Text(
                                                        ": ${_pemeriksaanMata!.penyakitMata}",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                ]),
                                            pw.Row(
                                                mainAxisAlignment:
                                                    pw.MainAxisAlignment.start,
                                                children: [
                                                  pw.Container(
                                                    width: 200,
                                                    child: pw.Text(
                                                        "e. Konjungtiva",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 150,
                                                    child: pw.Text(
                                                        ": ${_pemeriksaanMata!.konjungtiva}",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                ]),
                                            pw.Row(
                                                mainAxisAlignment:
                                                    pw.MainAxisAlignment.start,
                                                children: [
                                                  pw.Container(
                                                    width: 200,
                                                    child: pw.Text("f. Sklera",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 150,
                                                    child: pw.Text(
                                                        ": ${_pemeriksaanMata!.sklera}",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                ]),
                                          ])
                                    ]),
                                pw.SizedBox(
                                  height: 10,
                                ),
                              ])
                        ]),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(width: 35),
                          pw.Text("3.",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(width: 10),
                          pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                    "Pemeriksaan Telinga, Hidung dan Tenggorokan",
                                    style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text("a.",
                                          style: pw.TextStyle(
                                              fontSize: 12,
                                              fontWeight: pw.FontWeight.bold)),
                                      pw.SizedBox(width: 10),
                                      pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text("Telinga",
                                                style: pw.TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        pw.FontWeight.bold)),
                                            pw.Row(
                                                mainAxisAlignment:
                                                    pw.MainAxisAlignment.start,
                                                children: [
                                                  pw.Container(
                                                    width: 200,
                                                    child: pw.Text(
                                                        "(a) Membran tymp kiri",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 150,
                                                    child: pw.Text(
                                                        ": ${_pemeriksaanTHT!.telinga!.membranTympKiri}",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                ]),
                                            pw.Row(
                                                mainAxisAlignment:
                                                    pw.MainAxisAlignment.start,
                                                children: [
                                                  pw.Container(
                                                    width: 200,
                                                    child: pw.Text(
                                                        "(b) Membran tymp kanan",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 150,
                                                    child: pw.Text(
                                                        ": ${_pemeriksaanTHT!.telinga!.membranTympKanan}",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                ]),
                                            pw.Row(
                                                mainAxisAlignment:
                                                    pw.MainAxisAlignment.start,
                                                children: [
                                                  pw.Container(
                                                    width: 200,
                                                    child: pw.Text(
                                                        "(c) Penyakit telinga kiri",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 150,
                                                    child: pw.Text(
                                                        ": ${_pemeriksaanTHT!.telinga!.penyakitTelingaKiri}",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Text(
                                                      "Serumen : ${_pemeriksaanTHT!.telinga!.serumenKiri}",
                                                      style: pw.TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .normal)),
                                                ]),
                                            pw.Row(
                                                mainAxisAlignment:
                                                    pw.MainAxisAlignment.start,
                                                children: [
                                                  pw.Container(
                                                    width: 200,
                                                    child: pw.Text(
                                                        "(d) Penyakit telinga kanan",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 150,
                                                    child: pw.Text(
                                                        ": ${_pemeriksaanTHT!.telinga!.penyakitTelingaKanan}",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Text(
                                                      "Serumen : ${_pemeriksaanTHT!.telinga!.serumenKanan}",
                                                      style: pw.TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .normal)),
                                                ]),
                                          ])
                                    ]),
                              ])
                        ]),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(width: 60),
                          pw.Text("b.",
                              style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(width: 10),
                          pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text("Hidung",
                                    style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text("(a) Pilek / tersumbat",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text(
                                            ": ${_pemeriksaanTHT!.hidung!.pilekTersumbat}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text("(b) Lidah",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text(
                                            ": ${_pemeriksaanTHT!.hidung!.lidah}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text("(c) Lain-lain",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text(
                                            ": ${_pemeriksaanTHT!.hidung!.lainLain}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                    ])
                              ]),
                        ]),
                    pw.SizedBox(height: 10),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(width: 60),
                          pw.Text("c.",
                              style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(width: 10),
                          pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text("Kerongkongan",
                                    style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text("(a) Tonsil kanan",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text(
                                            ": ${_pemeriksaanTHT!.kerongkongan!.tonsilKanan}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text("(b) Tonsil kiri",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text(
                                            ": ${_pemeriksaanTHT!.kerongkongan!.tonsilKiri}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text("(c) Pharing",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text(
                                            ": ${_pemeriksaanTHT!.kerongkongan!.pharing}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text("(d) Tiroid  ",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text(
                                            ": ${_pemeriksaanTHT!.kerongkongan!.tiroid}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text("(e) Lain-lain",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text(
                                            ": ${_pemeriksaanTHT!.kerongkongan!.lainLain}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                    ]),
                              ]),
                        ]),
                    pw.SizedBox(height: 10),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(width: 35),
                          pw.Text("4.",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(width: 10),
                          pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text("Pemeriksaan Rongga Dada",
                                    style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text("a.",
                                          style: pw.TextStyle(
                                              fontSize: 12,
                                              fontWeight: pw.FontWeight.bold)),
                                      pw.SizedBox(width: 10),
                                      pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text("Jantung",
                                                style: pw.TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        pw.FontWeight.bold)),
                                            pw.Row(
                                                mainAxisAlignment:
                                                    pw.MainAxisAlignment.start,
                                                children: [
                                                  pw.Container(
                                                    width: 150,
                                                    child: pw.Text(
                                                        "(a) Batas-batas Jantung",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Container(
                                                    width: 150,
                                                    child: pw.Text(
                                                        ": ${_pemeriksaanRonggaDada!.jantung!.batasBatasJantung}",
                                                        style: pw.TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .normal)),
                                                  ),
                                                  pw.Text(
                                                      "Iktus Kordis :${_pemeriksaanRonggaDada!.jantung!.iktusKordis}",
                                                      style: pw.TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .normal)),
                                                ]),
                                          ])
                                    ]),
                              ])
                        ]),
                  ]))
            ];
          }));

      pdf.addPage(pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          maxPages: 20,
          margin: pw.EdgeInsets.all(0),
          header: (context) {
            return pw.Container(
              width: 1000,
              height: 80,
              margin: pw.EdgeInsets.only(bottom: 10),
              decoration: pw.BoxDecoration(),
              child: pw.ClipRRect(
                child: pw.Container(
                  child: pw.Image(
                    pw.MemoryImage(headerImage),
                    fit: pw.BoxFit.fill,
                  ),
                ),
              ),
            );
          },
          footer: (context) {
            return pw.Container(
              width: 1000,
              height: 80,
              decoration: pw.BoxDecoration(),
              child: pw.ClipRRect(
                child: pw.Container(
                  child: pw.Image(
                    pw.MemoryImage(footerImage),
                    fit: pw.BoxFit.fill,
                  ),
                ),
              ),
            );
          },
          build: (pw.Context context) {
            return [
              pw.Container(
                  padding: pw.EdgeInsets.symmetric(horizontal: 10),
                  child: pw.Column(children: [
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(width: 59),
                          pw.Text("b.",
                              style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(width: 10),
                          pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text("Paru",
                                    style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 120,
                                        child: pw.Text("(a) Inspeksi",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text(
                                            "Kanan : ${_pemeriksaanRonggaDada!.paru!.inspeksiKanan}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Text(
                                          "Kiri : ${_pemeriksaanRonggaDada!.paru!.inspeksiKiri}",
                                          style: pw.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pw.FontWeight.normal)),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 120,
                                        child: pw.Text("(b) Palpasi",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text(
                                            "Kanan : ${_pemeriksaanRonggaDada!.paru!.palpasiKanan}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Text(
                                          "Kiri : ${_pemeriksaanRonggaDada!.paru!.palpasiKiri}",
                                          style: pw.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pw.FontWeight.normal)),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 120,
                                        child: pw.Text("(c) Perkusi",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text(
                                            "Kanan : ${_pemeriksaanRonggaDada!.paru!.perkusiKanan}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Text(
                                          "Kiri : ${_pemeriksaanRonggaDada!.paru!.perkusiKiri}",
                                          style: pw.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pw.FontWeight.normal)),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 120,
                                        child: pw.Text("(d) Auskultasi",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text(
                                            "Kanan : ${_pemeriksaanRonggaDada!.paru!.auskultasiKanan}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Text(
                                          "Kiri : ${_pemeriksaanRonggaDada!.paru!.auskultasiKiri}",
                                          style: pw.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pw.FontWeight.normal)),
                                    ]),
                              ])
                        ]),
                    pw.SizedBox(height: 10),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(width: 35),
                          pw.Text("5.",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(width: 10),
                          pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text("Pemeriksaan Rongga Perut",
                                    style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text("a. Inspeksi",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text(
                                            ": ${_pemeriksaanRonggaPerut!.inspeksi}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text("b. Perkusi",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text(
                                            ": ${_pemeriksaanRonggaPerut!.perkusi}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text("c. Auskultasi",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text(
                                            ": ${_pemeriksaanRonggaPerut!.auskultasi}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text("d. Hati",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text(
                                            ": ${_pemeriksaanRonggaPerut!.hati}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text("e. Limpa",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text(
                                            ": ${_pemeriksaanRonggaPerut!.limpa}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text("f. Ginjal Kiri",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text(
                                            ": ${_pemeriksaanRonggaPerut!.ginjalKiri}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text(
                                            "Ballotement : ${_pemeriksaanRonggaPerut!.ballotementKiri}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      )
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text("g. Ginjal Kanan",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text(
                                            ": ${_pemeriksaanRonggaPerut!.ginjalKanan}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text(
                                            "Ballotement : ${_pemeriksaanRonggaPerut!.ballotementKanan}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      )
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text("h. Hernia",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text(
                                            ": ${_pemeriksaanRonggaPerut!.hernia}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text("i. Tumor",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text(
                                            ": ${_pemeriksaanRonggaPerut!.tumor}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text("j. Lain - lain",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text(
                                            ": ${_pemeriksaanRonggaPerut!.lainLain}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                    ]),
                              ])
                        ]),
                    pw.SizedBox(height: 10),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(width: 35),
                          pw.Text("6.",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(width: 10),
                          pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text("Pemeriksaan Gentalia dan Anorektal",
                                    style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text("a. Hernia",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text(
                                            ": ${_pemeriksaanGentalia!.hernia}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text("b. Haemorhoid",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text(
                                            ": ${_pemeriksaanGentalia!.hemorhoid}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text("c. Sikatriks",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text(
                                            ": ${_pemeriksaanGentalia!.sikatriks}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text("d. Spincter",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text(
                                            ": ${_pemeriksaanGentalia!.spincter}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text("e. Untuk laki-laki",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text("",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text(
                                            "   - Efidymis/testis/prostat",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text(
                                            ": ${_pemeriksaanGentalia!.efidymisTestisProstat}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text("   - Ekskresi",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text(
                                            ": ${_pemeriksaanGentalia!.ekskresi}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                    ]),
                              ])
                        ]),
                    pw.SizedBox(height: 10),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(width: 35),
                          pw.Text("7.",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(width: 10),
                          pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text("Pemeriksaan Anggota Gerak",
                                    style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text("a. Atas kiri / kanan",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text(
                                            "Kanan : ${_pemeriksaanAnggotaGerak!.atasKanan}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Text(
                                          "Kiri : ${_pemeriksaanAnggotaGerak!.atasKiri}",
                                          style: pw.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pw.FontWeight.normal)),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text("b. Bawah kiri / kanan",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text(
                                            "Kanan : ${_pemeriksaanAnggotaGerak!.bawahKanan}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Text(
                                          "Kiri : ${_pemeriksaanAnggotaGerak!.bawahKiri}",
                                          style: pw.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pw.FontWeight.normal)),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text("c. Sembab/Oedem",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text(
                                            "Kanan : ${_pemeriksaanAnggotaGerak!.sembabOedemKanan}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Text(
                                          "Kiri : ${_pemeriksaanAnggotaGerak!.sembabOedemKiri}",
                                          style: pw.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pw.FontWeight.normal)),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text("d. Cacat",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text(
                                            "Kanan : ${_pemeriksaanAnggotaGerak!.cacatKanan}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Text(
                                          "Kiri : ${_pemeriksaanAnggotaGerak!.cacatKiri}",
                                          style: pw.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pw.FontWeight.normal)),
                                    ]),
                              ])
                        ]),
                    pw.SizedBox(height: 10),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(width: 35),
                          pw.Text("8.",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(width: 10),
                          pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text("Pemeriksaan Refleks",
                                    style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.end,
                                    children: [
                                      pw.SizedBox(width: 340),
                                      pw.Container(
                                        width: 65,
                                        child: pw.Text("Kanan",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 50,
                                        child: pw.Text("Kiri",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 70,
                                        child: pw.Text("a. Pupil",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text(
                                            ": ${_pemeriksaanRefleks!.pupil!.pupil}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 80,
                                        child: pw.Text("Biceps",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 50,
                                        child: pw.Text(":",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 55,
                                        child: pw.Text(
                                            "${_pemeriksaanRefleks!.pupil!.bicepsKanan}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.bold)),
                                      ),
                                      pw.Container(
                                        width: 50,
                                        child: pw.Text(
                                            "${_pemeriksaanRefleks!.pupil!.bicepsKiri}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.bold)),
                                      ),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 70,
                                        child: pw.Text("b. Patella",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text(
                                            ": ${_pemeriksaanRefleks!.patella!.patella}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 80,
                                        child: pw.Text("Triceps",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 50,
                                        child: pw.Text(":",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 55,
                                        child: pw.Text(
                                            "${_pemeriksaanRefleks!.patella!.tricepsKanan}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.bold)),
                                      ),
                                      pw.Container(
                                        width: 50,
                                        child: pw.Text(
                                            "${_pemeriksaanRefleks!.patella!.tricepsKiri}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.bold)),
                                      ),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 70,
                                        child: pw.Text("c. Achiles",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text(
                                            ": ${_pemeriksaanRefleks!.achilles!.acciles}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 80,
                                        child: pw.Text("Babinsky",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 50,
                                        child: pw.Text(":",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 55,
                                        child: pw.Text(
                                            "${_pemeriksaanRefleks!.achilles!.babinskiKanan}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.bold)),
                                      ),
                                      pw.Container(
                                        width: 50,
                                        child: pw.Text(
                                            "${_pemeriksaanRefleks!.achilles!.babinskiKiri}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.bold)),
                                      ),
                                    ]),
                              ])
                        ]),
                    pw.SizedBox(height: 10),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(width: 35),
                          pw.Text("9.",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(width: 10),
                          pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text("Pemeriksaan Kelenjar Getah Bening",
                                    style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text("a. Cervical",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text(
                                            "Kanan : ${_pemeriksaanKelenjarGetah!.cervicalKanan}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Text(
                                          "Kiri : ${_pemeriksaanKelenjarGetah!.cervicalKiri}",
                                          style: pw.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pw.FontWeight.normal)),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text("b. Axila",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text(
                                            "Kanan : ${_pemeriksaanKelenjarGetah!.axilaKanan}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Text(
                                          "Kiri : ${_pemeriksaanKelenjarGetah!.axilaKiri}",
                                          style: pw.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pw.FontWeight.normal)),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text("c. Supra Clavicula",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text(
                                            "Kanan : ${_pemeriksaanKelenjarGetah!.supraclaviculaKanan}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Text(
                                          "Kiri : ${_pemeriksaanKelenjarGetah!.supraclaviculaKiri}",
                                          style: pw.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pw.FontWeight.normal)),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text("d. Infra Clavicula",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text(
                                            "Kanan : ${_pemeriksaanKelenjarGetah!.infraclaviculaKanan}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Text(
                                          "Kiri : ${_pemeriksaanKelenjarGetah!.infraclaviculaKiri}",
                                          style: pw.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pw.FontWeight.normal)),
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        width: 150,
                                        child: pw.Text("e. Inguinal",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Container(
                                        width: 200,
                                        child: pw.Text(
                                            "Kanan : ${_pemeriksaanKelenjarGetah!.inguinalKanan}",
                                            style: pw.TextStyle(
                                                fontSize: 12,
                                                fontWeight:
                                                    pw.FontWeight.normal)),
                                      ),
                                      pw.Text(
                                          "Kiri : ${_pemeriksaanKelenjarGetah!.inguinalKiri}",
                                          style: pw.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pw.FontWeight.normal)),
                                    ]),
                              ])
                        ]),
                    pw.SizedBox(height: 10),
                  ]))
            ];
          }));

      pdf.addPage(pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          maxPages: 20,
          margin: pw.EdgeInsets.all(0),
          header: (context) {
            return pw.Container(
              width: 1000,
              height: 80,
              margin: pw.EdgeInsets.only(bottom: 10),
              decoration: pw.BoxDecoration(),
              child: pw.ClipRRect(
                child: pw.Container(
                  child: pw.Image(
                    pw.MemoryImage(headerImage),
                    fit: pw.BoxFit.fill,
                  ),
                ),
              ),
            );
          },
          footer: (context) {
            return pw.Container(
              width: 1000,
              height: 80,
              decoration: pw.BoxDecoration(),
              child: pw.ClipRRect(
                child: pw.Container(
                  child: pw.Image(
                    pw.MemoryImage(footerImage),
                    fit: pw.BoxFit.fill,
                  ),
                ),
              ),
            );
          },
          build: (pw.Context context) {
            return [
              pw.Container(
                  padding: pw.EdgeInsets.symmetric(horizontal: 10),
                  child: pw.Column(children: [
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(width: 5),
                          pw.Text("A.",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(width: 15),
                          pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text("Riwayat Pajanan Pada Pekerjaan",
                                    style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text("1.",
                                          style: pw.TextStyle(
                                              fontSize: 14,
                                              fontWeight: pw.FontWeight.bold)),
                                      pw.SizedBox(width: 15),
                                      pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text("Fisik",
                                                style: pw.TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        pw.FontWeight.bold)),
                                            pw.Row(children: [
                                              pw.SizedBox(width: 10),
                                              pw.Container(
                                                width: 350,
                                                child: pw.Text("a. Kebisingan",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ),
                                              pw.Text(": ${_fisik!.kebisingan}",
                                                  style: pw.TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: pw
                                                          .FontWeight.normal)),
                                            ]),
                                            pw.Row(children: [
                                              pw.SizedBox(width: 10),
                                              pw.Container(
                                                width: 350,
                                                child: pw.Text("b. Suhu Panas",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ),
                                              pw.Text(": ${_fisik!.suhuPanas}",
                                                  style: pw.TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: pw
                                                          .FontWeight.normal)),
                                            ]),
                                            pw.Row(children: [
                                              pw.SizedBox(width: 10),
                                              pw.Container(
                                                width: 350,
                                                child: pw.Text("c. Suhu Dingin",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ),
                                              pw.Text(": ${_fisik!.suhuDingin}",
                                                  style: pw.TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: pw
                                                          .FontWeight.normal)),
                                            ]),
                                            pw.Row(children: [
                                              pw.SizedBox(width: 10),
                                              pw.Container(
                                                width: 350,
                                                child: pw.Text(
                                                    "d. Radiasi bukan pengion (gel mikro, infrared, medan listrik, dll)",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ),
                                              pw.Text(
                                                  ": ${_fisik!.radiasiBukanPengion}",
                                                  style: pw.TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: pw
                                                          .FontWeight.normal)),
                                            ]),
                                            pw.Row(children: [
                                              pw.SizedBox(width: 10),
                                              pw.Container(
                                                width: 350,
                                                child: pw.Text(
                                                    "e. Radiasi pengion (sinar X, Gamma, dll)",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ),
                                              pw.Text(
                                                  ": ${_fisik!.radiasiPengion}",
                                                  style: pw.TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: pw
                                                          .FontWeight.normal)),
                                            ]),
                                            pw.Row(children: [
                                              pw.SizedBox(width: 10),
                                              pw.Container(
                                                width: 350,
                                                child: pw.Text(
                                                    "f. Getaran lokal",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ),
                                              pw.Text(
                                                  ": ${_fisik!.getaranLokal}",
                                                  style: pw.TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: pw
                                                          .FontWeight.normal)),
                                            ]),
                                            pw.Row(children: [
                                              pw.SizedBox(width: 10),
                                              pw.Container(
                                                width: 350,
                                                child: pw.Text(
                                                    "g. Getaran seluruh tubuh",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ),
                                              pw.Text(
                                                  ": ${_fisik!.getaranSeluruhTubuh}",
                                                  style: pw.TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: pw
                                                          .FontWeight.normal)),
                                            ]),
                                            pw.Row(children: [
                                              pw.SizedBox(width: 10),
                                              pw.Container(
                                                width: 350,
                                                child: pw.Text("h. Ketinggian ",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ),
                                              pw.Text(": ${_fisik!.ketinggian}",
                                                  style: pw.TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: pw
                                                          .FontWeight.normal)),
                                            ]),
                                            pw.Row(children: [
                                              pw.SizedBox(width: 10),
                                              pw.Container(
                                                width: 350,
                                                child: pw.Text("i. Lain-lain",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ),
                                              pw.Text(": ${_fisik!.lainLain}",
                                                  style: pw.TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: pw
                                                          .FontWeight.normal)),
                                            ]),
                                          ])
                                    ]),
                                pw.SizedBox(
                                  height: 10,
                                ),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text("2.",
                                          style: pw.TextStyle(
                                              fontSize: 14,
                                              fontWeight: pw.FontWeight.bold)),
                                      pw.SizedBox(width: 15),
                                      pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text("Kimia",
                                                style: pw.TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        pw.FontWeight.bold)),
                                            pw.Row(children: [
                                              pw.SizedBox(width: 10),
                                              pw.Container(
                                                width: 350,
                                                child: pw.Text(
                                                    "a. Debu anorganik (silika, semen, dll)",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ),
                                              pw.Text(
                                                  ": ${_kimia!.debuAnorganik ?? ""}",
                                                  style: pw.TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: pw
                                                          .FontWeight.normal)),
                                            ]),
                                            pw.Row(children: [
                                              pw.SizedBox(width: 10),
                                              pw.Container(
                                                width: 350,
                                                child: pw.Text(
                                                    "b. Debu organik (kapas,tekstil,gandum)",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ),
                                              pw.Text(
                                                  ": ${_kimia!.debuOrganik ?? ""}",
                                                  style: pw.TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: pw
                                                          .FontWeight.normal)),
                                            ]),
                                            pw.Row(children: [
                                              pw.SizedBox(width: 10),
                                              pw.Container(
                                                width: 350,
                                                child: pw.Text("c. Asap",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ),
                                              pw.Text(": ${_kimia!.asap ?? ""}",
                                                  style: pw.TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: pw
                                                          .FontWeight.normal)),
                                            ]),
                                            pw.Row(children: [
                                              pw.SizedBox(width: 10),
                                              pw.Container(
                                                width: 350,
                                                child: pw.Text(
                                                    "d. Bahan Kimia berbahaya",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ),
                                              pw.Text(
                                                  ": ${_kimia!.logamBerat != null ? "Ya" : "Tidak"}",
                                                  style: pw.TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: pw
                                                          .FontWeight.normal)),
                                            ]),
                                            pw.Row(children: [
                                              pw.SizedBox(width: 20),
                                              pw.Container(
                                                width: 340,
                                                child: pw.Text(
                                                    "- Logam berat (Timah Hitam, Air Raksa, dll)",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ),
                                              pw.Text(
                                                  ": ${_kimia!.logamBerat ?? ""}",
                                                  style: pw.TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: pw
                                                          .FontWeight.normal)),
                                            ]),
                                            pw.Row(children: [
                                              pw.SizedBox(width: 20),
                                              pw.Container(
                                                width: 340,
                                                child: pw.Text(
                                                    "- Pelarut organik (Benzene, Alkil, Toluen, dll)",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ),
                                              pw.Text(
                                                  ": ${_kimia!.pelarutOrganik ?? ""}",
                                                  style: pw.TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: pw
                                                          .FontWeight.normal)),
                                            ]),
                                            pw.Row(children: [
                                              pw.SizedBox(width: 20),
                                              pw.Container(
                                                width: 340,
                                                child: pw.Text(
                                                    "- Iritan asam (Air keras, Asam Sulfat) ",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ),
                                              pw.Text(
                                                  ": ${_kimia!.iritanAsam ?? ""}",
                                                  style: pw.TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: pw
                                                          .FontWeight.normal)),
                                            ]),
                                            pw.Row(children: [
                                              pw.SizedBox(width: 20),
                                              pw.Container(
                                                width: 340,
                                                child: pw.Text(
                                                    "- Iritan basa (Amoniak, Soda api) ",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ),
                                              pw.Text(
                                                  ": ${_kimia!.iritanBasa ?? ""}",
                                                  style: pw.TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: pw
                                                          .FontWeight.normal)),
                                            ]),
                                            pw.Row(children: [
                                              pw.SizedBox(width: 20),
                                              pw.Container(
                                                width: 340,
                                                child: pw.Text(
                                                    "- Cairan pembersih (Amonia, Klor, Kaporit)",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ),
                                              pw.Text(
                                                  ": ${_kimia!.cairanPembersih ?? ""}",
                                                  style: pw.TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: pw
                                                          .FontWeight.normal)),
                                            ]),
                                            pw.Row(children: [
                                              pw.SizedBox(width: 20),
                                              pw.Container(
                                                width: 340,
                                                child: pw.Text("- Pestisida",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ),
                                              pw.Text(
                                                  ": ${_kimia!.pestisida ?? ""}",
                                                  style: pw.TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: pw
                                                          .FontWeight.normal)),
                                            ]),
                                            pw.Row(children: [
                                              pw.SizedBox(width: 20),
                                              pw.Container(
                                                width: 340,
                                                child: pw.Text(
                                                    "- Uap Logam (Mangan, Seng)",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ),
                                              pw.Text(
                                                  ": ${_kimia!.uapLogam ?? ""}",
                                                  style: pw.TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: pw
                                                          .FontWeight.normal)),
                                            ]),
                                            pw.Row(children: [
                                              pw.SizedBox(width: 20),
                                              pw.Container(
                                                width: 340,
                                                child: pw.Text("- Lain-lain",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ),
                                              pw.Text(
                                                  ": ${_kimia!.lainLain ?? ""}",
                                                  style: pw.TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: pw
                                                          .FontWeight.normal)),
                                            ]),
                                          ])
                                    ]),
                                pw.SizedBox(height: 10),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text("3.",
                                          style: pw.TextStyle(
                                              fontSize: 14,
                                              fontWeight: pw.FontWeight.bold)),
                                      pw.SizedBox(width: 15),
                                      pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text("Biologi",
                                                style: pw.TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        pw.FontWeight.bold)),
                                            pw.Row(children: [
                                              pw.SizedBox(width: 10),
                                              pw.Container(
                                                width: 350,
                                                child: pw.Text(
                                                    "a. Bakteri / Virus / Jamur / Parasit",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ),
                                              pw.Text(
                                                  ": ${_biologi!.bakteri ?? ""}",
                                                  style: pw.TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: pw
                                                          .FontWeight.normal)),
                                            ]),
                                            pw.Row(children: [
                                              pw.SizedBox(width: 10),
                                              pw.Container(
                                                width: 350,
                                                child: pw.Text(
                                                    "b. Darah / cairan tubuh lain",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ),
                                              pw.Text(
                                                  ": ${_biologi!.darah ?? ""}",
                                                  style: pw.TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: pw
                                                          .FontWeight.normal)),
                                            ]),
                                            pw.Row(children: [
                                              pw.SizedBox(width: 10),
                                              pw.Container(
                                                width: 350,
                                                child: pw.Text(
                                                    "c. Nyamuk / serangga / lain-lain",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ),
                                              pw.Text(
                                                  ": ${_biologi!.nyamuk ?? ""}",
                                                  style: pw.TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: pw
                                                          .FontWeight.normal)),
                                            ]),
                                            pw.Row(children: [
                                              pw.SizedBox(width: 10),
                                              pw.Container(
                                                width: 350,
                                                child: pw.Text(
                                                    "d. Limbah (kotoran manusia / hewan)",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ),
                                              pw.Text(
                                                  ": ${_biologi!.limbah ?? ""}",
                                                  style: pw.TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: pw
                                                          .FontWeight.normal)),
                                            ]),
                                            pw.Row(children: [
                                              pw.SizedBox(width: 10),
                                              pw.Container(
                                                width: 350,
                                                child: pw.Text("e. . Lain-lain",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ),
                                              pw.Text(
                                                  ": ${_biologi!.lainLain ?? ""}",
                                                  style: pw.TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: pw
                                                          .FontWeight.normal)),
                                            ]),
                                          ])
                                    ]),
                                pw.SizedBox(height: 10),
                                pw.Row(children: [
                                  pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text("4.",
                                            style: pw.TextStyle(
                                                fontSize: 14,
                                                fontWeight:
                                                    pw.FontWeight.bold)),
                                        pw.SizedBox(width: 15),
                                        pw.Column(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text("Psikologis",
                                                  style: pw.TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          pw.FontWeight.bold)),
                                              pw.Row(children: [
                                                pw.SizedBox(width: 10),
                                                pw.Container(
                                                  width: 350,
                                                  child: pw.Text(
                                                      "a. Beban Kerja tidak sesuai dengan waktu & jumlah pekerjaan",
                                                      style: pw.TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .normal)),
                                                ),
                                                pw.Text(
                                                    ": ${_psikologi!.bebanKerja ?? ""}",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ]),
                                              pw.Row(children: [
                                                pw.SizedBox(width: 10),
                                                pw.Container(
                                                  width: 350,
                                                  child: pw.Text(
                                                      "b. Pekerjaan tidak sesuai dengan pengetahuan dan keterampilan",
                                                      style: pw.TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .normal)),
                                                ),
                                                pw.Text(
                                                    ": ${_psikologi!.pekerjaanTidakSesuai ?? ""}",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ]),
                                              pw.Row(children: [
                                                pw.SizedBox(width: 10),
                                                pw.Container(
                                                  width: 350,
                                                  child: pw.Text(
                                                      "c. Ketidakjelasan tugas",
                                                      style: pw.TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .normal)),
                                                ),
                                                pw.Text(
                                                    ": ${_psikologi!.ketidakjelasanTugas ?? ""}",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ]),
                                              pw.Row(children: [
                                                pw.SizedBox(width: 10),
                                                pw.Container(
                                                  width: 350,
                                                  child: pw.Text(
                                                      "d. Hambatan jenjang karir ",
                                                      style: pw.TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .normal)),
                                                ),
                                                pw.Text(
                                                    ": ${_psikologi!.hamabatanJenjangKarir ?? ""}",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ]),
                                              pw.Row(children: [
                                                pw.SizedBox(width: 10),
                                                pw.Container(
                                                  width: 350,
                                                  child: pw.Text(
                                                      "e. Bekerja giliran (shift) ",
                                                      style: pw.TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .normal)),
                                                ),
                                                pw.Text(
                                                    ": ${_psikologi!.shift ?? ""}",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ]),
                                              pw.Row(children: [
                                                pw.SizedBox(width: 10),
                                                pw.Container(
                                                  width: 350,
                                                  child: pw.Text(
                                                      "f. Konflik dengan teman sekerja",
                                                      style: pw.TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .normal)),
                                                ),
                                                pw.Text(
                                                    ": ${_psikologi!.konflikRekanKerja ?? ""}",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ]),
                                              pw.Row(children: [
                                                pw.SizedBox(width: 10),
                                                pw.Container(
                                                  width: 350,
                                                  child: pw.Text(
                                                      "g. Konflik dalam keluarga",
                                                      style: pw.TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .normal)),
                                                ),
                                                pw.Text(
                                                    ": ${_psikologi!.konflikKeluarga ?? ""}",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ]),
                                              pw.Row(children: [
                                                pw.SizedBox(width: 10),
                                                pw.Container(
                                                  width: 350,
                                                  child: pw.Text(
                                                      "h. Lain-lain ",
                                                      style: pw.TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .normal)),
                                                ),
                                                pw.Text(
                                                    ": ${_psikologi!.lainLain ?? ""}",
                                                    style: pw.TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: pw
                                                            .FontWeight
                                                            .normal)),
                                              ]),
                                            ])
                                      ]),
                                ]),
                              ])
                        ]),
                    pw.SizedBox(height: 10),
                    pw.Row(children: [
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.SizedBox(width: 35),
                            pw.Text("5.",
                                style: pw.TextStyle(
                                    fontSize: 14,
                                    fontWeight: pw.FontWeight.bold)),
                            pw.SizedBox(width: 15),
                            pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text("Ergonomis",
                                      style: pw.TextStyle(
                                          fontSize: 14,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Row(children: [
                                    pw.SizedBox(width: 10),
                                    pw.Container(
                                      width: 350,
                                      child: pw.Text(
                                          "a. Gerakan berulang dengan tangan",
                                          style: pw.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pw.FontWeight.normal)),
                                    ),
                                    pw.Text(
                                        ": ${_ergonomis!.gerakanBerulang ?? ""}",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ]),
                                  pw.Row(children: [
                                    pw.SizedBox(width: 10),
                                    pw.Container(
                                      width: 350,
                                      child: pw.Text(
                                          "b. Angkat / angkut berat ",
                                          style: pw.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pw.FontWeight.normal)),
                                    ),
                                    pw.Text(
                                        ": ${_ergonomis!.angkatBerat ?? ""}",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ]),
                                  pw.Row(children: [
                                    pw.SizedBox(width: 10),
                                    pw.Container(
                                      width: 350,
                                      child: pw.Text(
                                          "c. Duduk lama > 4 jam terus menerus",
                                          style: pw.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pw.FontWeight.normal)),
                                    ),
                                    pw.Text(": ${_ergonomis!.dudukLama ?? ""}",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ]),
                                ])
                          ]),
                    ]),
                  ]))
            ];
          }));

      pdf.addPage(pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.all(0),
          maxPages: 20,
          header: (context) {
            return pw.Container(
              width: 1000,
              height: 80,
              margin: pw.EdgeInsets.only(bottom: 10),
              decoration: pw.BoxDecoration(),
              child: pw.ClipRRect(
                child: pw.Container(
                  child: pw.Image(
                    pw.MemoryImage(headerImage),
                    fit: pw.BoxFit.fill,
                  ),
                ),
              ),
            );
          },
          footer: (context) {
            return pw.Container(
              width: 1000,
              height: 80,
              decoration: pw.BoxDecoration(),
              child: pw.ClipRRect(
                child: pw.Container(
                  child: pw.Image(
                    pw.MemoryImage(footerImage),
                    fit: pw.BoxFit.fill,
                  ),
                ),
              ),
            );
          },
          build: (pw.Context context) {
            return [
              pw.Container(
                  padding: pw.EdgeInsets.symmetric(horizontal: 10),
                  child: pw.Column(children: [
                    pw.SizedBox(height: 10),
                    pw.Row(children: [
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.SizedBox(width: 35),
                            pw.SizedBox(width: 15),
                            pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Row(children: [
                                    pw.SizedBox(width: 10),
                                    pw.Container(
                                      width: 350,
                                      child: pw.Text(
                                          "d. Berdiri lama > 4 jam terus menerus",
                                          style: pw.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pw.FontWeight.normal)),
                                    ),
                                    pw.Text(
                                        ": ${_ergonomis!.berdiriLama ?? ""}",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ]),
                                  pw.Row(children: [
                                    pw.SizedBox(width: 10),
                                    pw.Container(
                                      width: 350,
                                      child: pw.Text(
                                          "e. Posisi tubuh tidak ergonomis",
                                          style: pw.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pw.FontWeight.normal)),
                                    ),
                                    pw.Text(
                                        ": ${_ergonomis!.posisiTubuh ?? ""}",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ]),
                                  pw.Row(children: [
                                    pw.SizedBox(width: 10),
                                    pw.Container(
                                      width: 350,
                                      child: pw.Text(
                                          "f. Pencahayaan tidak sesuai",
                                          style: pw.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pw.FontWeight.normal)),
                                    ),
                                    pw.Text(
                                        ": ${_ergonomis!.pencahayaanTidakSesuai ?? ""}",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ]),
                                  pw.Row(children: [
                                    pw.SizedBox(width: 10),
                                    pw.Container(
                                      width: 350,
                                      child: pw.Text(
                                          "g. Bekerja dengan layar / monitor 4 jam / lebih dalam sehari",
                                          style: pw.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pw.FontWeight.normal)),
                                    ),
                                    pw.Text(
                                        ": ${_ergonomis!.bekerjaDenganLayar ?? ""}",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ]),
                                  pw.Row(children: [
                                    pw.SizedBox(width: 10),
                                    pw.Container(
                                      width: 350,
                                      child: pw.Text("h. Lain-lain ",
                                          style: pw.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pw.FontWeight.normal)),
                                    ),
                                    pw.Text(": ${_ergonomis!.lainLain ?? ""}",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: pw.FontWeight.normal)),
                                  ]),
                                ])
                          ]),
                    ]),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Row(children: [
                      pw.SizedBox(width: 10),
                      pw.Container(
                          width: 240,
                          child: pw.Text("PEMERIKSAAN FISIK",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Text(": ${_pemeriksaan!.pemeriksaanFisik}",
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.normal))
                    ]),
                    pw.Row(children: [
                      pw.SizedBox(width: 10),
                      pw.Container(
                          width: 240,
                          child: pw.Text("PEMERIKSAAN MATA",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Text(": ${_pemeriksaan!.pemeriksaanMata}",
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.normal))
                    ]),
                    pw.Row(children: [
                      pw.SizedBox(width: 10),
                      pw.Container(
                          width: 240,
                          child: pw.Text("PEMERIKSAAN GIGI & MULUT",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Text(": ${_pemeriksaan!.pemeriksaanGigiMulut}",
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.normal))
                    ]),
                    pw.Row(children: [
                      pw.SizedBox(width: 10),
                      pw.Container(
                          width: 240,
                          child: pw.Text("PEMERIKSAAN AUDIOMETRI",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Text(": ${_pemeriksaan!.pemeriksaanAudioMetri}",
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.normal))
                    ]),
                    pw.Row(children: [
                      pw.SizedBox(width: 10),
                      pw.Container(
                          width: 240,
                          child: pw.Text("PEMERIKSAAN SPIROMETRI",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Text(": ${_pemeriksaan!.pemeriksaanSpirometri}",
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.normal))
                    ]),
                    pw.Row(children: [
                      pw.SizedBox(width: 10),
                      pw.Container(
                          width: 240,
                          child: pw.Text("PEMERIKSAAN TREADMILL/EKG",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Text(": ${_pemeriksaan!.pemeriksaanTreadmill}",
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.normal))
                    ]),
                    pw.Row(children: [
                      pw.SizedBox(width: 10),
                      pw.Container(
                          width: 240,
                          child: pw.Text("PEMERIKSAAN LABORATORIUM",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Text(": ${_pemeriksaan!.pemeriksaanLaboratorium}",
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.normal))
                    ]),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(width: 10),
                          pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Container(
                                    width: 240,
                                    child: pw.Text("PEMERIKSAAN X RAY",
                                        style: pw.TextStyle(
                                            fontSize: 14,
                                            fontWeight: pw.FontWeight.bold))),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.SizedBox(width: 10),
                                      pw.Container(
                                          width: 230,
                                          child: pw.Text("1. JANTUNG",
                                              style: pw.TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                      pw.FontWeight.bold))),
                                      pw.Text(
                                          ": ${_pemeriksaan!.pemeriksaanXrayJantung}",
                                          style: pw.TextStyle(
                                              fontSize: 14,
                                              fontWeight: pw.FontWeight.normal))
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.SizedBox(width: 10),
                                      pw.Container(
                                          width: 230,
                                          child: pw.Text("2. PARU",
                                              style: pw.TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                      pw.FontWeight.bold))),
                                      pw.Text(": ${_pemeriksaan!.paru}",
                                          style: pw.TextStyle(
                                              fontSize: 14,
                                              fontWeight: pw.FontWeight.normal))
                                    ]),
                              ])
                        ]),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(width: 10),
                          pw.Container(
                              width: 240,
                              child: pw.Text("ANJURAN-ANJURAN",
                                  style: pw.TextStyle(
                                      fontSize: 14,
                                      fontWeight: pw.FontWeight.bold))),
                          pw.Text(":",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.normal)),
                          pw.SizedBox(width: 5),
                          pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                    _ajuran!.konsumsiAir == "Ya"
                                        ? "1. Konsumsi air mineral 2-3 liter dalam sehari"
                                        : _ajuran!.konsumsiAir == "Tidak"
                                            ? "1. -"
                                            : "1. ${_ajuran!.konsumsiAir}",
                                    style: pw.TextStyle(
                                        fontSize: 11,
                                        fontWeight: pw.FontWeight.normal)),
                                pw.Text(
                                    _ajuran!.olahragaTeratur == "Ya"
                                        ? "2. Olahraga teratur minimal 30 menit setiap harinya 3-4x seminggu"
                                        : _ajuran!.olahragaTeratur == "Tidak"
                                            ? "2. -"
                                            : "2. ${_ajuran!.olahragaTeratur}",
                                    style: pw.TextStyle(
                                        fontSize: 11,
                                        fontWeight: pw.FontWeight.normal)),
                              ])
                        ]),
                    pw.SizedBox(height: 10),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(width: 10),
                          pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text("KESIMPULAN KELAYAKAN KERJA",
                                    style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    _kelayakanKerja!.layakBekerjaSesuaiPosisi ==
                                            "Ya"
                                        ? "(v) : Layak Bekerja Sesuai Posisi dan Lokasi Saat Ini"
                                        : "(x) : Layak Bekerja Sesuai Posisi dan Lokasi Saat Ini",
                                    style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.normal)),
                                pw.Text(
                                    _kelayakanKerja!
                                                .layakBekerjaDenganCatatan ==
                                            "Ya"
                                        ? "(v) : Layak Bekerja Sesuai Posisi dan Lokasi Saat Ini, Dengan Catatan"
                                        : "(x) : Layak Bekerja Sesuai Posisi dan Lokasi Saat Ini, Dengan Catatan",
                                    style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.normal)),
                                pw.Text(
                                    _kelayakanKerja!
                                                .layakBekerjaDenganPenyesuaian ==
                                            "Ya"
                                        ? "(v) : Layak Bekerja Dengan Penyesuaian dan atau Pembatasan Pekerjaan"
                                        : "(x) : Layak Bekerja Dengan Penyesuaian dan atau Pembatasan Pekerjaan",
                                    style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.normal)),
                                pw.Text(
                                    _kelayakanKerja!.layakuntukBekerja == "Ya"
                                        ? "(v) : Layak Untuk Bekerja"
                                        : "(x) : Layak Untuk Bekerja",
                                    style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.normal)),
                                pw.Text(
                                    "Resiko Cardiovaskuler : ${_kelayakanKerja!.resikoCardioVascular}",
                                    style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.normal)),
                              ])
                        ]),
                    pw.SizedBox(height: 10),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(width: 10),
                          pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text("KESIMPULAN DERAJAT KESEHATAN :",
                                    style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text(
                                    _kesimpulanDerajatKesehatan!
                                                .ditemukanKelainanMedis ==
                                            "Ya"
                                        ? "(x) : P1. Tidak ditemukan kelainan medis"
                                        : "(v) : P1. Tidak ditemukan kelainan medis",
                                    style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.normal)),
                                pw.Text(
                                    _kesimpulanDerajatKesehatan!
                                                .ditemukanKelainanYangTidakSerius ==
                                            "Ya"
                                        ? "(v) : P2. Ditemukan kelainan medis yang tidak serius"
                                        : "(x) : P2. Ditemukan kelainan medis yang tidak serius",
                                    style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.normal)),
                                pw.Text(
                                    _kesimpulanDerajatKesehatan!
                                                .ditemukanKelainanResikoKesehatanRendah ==
                                            "Ya"
                                        ? "(v) : P3. Ditemukan kelainan medis, resiko kesehatan rendah"
                                        : "(x) : P3. Ditemukan kelainan medis, resiko kesehatan rendah",
                                    style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.normal)),
                                pw.Text(
                                    _kesimpulanDerajatKesehatan!
                                                .ditemukanKelainanResikoKesehatanSedang ==
                                            "Ya"
                                        ? "(v) : P4. Ditemukan kelainan medis bermakna yang dapat menjadi serius, resiko kesehatan sedang"
                                        : "(x) : P4. Ditemukan kelainan medis bermakna yang dapat menjadi serius, resiko kesehatan sedang",
                                    style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.normal)),
                                pw.Text(
                                    _kesimpulanDerajatKesehatan!
                                                .ditemukanKelainanResikoKesehatanTinggi ==
                                            "Ya"
                                        ? "(v) : P5. Ditemukan kelainan medis yang serius, resiko kesehatan tinggi"
                                        : "(x) : P5. Ditemukan kelainan medis yang serius, resiko kesehatan tinggi",
                                    style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.normal)),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                          _kesimpulanDerajatKesehatan!
                                                      .ditemukanKelainanMenyebabkanKeterbatasan ==
                                                  "Ya"
                                              ? "(v) : "
                                              : "(x) : ",
                                          style: pw.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pw.FontWeight.normal)),
                                      pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text(
                                                "P6. Ditemukan kelainan medis yang menyebabkan keterbatasan fisik maupun psikis untuk",
                                                style: pw.TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        pw.FontWeight.normal)),
                                            pw.Text(
                                                "melakukan sesuai jabatan/posisinya",
                                                style: pw.TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        pw.FontWeight.normal)),
                                          ])
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                          _kesimpulanDerajatKesehatan!
                                                      .tidakDapatBekerja ==
                                                  "Ya"
                                              ? "(v) : "
                                              : "(x) : ",
                                          style: pw.TextStyle(
                                              fontSize: 12,
                                              fontWeight:
                                                  pw.FontWeight.normal)),
                                      pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text(
                                                " P7. Tidak dapat bekerja untuk melakukan pekerjaan sesuai jabatan/posisinya dan/atau posisi apapun, ",
                                                style: pw.TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        pw.FontWeight.normal)),
                                            pw.Text(
                                                "Dalam perawatan rumah sakit, atau dalam status ijin sakit",
                                                style: pw.TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        pw.FontWeight.normal)),
                                          ])
                                    ])
                              ])
                        ]),
                    pw.SizedBox(height: 10),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(width: 10),
                          pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text("Lhokseumawe,         2023",
                                    style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.normal)),
                                pw.Text("Dokter Penanggung Jawab MCU",
                                    style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.normal)),
                              ])
                        ])
                  ])),
              // pw.SizedBox(height: 60),
              pw.Container(
                width: 100,
                height: 70,
                margin: pw.EdgeInsets.only(left: 50),
                child: pw.Image(
                  pw.MemoryImage(ttdDokter),
                  fit: pw.BoxFit.fill,
                ),
              ),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(width: 50),
                    pw.Text("dr. Rajab Saputra",
                        style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                            decoration: pw.TextDecoration.underline)),
                  ]),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(width: 45),
                    pw.Text("NO.SIP.503/055/2021",
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                        )),
                  ])
            ];
          }));
      final bytes = await pdf.save();
      final blob = html.Blob([bytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.AnchorElement anchorElement = html.AnchorElement(href: url);
      anchorElement.download = widget.dataPasien['namaPasien'];
      anchorElement.click();

      // final bytes = await pdf.save();
      // final blob = html.Blob([bytes], 'application/pdf');
      // final url = html.Url.createObjectUrlFromBlob(blob);
      // html.window.open(url, '_blank');
      // html.Url.revokeObjectUrl(url);
    }

    return Scaffold(
      appBar: AppBar(title: Text('Profil Pasien')),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Data Diri',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text('Nama: ' + widget.dataPasien['namaPasien']),
                ],
              ),
              Column(
                children: [
                  Text('NIK: ' + widget.dataPasien['NIK']),
                ],
              )
            ],
          ),
          ElevatedButton(
            child: Text('Download file'),
            onPressed: () {
              testPdf();
              // getPDF();
            },
          ),
        ],
      )),
    );
  }
}
