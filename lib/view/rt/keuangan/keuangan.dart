import 'package:flutter/material.dart';
import 'package:smart_residence/view/rt/keuangan/pemasukan.dart';
import 'package:smart_residence/view/rt/keuangan/pengeluaran.dart';

class Keuangan extends StatefulWidget{
  const Keuangan({Key? key}) :super (key: key);

  @override
  _KeuanganState createState() => _KeuanganState();
}

class _KeuanganState extends State<Keuangan> with SingleTickerProviderStateMixin{
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
        title: Text('Keuangan'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text: 'Pemasukan',
            ),
            Tab(
              text: 'Pengeluaran',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Pemasukan(),
          Pengeluaran()
        ],
      ),
    );
  }
}