
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_residence/bloc/Rt/dashboard/dashboard_rt_cubit.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/config/router.gr.dart';
import 'package:smart_residence/constants/themes.dart';
import 'package:smart_residence/model/list_warga_model.dart';
import 'package:smart_residence/utils/string_helper.dart';
import 'package:smart_residence/view/components/error_component.dart';
import 'package:smart_residence/view/components/heading_title.dart';
import 'package:smart_residence/view/components/loading_com.dart';
import 'package:smart_residence/view/rt/pelaporan/pelaporan.dart';

class DashboardRt extends StatefulWidget {
  final TabController tab;
  const DashboardRt({Key? key, required this.tab}) : super(key: key);

  @override
  _DashboardRtState createState() => _DashboardRtState();
}

class _DashboardRtState extends State<DashboardRt> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<DashboardRtCubit>()..init(),
      child: Scaffold(
        backgroundColor: graySecondary,
        appBar: AppBar(
          title: Text('Smart Residence Kota Pekanbaru'),
        ),
        body: BlocBuilder<DashboardRtCubit, DashboardRtState>(
          builder: (context, state){
            if (state is DashboardRtFailure){
              return ErrorComponent(onPressed: context.read<DashboardRtCubit>().init,message: state.message!,);
            }else if(state is DashboardRtLoading){
              return LoadingComp();
            }
            return DashboardRtBody(tab: widget.tab, state: (state as DashboardRtLoaded), model: context.select((DashboardRtCubit bloc) => bloc.model));
          },
        )
      ),
    );
  }
}

class DashboardRtBody extends StatefulWidget{
  final ListWargaModel? model;
  final DashboardRtLoaded state;
  final TabController tab;
  const DashboardRtBody({Key? key, required this.state, required this.tab, required this.model}) : super (key: key);

  @override
  _DashboardRtBodyState createState() => _DashboardRtBodyState();
}

class _DashboardRtBodyState extends State<DashboardRtBody>{
  GlobalKey<RefreshIndicatorState> _refresh = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refresh,
      onRefresh: ()=>context.read<DashboardRtCubit>().init(),
      color: Colors.white,
      backgroundColor: bluePrimary,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${timeToGreet()}\n${widget.state.nama}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: kTextBlack),
                  ),
                  CircleAvatar(
                    backgroundColor: blueSecondary,
                    radius: 20,
                    child: IconButton(icon: Icon(Icons.person,color: Colors.white,),
                      onPressed: ()
                      {
                      },
                    ),
                  )
                ],
              ),
              Divider(),
              SizedBox(
                height: 20,
              ),

              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          AutoRouter.of(context).push(WargaRoute());
                        },
                        child: DashboardCard(
                          title: 'Data Warga',
                          icon: Icons.people,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          AutoRouter.of(context).push(KegiatanRoute());
                        },
                        child: DashboardCard(
                          title: 'Kegiatan',
                          icon: Icons.money,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          AutoRouter.of(context).push(InformasiRoute());
                        },
                        child: DashboardCard(
                          title: 'Informasi',
                          icon: Icons.verified_user,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          AutoRouter.of(context).push(PelaporanRoute());
                        },
                        child: DashboardCard(
                          title: 'Pelaporan',
                          icon: Icons.verified_user,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          AutoRouter.of(context).push(SuratRoute());
                        },
                        child: DashboardCard(
                          title: 'Surat',
                          icon: Icons.verified_user,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          AutoRouter.of(context).push(KeuanganRoute());
                        },
                        child: DashboardCard(
                          title: 'Keuangan',
                          icon: Icons.verified_user,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          AutoRouter.of(context).push(JenisSuratRoute());
                        },
                        child: DashboardCard(
                          title: 'Jenis Surat',
                          icon: Icons.verified_user,
                        ),
                      ),
                      SizedBox(width: 80,),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              HeadingTitle(
                title: 'Warga',
                onTap: () {
                  print('oce');
                },
              ),
              ListView.builder(
                itemCount: widget.model?.results?.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index)=>Column(
                  children: [
                    ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.model?.results?[index].user?.nama??''),
                          Text(widget.model?.results?[index].alamat??''),
                        ],
                      ),
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: bluePrimary,
                        child: Icon(Icons.person, color: Colors.white,),
                      ),
                      onTap: (){
                        AutoRouter.of(context).push(DetailWargaRoute(model: widget.model, index: index));
                      },
                    ),
                    Divider()
                  ],
                ) ,
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  const DashboardCard({
    Key? key, required this.icon, required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: blueSecondary, borderRadius: BorderRadius.circular(10)),
      // width: MediaQuery.of(context).size.width / 2.2,
      width: 80,
      child: Column(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Icon(icon,color: blueSecondary),
          ),
          SizedBox(height: 10,),
          Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
