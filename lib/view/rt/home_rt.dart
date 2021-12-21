
import 'package:flutter/material.dart';
import 'package:smart_residence/constants/themes.dart';
import 'package:smart_residence/view/rt/dashboard_rt.dart';
import 'package:smart_residence/view/rt/profil.dart';

class HomeRt extends StatefulWidget {
  final int? index;
  const HomeRt({Key? key, this.index = 0}) : super(key: key);

  @override
  _HomeRtState createState() => _HomeRtState();
}

class _HomeRtState extends State<HomeRt> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.index?? 0);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: bluePrimary,
        onTap: (index){
          _tabController.index = index;
          setState(() {

          });
        },
        currentIndex: _tabController.index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profil'),
        ],
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          DashboardRt(tab: _tabController,),
          ProfilRt(tab: _tabController)
        ],
      ),
    );
  }
}