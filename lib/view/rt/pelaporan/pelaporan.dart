import 'package:flutter/material.dart';
import 'package:smart_residence/view/rt/pelaporan/belum_diproses.dart';
import 'package:smart_residence/view/rt/pelaporan/diproses.dart';
import 'package:smart_residence/view/rt/pelaporan/selesai.dart';

class Pelaporan extends StatefulWidget{
  const Pelaporan({Key? key}) :super (key: key);

  @override
  _PelaporanState createState() => _PelaporanState();
}

class _PelaporanState extends State<Pelaporan> with SingleTickerProviderStateMixin{
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
          BelumDiproses(status: "Belum Diproses",),
          Diproses(status: "Diproses",),
          Selesai(status: "Selesai",),
        ],
      ),
    );
  }
}