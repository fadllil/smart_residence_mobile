
import 'package:flutter/material.dart';
import 'package:smart_residence/constants/themes.dart';
import 'package:smart_residence/view/warga/dashboard_warga.dart';
import 'package:smart_residence/view/warga/informasi/informasi.dart';
import 'package:smart_residence/view/warga/kegiatan/kegiatan_warga.dart';
import 'package:smart_residence/view/warga/profil_warga.dart';

class HomeWarga extends StatefulWidget {
  final int? index;
  const HomeWarga({Key? key, this.index = 0}) : super(key: key);

  @override
  _HomeWargaState createState() => _HomeWargaState();
}

class _HomeWargaState extends State<HomeWarga> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: widget.index?? 0);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kPrimaryColor,
        onTap: (index){
          _tabController.index = index;
          setState(() {

          });
        },
        currentIndex: _tabController.index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.info_outlined),label: 'Informasi'),
          BottomNavigationBarItem(icon: Icon(Icons.date_range_outlined),label: 'Kegiatan'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profil'),
        ],
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          DashboardWarga(tab: _tabController),
          InformasiWarga(tab: _tabController),
          KegiatanWarga(tab: _tabController),
          ProfilWarga(tab: _tabController),
        ],
      ),
    );
  }
}