import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_residence/bloc/Rt/kegiatan/iuran/kegiatan_iuran_cubit.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/config/router.gr.dart';
import 'package:smart_residence/constants/themes.dart';
import 'package:smart_residence/model/detail_iuran_model.dart';
import 'package:smart_residence/model/list_kegiatan_model.dart';
import 'package:smart_residence/utils/string_helper.dart';
import 'package:smart_residence/view/components/error_component.dart';
import 'package:smart_residence/view/components/loading_com.dart';
import 'package:smart_residence/view/components/no_data.dart';
import 'package:smart_residence/view/rt/kegiatan/detail/belum_bayar.dart';
import 'package:smart_residence/view/rt/kegiatan/detail/menunggu_validasi.dart';
import 'package:smart_residence/view/rt/kegiatan/detail/sudah_bayar.dart';

class Iuran extends StatefulWidget{
  final int id;
  const Iuran({Key? key, required this.id}) : super (key: key);

  @override
  _IuranState createState() => _IuranState();
}

class _IuranState extends State<Iuran> with SingleTickerProviderStateMixin{
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
        title: Text('Detail Iuran Kegiatan'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text: 'Belum Bayar',
            ),
            Tab(
              text: 'Menunggu Validasi',
            ),
            Tab(
              text: 'Sudah Bayar',
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          BelumBayar(id: widget.id),
          MenungguValidasi(id: widget.id),
          SudahBayar(id: widget.id),
        ],
      ),
    );
  }
}