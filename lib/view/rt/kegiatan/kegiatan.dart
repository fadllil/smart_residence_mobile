import 'package:flutter/material.dart';
import 'package:smart_residence/view/rt/kegiatan/batal.dart';
import 'package:smart_residence/view/rt/kegiatan/proses.dart';
import 'package:smart_residence/view/rt/kegiatan/selesai.dart';

class Kegiatan extends StatefulWidget{
  const Kegiatan({Key? key}) :super (key: key);

  @override
  _KegiatanState createState() => _KegiatanState();
}

class _KegiatanState extends State<Kegiatan> with SingleTickerProviderStateMixin{
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
          Proses(),
          Selesai(),
          Batal(),
        ],
      ),
    );
  }
}