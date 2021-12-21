import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_residence/bloc/warga/kegiatan/peserta/kegiatan_peserta_cubit.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/config/router.gr.dart';
import 'package:smart_residence/constants/themes.dart';
import 'package:smart_residence/model/berpartisipasi_peserta_model.dart';
import 'package:smart_residence/model/detail_anggota_model.dart';
import 'package:smart_residence/utils/validate_helper.dart';
import 'package:smart_residence/view/components/custom_form.dart';
import 'package:smart_residence/view/components/custom_outline_button.dart';
import 'package:smart_residence/view/components/error_component.dart';
import 'package:smart_residence/view/components/loading_com.dart';

class BerpartisipasiAnggota extends StatefulWidget{
  final int id;
  const BerpartisipasiAnggota({Key? key, required this.id}) : super (key: key);

  @override
  _BerpartisipasiAnggotaState createState() => _BerpartisipasiAnggotaState();
}

class _BerpartisipasiAnggotaState extends State<BerpartisipasiAnggota>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<KegiatanPesertaCubit>()..berpartisipasi(widget.id),
      child: Scaffold(
        body: BlocConsumer<KegiatanPesertaCubit, KegiatanPesertaState>(
          listener: (context, state){
            if(state is KegiatanPesertaCreating){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is KegiatanPesertaCreated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil merubah data');
              AutoRouter.of(context).popAndPush(KegiatanPesertaRoute(id: widget.id));
            }else if (state is KegiatanPesertaError){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message);
            }
          },
          builder: (context, state){
            if(state is KegiatanPesertaFailure){
              return ErrorComponent(onPressed: (){
                context.read<KegiatanPesertaCubit>().berpartisipasi(widget.id);
              }, message: state.message,);
            }else if(state is KegiatanPesertaLoading){
              return LoadingComp();
            }
            return BerpartisipasiAnggotaBody(id: widget.id, model : context.select((KegiatanPesertaCubit bloc) => bloc.berpartisipasiPesertaModel));
          },
        ),
      ),
    );
  }
}

class BerpartisipasiAnggotaBody extends StatefulWidget{
  final int id;
  final BerpartisipasiPesertaModel? model;
  const BerpartisipasiAnggotaBody({Key? key, required this.id, required this.model}) : super(key:key);

  @override
  _BerpartisipasiAnggotaBodyState createState() => _BerpartisipasiAnggotaBodyState();
}

class _BerpartisipasiAnggotaBodyState extends State<BerpartisipasiAnggotaBody>{
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  child: Icon(Icons.people, color: bluePrimary, size: 64,),
                ),
                SizedBox(height: 10,),
                Text('${widget.model?.results?.status}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
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
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.home),
                        title: Text('Status'),
                        subtitle: Text('${(widget.model?.results?.berpartisipasi == true) ? "Anda Sudah Berpartisipasi" : "Anda Tidak Berpartisipasi"}'),
                      ),
                    ],
                  ),
                ),
                (widget.model?.results?.berpartisipasi == false) ? Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: bluePrimary,
                  child: ListTile(
                    leading: CircleAvatar(radius:20,child: Icon(Icons.edit,color: bluePrimary,),backgroundColor: Colors.white,),
                    title: Text('Berpatisipasi',style: TextStyle(color: Colors.white),),
                    onTap: (){
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20)),
                          backgroundColor: Colors.white,
                          isScrollControlled: true,
                          context: context,
                          builder: (context){
                            return IkutSerta(c: context, id: widget.model?.results?.id,);
                          }
                      ).then((value){
                        if(value!=null){
                          context.read<KegiatanPesertaCubit>().join(value);
                        }
                      });
                    },
                  ),
                ) : SizedBox(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class IkutSerta extends StatefulWidget{
  final int? id;
  final BuildContext c;
  const IkutSerta({Key? key, required this.id, required this.c}) : super (key: key);
  @override
  _IkutSertaState createState() => _IkutSertaState();
}

class _IkutSertaState extends State<IkutSerta>{
  TextEditingController? catatan = TextEditingController();
  GlobalKey<FormState> _form = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            CustomForm(
              label: 'Catatan',
              child:  TextFormField(
                controller: catatan,
                validator: (value) =>
                    validateForm(value.toString(), label: 'Masukkan Catatan'),
                decoration:InputDecoration(
                  hintText: 'Masukkan catatan',
                ),
              ),
            ),
            SizedBox(height: 10,),
            CustomOutlineButton(label: 'Simpan',onPressed: (){
              if(_form.currentState!.validate()){
                Map data = {
                  'id_kegiatan_anggota': widget.id,
                  "keterangan":catatan?.text,
                };
                Navigator.pop(context,data);
              }
            },color: kPrimaryColor,),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)
          ],
        ),
      ),
    );
  }
}