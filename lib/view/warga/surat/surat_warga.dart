import 'package:flutter/material.dart';
import 'package:smart_residence/view/warga/surat/keterangan_warga.dart';
import 'package:smart_residence/view/warga/surat/pengantar_warga.dart';

class SuratWarga extends StatefulWidget{
  const SuratWarga({Key? key}) : super (key: key);

  @override
  _SuratWargaState createState() => _SuratWargaState();
}

class _SuratWargaState extends State<SuratWarga> with SingleTickerProviderStateMixin{
  late TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Surat'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text: 'Surat Keterangan',
            ),
            Tab(
              text: 'Surat Pengantar',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          KeteranganWarga(),
          PengantarWarga()
        ],
      ),
    );
  }
}