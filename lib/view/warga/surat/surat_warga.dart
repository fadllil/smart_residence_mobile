import 'package:flutter/material.dart';
import 'package:smart_residence/view/warga/surat/pengajuan.dart';
import 'package:smart_residence/view/warga/surat/selesai.dart';

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
              text: 'Pengajuan',
            ),
            Tab(
              text: 'Selesai',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PengajuanWarga(),
          SelesaiWarga()
        ],
      ),
    );
  }
}