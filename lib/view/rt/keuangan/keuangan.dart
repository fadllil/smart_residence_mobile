import 'package:flutter/material.dart';

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
          Center(child: Text('Belum Diproses'),),
          Center(child: Text('Diproses'),),
        ],
      ),
    );
  }
}