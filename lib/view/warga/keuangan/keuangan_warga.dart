import 'package:flutter/material.dart';
import 'package:smart_residence/view/warga/keuangan/pemasukan_warga.dart';
import 'package:smart_residence/view/warga/keuangan/pengeluaran_warga.dart';

class KeuanganWarga extends StatefulWidget{
  final TabController tab;
  const KeuanganWarga({Key? key, required this.tab}) :super (key: key);

  @override
  _KeuanganWargaState createState() => _KeuanganWargaState();
}

class _KeuanganWargaState extends State<KeuanganWarga> with SingleTickerProviderStateMixin{
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
          PemasukanWarga(),
          PengeluaranWarga()
        ],
      ),
    );
  }
}