import 'package:flutter/material.dart';
import 'package:smart_residence/view/warga/pelaporan/belum_diproses_pelaporan.dart';
import 'package:smart_residence/view/warga/pelaporan/diproses_pelaporan.dart';
import 'package:smart_residence/view/warga/pelaporan/selesai_pelaporan.dart';

class PelaporanWarga extends StatefulWidget{
  const PelaporanWarga({Key? key}) : super (key: key);

  @override
  _PelaporanWargaState createState() => _PelaporanWargaState();
}

class _PelaporanWargaState extends State<PelaporanWarga> with SingleTickerProviderStateMixin{
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
        title: Text('Pelaporan'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text: 'Belum Diproses',
            ),
            Tab(
              text: 'Diproses',
            ),
            Tab(
              text: 'Selesai',
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          BelumDiprosesPelaporan(),
          DiprosesPelaporan(),
          SelesaiPelaporan()
        ],
      ),
    );
  }
}