
import 'package:flutter/material.dart';
import 'package:smart_residence/constants/themes.dart';
import 'package:smart_residence/view/userview/dashboard_outlet.dart';
import 'package:smart_residence/view/userview/distribusi_outlet.dart';

class Home extends StatefulWidget {
  final int? index;
  const Home({Key? key, this.index = 0}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
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
          BottomNavigationBarItem(icon: Icon(Icons.delivery_dining),label: 'Distribusi'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet),label: 'Transaksi'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory),label: 'Stok'),
        ],
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          DashboardOutlet(),
          DistribusiOutlet(),
          Center(child: Text('Transaksi'),),
          Center(child: Text('Stok'),),
        ],
      ),
    );
  }
}