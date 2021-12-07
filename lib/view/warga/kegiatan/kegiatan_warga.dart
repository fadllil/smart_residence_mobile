import 'package:flutter/material.dart';
import 'package:smart_residence/view/warga/kegiatan/batal_kegiatan.dart';
import 'package:smart_residence/view/warga/kegiatan/proses_kegiatan.dart';
import 'package:smart_residence/view/warga/kegiatan/selesai_kegiatan.dart';

class KegiatanWarga extends StatefulWidget{
  final TabController tab;
  const KegiatanWarga({Key? key, required this.tab}) : super (key: key);

  @override
  _KegiatanWargaState createState() => _KegiatanWargaState();
}

class _KegiatanWargaState extends State<KegiatanWarga> with SingleTickerProviderStateMixin{
  late TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Kegiatan'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text: 'Belum Terlaksana',
            ),
            Tab(
              text: 'Selesai',
            ),
            Tab(
              text: 'Batal',
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ProsesKegiatan(),
          SelesaiKegiatan(),
          BatalKegiatan(),
        ],
      ),
    );
  }
}