
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_residence/bloc/Rt/dashboard/dashboard_rt_cubit.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/config/router.gr.dart';
import 'package:smart_residence/constants/themes.dart';
import 'package:smart_residence/utils/string_helper.dart';
import 'package:smart_residence/view/components/heading_title.dart';

class DashboardRt extends StatefulWidget {
  const DashboardRt({Key? key}) : super(key: key);

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
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${timeToGreet()}\n${'RT'}',
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
                          AutoRouter.of(context).push(ProfileRoute()).then((value){
                            context.read<DashboardRtCubit>().init();
                          });
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

                          },
                          child: DashboardCard(
                            title: 'Data Warga',
                            icon: Icons.people,
                          ),
                        ),
                        DashboardCard(
                          title: 'Kegiatan',
                          icon: Icons.money,
                        ),
                        DashboardCard(
                          title: 'Informasi',
                          icon: Icons.verified_user,
                        ),
                        DashboardCard(
                          title: 'Pelaporan',
                          icon: Icons.verified_user,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DashboardCard(
                          title: 'Surat',
                          icon: Icons.verified_user,
                        ),
                        DashboardCard(
                          title: 'Keuangan',
                          icon: Icons.verified_user,
                        ),
                        SizedBox(width: 80,),
                        SizedBox(width: 80,),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  tileColor: Colors.orange,
                  title: Text('1 Pengiriman sedang dijalan',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.delivery_dining,color: kPrimaryColor),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                ),
                HeadingTitle(
                  title: 'Pengeluaran',
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
                        title: Text('Es Batu'),
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundColor: kPrimaryColor,
                          child: Icon(Icons.agriculture,color: Colors.white,),
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
