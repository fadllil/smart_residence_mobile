import 'package:flutter/material.dart';
import 'package:smart_residence/view/rt/warga/aktif.dart';
import 'package:smart_residence/view/rt/warga/tidak_aktif.dart';

class Warga extends StatefulWidget{
  const Warga({Key? key}) :super (key: key);

  @override
  _WargaState createState() => _WargaState();
}

class _WargaState extends State<Warga> with SingleTickerProviderStateMixin{
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
        title: Text('Data Warga'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text: 'Aktif',
            ),
            Tab(
              text: 'Tidak Aktif',
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Aktif(),
          TidakAktif()
        ],
      ),
    );
  }
}