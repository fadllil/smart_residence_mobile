import 'package:flutter/material.dart';
import 'package:smart_residence/view/warga/kegiatan/detail/berpartisipasi_anggota.dart';
import '../../../warga/kegiatan/detail/peserta.dart';

class KegiatanPeserta extends StatefulWidget{
  final int id;
  const KegiatanPeserta({Key? key, required this.id}) : super (key: key);

  @override
  _KegiatanPesertaState createState() => _KegiatanPesertaState();
}

class _KegiatanPesertaState extends State<KegiatanPeserta> with SingleTickerProviderStateMixin{
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
        title: Text('Detail Peserta Kegiatan'),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text: 'Peserta',
            ),
            Tab(
              text: 'Berpartisipasi',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Peserta(id: widget.id),
          BerpartisipasiAnggota(id: widget.id)
        ],
      ),
    );
  }
}