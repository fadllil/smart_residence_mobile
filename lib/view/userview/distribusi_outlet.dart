
import 'package:flutter/material.dart';
import 'package:smart_residence/constants/themes.dart';
import 'package:smart_residence/utils/string_helper.dart';
import 'package:smart_residence/view/components/heading_title.dart';

class DistribusiOutlet extends StatefulWidget {
  const DistribusiOutlet({Key? key}) : super(key: key);

  @override
  _DistribusiOutletState createState() => _DistribusiOutletState();
}

class _DistribusiOutletState extends State<DistribusiOutlet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Distribusi'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeadingTitle(title: 'Distribusi Bulan Ini',),
              ActionChip(label: Text('Pilih tanggal'), onPressed: (){

              },avatar: CircleAvatar(backgroundColor:Colors.black,child: Icon(Icons.date_range,size: 18,color: Colors.white,)),backgroundColor: Colors.white,side: BorderSide(color: kPrimaryColor),),
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
