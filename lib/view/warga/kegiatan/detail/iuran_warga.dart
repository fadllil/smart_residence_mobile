import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_residence/bloc/warga/kegiatan/iuran/iuran_warga_cubit.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/config/router.gr.dart';
import 'package:smart_residence/constants/themes.dart';
import 'package:smart_residence/model/detail_iuran_warga_model.dart';
import 'package:smart_residence/utils/image_picker_helper.dart';
import 'package:smart_residence/utils/string_helper.dart';
import 'package:smart_residence/utils/validate_helper.dart';
import 'package:smart_residence/view/components/custom_form.dart';
import 'package:smart_residence/view/components/custom_outline_button.dart';
import 'package:smart_residence/view/components/error_component.dart';
import 'package:smart_residence/view/components/loading_com.dart';
import 'package:smart_residence/view/components/no_data.dart';
import 'package:smart_residence/view/rt/informasi/informasi.dart';

class IuranWarga extends StatefulWidget{
  final int id;
  const IuranWarga({Key? key, required this.id}) : super (key: key);

  @override
  _IuranWargaState createState() => _IuranWargaState();
}

class _IuranWargaState extends State<IuranWarga>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<IuranWargaCubit>()..init(widget.id.toString()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detail Iuran Kegiatan'),
          elevation: 0,
        ),
        body: BlocConsumer<IuranWargaCubit, IuranWargaState>(
          listener: (context, state){
            if(state is IuranWargaUpdating){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is IuranWargaUpdated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil merubah data');
              AutoRouter.of(context).popAndPush(IuranWargaRoute(id: widget.id));
            }else if (state is IuranWargaError){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message);
            }
          },
          builder: (context, state){
            if(state is IuranWargaFailure){
              return ErrorComponent(onPressed: (){
                context.read<IuranWargaCubit>().init(widget.id.toString());
              }, message: state.message,);
            }else if(state is IuranWargaLoading){
              return LoadingComp();
            }
            return IuranWargaBody(model: context.select((IuranWargaCubit bloc) => bloc.model), id: widget.id);
          },
        ),
      ),
    );
  }
}

class IuranWargaBody extends StatefulWidget{
  final DetailIuranWargaModel? model;
  final int id;
  const IuranWargaBody({Key? key, required this.model, required this.id}) : super (key: key);

  @override
  _IuranWargaBodyState createState() => _IuranWargaBodyState();
}

class _IuranWargaBodyState extends State<IuranWargaBody>{
  @override
  Widget build(BuildContext context) {
    DateTime? tgl = widget.model?.results?.tglTerakhirPembayaran;
    DateTime? tgl_pembayaran = widget.model?.results?.getIuran?.tglPembayaran;
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
                  child: Icon(Icons.payment, color: bluePrimary, size: 64,),
                ),
                SizedBox(height: 10,),
                Text('${widget.model?.results?.kegiatan?.nama}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                Text('Iuran ${widget.model?.results?.status}', style: TextStyle(color: Colors.white),),
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
                        leading: Icon(Icons.payment),
                        title: Text('Nominal Iuran'),
                        subtitle: Text('${widget.model?.results?.nominal ?? 'Tidak Ada'}'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.calendar_today_outlined),
                        title: Text('Terakhir Pembayaran'),
                        subtitle: Text('${ tgl != null ? convertDateTime(tgl) : "Tidak Ada"}'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.notification_important),
                        title: Text('Status'),
                        subtitle: Text('${widget.model?.results?.getIuran?.status ?? 'Belum Bayar'}'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.calendar_today_outlined),
                        title: Text('Tanggal Pembayaran'),
                        subtitle: Text('${tgl_pembayaran != null ? convertDateTime(tgl_pembayaran) : 'Belum Bayar' }'),
                      ),
                    ],
                  ),
                ),
                (widget.model?.results?.berpartisipasi == false || (widget.model?.results?.status == 'Wajib' && widget.model?.results?.getIuran?.status == "Belum Bayar")) ? Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: blueSecondary,
                  child: ListTile(
                    leading: CircleAvatar(radius:20,child: Icon(Icons.payment,color: bluePrimary,),backgroundColor: Colors.white,),
                    title: Text('Bayar',style: TextStyle(color: Colors.white),),
                    onTap: (){
                      int? id_detail;
                      if (widget.model?.results?.status == 'Wajib'){
                        id_detail = widget.model?.results?.getIuran?.id;
                      }else{
                        id_detail = widget.model?.results?.id;
                      }
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20)),
                          backgroundColor: Colors.white,
                          isScrollControlled: true,
                          context: context,
                          builder: (context){
                            return SheetBayar(c: context, id: id_detail, status:widget.model?.results?.status);
                          }
                      ).then((value){
                        if(value!=null){
                          if (widget.model?.results?.status == "Wajib"){
                            context.read<IuranWargaCubit>().bayar(value, "Wajib");
                          }else{
                            context.read<IuranWargaCubit>().bayar(value, "Tidak Wajib");
                          }
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

class SheetBayar extends StatefulWidget{
  final int? id;
  final BuildContext c;
  final String? status;
  const SheetBayar({Key? key, required this.id, required this.c, required this.status}) : super (key: key);
  @override
  _SheetBayarState createState() => _SheetBayarState();
}

class _SheetBayarState extends State<SheetBayar>{
  TextEditingController? nominal = TextEditingController();
  TextEditingController? keterangan = TextEditingController();
  GlobalKey<FormState> _form = GlobalKey();
  String? foto;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              CustomForm(
                label: 'Upload Bukti Pembayaran',
                child: (foto==null||(foto?.isEmpty??false))
                    ? InkWell(
                  onTap: () async {
                    showDialog(context: context, builder: (c)=>CameraDialog()).then((value)async{
                      if(value!=null){
                        foto = await ImagePickerHelper.getImage(
                            value);
                        setState(() {

                        });
                      }
                    });
                  },
                  child: Align(
                    alignment:Alignment.center,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: 200,
                      decoration: BoxDecoration(
                        border:
                        Border.all(color: Colors.grey),
                        borderRadius:
                        BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 40,
                            color: Colors.black
                                .withOpacity(0.6),
                          ),

                        ],
                      ),
                    ),
                  ),
                )
                    : Stack(
                  children: [
                    Container(
                      child: Image.file(File(
                          foto??'')),
                    ),
                    Positioned(
                        top: 10,
                        right: 10,
                        child: InkWell(
                          onTap: () {
                            foto =
                            "";
                            setState(() {});
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.black
                                .withOpacity(0.7),
                            child: Icon(
                              Icons.clear,
                              color: Colors.white,
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              (widget.status == "Tidak Wajib") ? CustomForm(
                  label: 'Nominal',
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    textCapitalization: TextCapitalization.sentences,
                    controller: nominal,
                    decoration: InputDecoration(
                        hintText: "Masukkan nominal"
                    ),
                  )
              ) : SizedBox(),
              CustomForm(
                label: 'Catatan',
                child:  TextFormField(
                  controller: keterangan,
                  keyboardType: TextInputType.text,
                  validator: (value) =>
                      validateForm(value.toString(), label: 'Catatan'),
                  decoration:InputDecoration(
                    hintText: 'Masukkan Catatan',

                  ),
                ),
              ),
              SizedBox(height: 10,),
              CustomOutlineButton(label: 'Simpan',onPressed: (){
                if(_form.currentState!.validate()){
                  Map data = {
                    "id": widget.id,
                    'foto' : foto,
                    "keterangan":keterangan?.text,
                  };
                  if (widget.status != "Wajib"){
                    data['nominal'] = nominal?.text;
                  }
                  Navigator.pop(context,data);
                }
              },color: bluePrimary,),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)
            ],
          ),
        ),
      ),
    );
  }
}