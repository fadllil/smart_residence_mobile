import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_residence/bloc/warga/dashboard/dashboard_warga_cubit.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/config/router.gr.dart';
import 'package:smart_residence/constants/themes.dart';
import 'package:smart_residence/utils/string_helper.dart';
import 'package:smart_residence/view/components/error_component.dart';
import 'package:smart_residence/view/components/heading_title.dart';
import 'package:smart_residence/view/components/loading_com.dart';

class DashboardWarga extends StatefulWidget{
  final TabController tab;
  const DashboardWarga({Key? key, required this.tab}) : super (key: key);

  @override
  _DashboardWargaState createState() => _DashboardWargaState();
}

class _DashboardWargaState extends State<DashboardWarga>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<DashboardWargaCubit>()..init(),
      child: Scaffold(
          backgroundColor: graySecondary,
          appBar: AppBar(
            title: Text('Smart Residence Kota Pekanbaru'),
          ),
          body: BlocBuilder<DashboardWargaCubit, DashboardWargaState>(
            builder: (context, state){
              if (state is DashboardWargaFailure){
                return ErrorComponent(onPressed: context.read<DashboardWargaCubit>().init,message: state.message,);
              }else if(state is DashboardWargaLoading){
                return LoadingComp();
              }
              return DashboardWargaBody(tab: widget.tab, state: (state as DashboardWargaLoaded));
            },
          )
      ),
    );
  }
}

class DashboardWargaBody extends StatefulWidget{
  final DashboardWargaLoaded state;
  final TabController tab;
  const DashboardWargaBody({Key? key, required this.state, required this.tab}) : super (key: key);

  @override
  _DashboardWargaBodyState createState() => _DashboardWargaBodyState();
}

class _DashboardWargaBodyState extends State<DashboardWargaBody>{
  GlobalKey<RefreshIndicatorState> _refresh = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refresh,
      onRefresh: ()=>context.read<DashboardWargaCubit>().init(),
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
                          AutoRouter.of(context).push(PelaporanWargaRoute());
                        },
                        child: DashboardCard(
                          title: 'Pelaporan',
                          icon: Icons.verified_user,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          AutoRouter.of(context).push(SuratWargaRoute());
                        },
                        child: DashboardCard(
                          title: 'Surat',
                          icon: Icons.verified_user,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                tileColor: Colors.orange,
                title: Text('1 Pengajuan Surat',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                leading: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.upload_file,color: kPrimaryColor),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
              HeadingTitle(
                title: 'Kas',
                onTap: () {
                  print('oce');
                },
              ),
              ListView.builder(
                itemCount: 10,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context,index)=>Column(
                  children: [
                    ListTile(
                      title: Text('Test'),
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: kPrimaryColor,
                        child: Icon(Icons.all_inbox_sharp,color: Colors.white,),
                      ),
                      trailing: Text('-${valueRupiah(45000)}',style: TextStyle(color: Colors.green),),
                    ),
                    Divider()
                  ],
                ),
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
      width: 180,
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