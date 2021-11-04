
import 'package:flutter/material.dart';
import 'package:smart_residence/constants/themes.dart';
import 'package:smart_residence/utils/string_helper.dart';
import 'package:smart_residence/view/components/heading_title.dart';

class DashboardOutlet extends StatefulWidget {
  const DashboardOutlet({Key? key}) : super(key: key);

  @override
  _DashboardOutletState createState() => _DashboardOutletState();
}

class _DashboardOutletState extends State<DashboardOutlet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(timeToGreet()),
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
                    'Hai, COBA',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: kTextGrey),
                  ),
                  CircleAvatar(
                    backgroundColor: kPrimaryColor,
                    radius: 20,
                    child: Icon(Icons.person,color: Colors.white,),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DashboardCard(),
                      DashboardCard(),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DashboardCard(),
                      DashboardCard(),
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
    );
  }
}

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: kPrimaryColor, borderRadius: BorderRadius.circular(20)),
      width: MediaQuery.of(context).size.width / 2.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pengeluaran Hari Ini',
            style: TextStyle(color: Colors.white),
          ),
          Text(
            '${valueRupiah(20000)}',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
