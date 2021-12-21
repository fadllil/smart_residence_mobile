import 'package:flutter/material.dart';
import 'package:smart_residence/view/rt/surat/pengajuan.dart';

class Surat extends StatefulWidget{
  const Surat({Key? key}) :super (key: key);

  @override
  _SuratState createState() => _SuratState();
}

class _SuratState extends State<Surat> with SingleTickerProviderStateMixin{
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
              text: 'Pengajuan Warga',
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
          Pengajuan(),
          Center(child: Text('Selesai'),)
        ],
      ),
    );
  }
}