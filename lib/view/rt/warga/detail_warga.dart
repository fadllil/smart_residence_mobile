import 'package:flutter/material.dart';
import 'package:smart_residence/constants/themes.dart';
import 'package:smart_residence/model/list_warga_model.dart';

class DetailWarga extends StatefulWidget{
  final ListWargaModel? model;
  final int index;
  const DetailWarga({Key? key, required this.model, required this.index}) : super (key: key);

  @override
  _DetailWargaState createState() => _DetailWargaState();
}

class _DetailWargaState extends State<DetailWarga>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Warga'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                    child: Icon(Icons.person, color: bluePrimary, size: 64,),
                  ),
                  SizedBox(height: 10,),
                  Text('${widget.model?.results?[widget.index].user?.nama}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                  Text('${widget.model?.results?[widget.index].user?.email}', style: TextStyle(color: Colors.white),),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.credit_card_outlined),
                          title: Text('NIK'),
                          subtitle: Text('${widget.model?.results?[widget.index].nik}'),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.location_on),
                          title: Text('Alamat'),
                          subtitle: Text('${widget.model?.results?[widget.index].alamat}'),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.phone_android),
                          title: Text('No Hp'),
                          subtitle: Text('${widget.model?.results?[widget.index].noHp}'),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.family_restroom),
                          title: Text('Anggota Keluarga'),
                          subtitle: Text('${widget.model?.results?[widget.index].jmlAnggotaKeluarga}'),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.credit_card_rounded),
                          title: Text('No KK'),
                          subtitle: Text('${widget.model?.results?[widget.index].noKk}'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}