import 'package:flutter/material.dart';

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
              text: 'Surat Pengantar',
            ),
            Tab(
              text: 'Surat Keterangan',
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(child: Text('Surat Pengantar'),),
          Center(child: Text('Surat Keterangan'),)
        ],
      ),
    );
  }
}