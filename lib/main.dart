import 'package:arifa_web_app/download_hasil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyBLOcPh2gHRHry-ZXy_dEjCop2pWcNQYX4",
    authDomain: "arifa-medikal-klinik-c8675.firebaseapp.com",
    databaseURL:
        "https://arifa-medikal-klinik-c8675-default-rtdb.asia-southeast1.firebasedatabase.app",
    projectId: "arifa-medikal-klinik-c8675",
    storageBucket: "arifa-medikal-klinik-c8675.appspot.com",
    messagingSenderId: "603088810081",
    appId: "1:603088810081:web:21eff1676e09d379f3fa20",
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ruang Cek Hasil MCU',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Arifa Medikal Klinik'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic>? userMap;
  String idPasien = "";
  // DocumentSnapshot? userMap;
  final db = FirebaseFirestore.instance;
  final TextEditingController _search = TextEditingController();

  void onSearch() async {
    await db
        .collection('pasien')
        .where('NIK', isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        idPasien = value.docs[0].id;
      });
      print(userMap);
      print("Id pasien : ${idPasien}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _search,
                decoration: InputDecoration(
                    labelText: 'Masukkan NIK Anda',
                    suffixIcon: Icon(Icons.search)),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(onPressed: onSearch, child: Text('Cari NIK')),
              SizedBox(
                height: 20,
              ),
              userMap != null
                  ? ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return DownloadHasil(
                            dataPasien: userMap!,
                            idPasien: idPasien,
                          );
                        }));
                      },
                      title: Text(userMap!['namaPasien']),
                      subtitle: Text(userMap!['umur']),
                    )
                  : Container()
            ],
          ),
        ));
  }
}
