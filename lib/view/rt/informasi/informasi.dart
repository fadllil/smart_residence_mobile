import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_residence/bloc/Rt/informasi/informasi_cubit.dart';
import 'package:smart_residence/bloc/Rt/kegiatan/kegiatan_cubit.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/config/router.gr.dart';
import 'package:smart_residence/constants/themes.dart';
import 'package:smart_residence/model/list_informasi_model.dart';
import 'package:smart_residence/service/http_service.dart';
import 'package:smart_residence/utils/image_picker_helper.dart';
import 'package:smart_residence/utils/string_helper.dart';
import 'package:smart_residence/utils/validate_helper.dart';
import 'package:smart_residence/view/components/custom_button.dart';
import 'package:smart_residence/view/components/custom_form.dart';
import 'package:smart_residence/view/components/error_component.dart';
import 'package:smart_residence/view/components/loading_com.dart';
import 'package:smart_residence/view/components/no_data.dart';

class Informasi extends StatefulWidget{
  const Informasi({Key? key}) :super (key: key);

  @override
  _InformasiState createState() => _InformasiState();
}

class _InformasiState extends State<Informasi>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<InformasiCubit>()..init(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Informasi RT'),
        ),
        body: BlocConsumer<InformasiCubit, InformasiState>(
          listener: (context, state){
            if(state is InformasiCreating){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is InformasiCreated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil menambah data');
              AutoRouter.of(context).popAndPush(InformasiRoute());
            }else if(state is InformasiUpdating){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is InformasiUpdated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil merubah data');
              AutoRouter.of(context).popAndPush(InformasiRoute());
            }else if(state is InformasiDeleting){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is InformasiDeleted){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil menghapus data');
              AutoRouter.of(context).popAndPush(InformasiRoute());
            }else if (state is InformasiError){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message!);
            }
          },
          builder: (context, state){
            if(state is InformasiFailure){
              return ErrorComponent(onPressed: (){
                context.read<InformasiCubit>().init();
              }, message: state.message,);
            }else if(state is InformasiLoading){
              return LoadingComp();
            }
            return InformasiBody(model: context.select((InformasiCubit bloc) => bloc.model), http: context.select((InformasiCubit bloc) => bloc.httpService),);
          },
        ),
      ),
    );
  }
}

class InformasiBody extends StatefulWidget{
  final ListInformasiModel? model;
  final HttpService http;
  const InformasiBody({Key? key, required this.model, required this.http}) : super (key: key);


  @override
  _InformasiBodyState createState() => _InformasiBodyState();
}

class _InformasiBodyState extends State<InformasiBody>{
  ScrollController _scrollController = ScrollController();
  GlobalKey<RefreshIndicatorState> _refresh = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
              ),
              backgroundColor: Colors.white,
              isScrollControlled: true,
              context: context,
              builder: (context){
                return TambahInformasi(c:context);
              }
          ).then((value){
            if(value!=null){
              context.read<InformasiCubit>().createInformasi(value);
            }
          });
        },
        label: Text('Tambah'), icon: Icon(Icons.add), backgroundColor: bluePrimary,
      ),
      body: RefreshIndicator(
          key: _refresh,
          onRefresh: ()=>context.read<InformasiCubit>().init(),
          child: (widget.model?.results?.isEmpty??true)?NoData(message: 'Data belum ada') : SingleChildScrollView(
            controller: _scrollController..addListener(() {
            }),
            child: Container(
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                  itemCount: widget.model?.results?.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DateTime? tgl = widget.model?.results?[index].tanggal;
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {

                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Expanded(
                                  //   child: CircleAvatar(
                                  //     radius: 20,
                                  //     backgroundColor: kPrimaryColor,
                                  //     child: Icon(
                                  //       Icons.perm_device_information,
                                  //       color: Colors.white,
                                  //     ),
                                  //   ),
                                  // ),
                                  // Spacer(),
                                  Expanded(
                                    flex: 8,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(widget.model?.results ? [index]
                                                .judul ?? '',
                                              style: TextStyle(fontSize: 18),),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('${convertDateTime(tgl!)}'),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Container(
                                          child: Image.network('${widget.http.base}${widget.model?.results?[index].gambar}'),
                                        ),
                                        Divider(),
                                        Text(widget.model?.results?[index].isi ?? ''),
                                        Divider(),
                                        Text(widget.model?.results?[index].keterangan ?? ''),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            IconButton(
                                                onPressed: (){
                                                  showModalBottomSheet(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                                                      ),
                                                      backgroundColor: Colors.white,
                                                      isScrollControlled: true,
                                                      context: context,
                                                      builder: (context) {
                                                        return EditInformasi(model: widget.model, c:context, index:index);
                                                      }
                                                  ).then((value) {
                                                    if(value!= null){
                                                      context.read<InformasiCubit>().updateInformasi(value);
                                                    }
                                                  });
                                                },
                                                icon: Icon(Icons.edit, color: bluePrimary,)
                                            ),
                                            IconButton(
                                                onPressed: (){
                                                  int? id = widget.model?.results?[index].id;
                                                  showModalBottomSheet(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                                      ),
                                                      backgroundColor: Colors.white,
                                                      isScrollControlled: true,
                                                      context: context,
                                                      builder: (c) => Container(
                                                        padding: EdgeInsets.all(20),
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Text('Apakah anda ingin menghapus data?', style: TextStyle(fontSize: 18),),
                                                            SizedBox(height: 20,),
                                                            CustomButton(
                                                                label: 'Hapus',
                                                                onPressed: (){
                                                                  FocusScope.of(context).unfocus();
                                                                  String? _id = id.toString();
                                                                  context.read<InformasiCubit>().deleteInformasi(_id);
                                                                  Navigator.pop(context);
                                                                },
                                                                color: kPrimaryColor)
                                                          ],
                                                        ),
                                                      )
                                                  );
                                                },
                                                icon: Icon(Icons.delete, color: Colors.red,)
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }
              ),
            ),
          )
      ),
    );
  }
}

class TambahInformasi extends StatefulWidget{
  final BuildContext c;
  const TambahInformasi({Key? key, required this.c}) : super (key: key);

  @override
  _TambahInformasiState createState() => _TambahInformasiState();
}

class _TambahInformasiState extends State<TambahInformasi>{
  GlobalKey<FormState> _form = GlobalKey();
  TextEditingController judul = TextEditingController();
  TextEditingController isi = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  TextEditingController tanggal = TextEditingController();
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
            children: [
              Text("Tambah Informasi", style: TextStyle(fontSize: 18),),
              CustomForm(
                  label: "Judul",
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: judul,
                    validator: (value) => validateForm(value?.toString()?? '', label: 'Judul'),
                    decoration: InputDecoration(
                      hintText: 'Masukkan judul informasi',
                    ),
                  )
              ),
              CustomForm(
                  label: "Isi",
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    controller: isi,
                    maxLines: 6,
                    validator: (value) => validateForm(value?.toString()?? '', label: 'Isi Informasi'),
                    decoration: InputDecoration(
                      hintText: 'Masukkan isi informasi',
                    ),
                  )
              ),
              CustomForm(
                  label: "Keterangan",
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: keterangan,
                    validator: (value) => validateForm(value?.toString()?? '', label: 'Keterangan'),
                    decoration: InputDecoration(
                      hintText: 'Masukkan keterangan informasi',
                    ),
                  )
              ),
              CustomForm(
                label: 'Tanggal',
                child: TextFormField(
                  controller: tanggal,
                  validator: (value)=>validateForm(value.toString(), label: 'Tanggal'),
                  readOnly: true,
                  onTap: (){
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      firstDate: DateTime(2000),
                    ).then((value){
                      if(value!=null){
                        tanggal.text = dbDateFormat(value);
                      }
                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'Pilih tanggal kegiatan'
                  ),
                ),
              ),
              CustomForm(
                label: 'Foto Informasi',
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
              SizedBox(height: 20,),
              CustomButton(
                  label: 'Simpan',
                  onPressed: (){
                    FocusScope.of(context).unfocus();
                    if(_form.currentState!.validate()){
                      Map data = {
                        'judul' : judul.text,
                        'isi' : isi.text,
                        'keterangan' : keterangan.text,
                        'tanggal' : tanggal.text,
                        'foto' : foto
                      };
                      Navigator.pop(context, data);
                    }
                  },
                  color: bluePrimary),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)
            ],
          ),
        ),
      ),
    );
  }
}

class EditInformasi extends StatefulWidget{
  final BuildContext c;
  final ListInformasiModel? model;
  final int index;
  const EditInformasi({Key? key, required this.c, required this.model, required this.index}) : super (key: key);

  @override
  _EditInformasiState createState() => _EditInformasiState();
}

class _EditInformasiState extends State<EditInformasi>{
  GlobalKey<FormState> _form = GlobalKey();
  TextEditingController judul = TextEditingController();
  TextEditingController isi = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  TextEditingController tanggal = TextEditingController();
  @override
  void initState() {
    super.initState();
    DateTime? tgl = widget.model?.results?[widget.index].tanggal;
    judul.text = widget.model?.results?[widget.index].judul ?? '';
    isi.text = widget.model?.results?[widget.index].isi ?? '';
    keterangan.text = widget.model?.results?[widget.index].keterangan ?? '';
    tanggal.text = dbDateFormat(tgl!);
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Tambah Informasi", style: TextStyle(fontSize: 18),),
              CustomForm(
                  label: "Judul",
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: judul,
                    validator: (value) => validateForm(value?.toString()?? '', label: 'Judul'),
                    decoration: InputDecoration(
                      hintText: 'Masukkan judul informasi',
                    ),
                  )
              ),
              CustomForm(
                  label: "Isi",
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    controller: isi,
                    maxLines: 6,
                    validator: (value) => validateForm(value?.toString()?? '', label: 'Isi Informasi'),
                    decoration: InputDecoration(
                      hintText: 'Masukkan isi informasi',
                    ),
                  )
              ),
              CustomForm(
                  label: "Keterangan",
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: keterangan,
                    validator: (value) => validateForm(value?.toString()?? '', label: 'Keterangan'),
                    decoration: InputDecoration(
                      hintText: 'Masukkan keterangan informasi',
                    ),
                  )
              ),
              CustomForm(
                label: 'Tanggal',
                child: TextFormField(
                  controller: tanggal,
                  validator: (value)=>validateForm(value.toString(), label: 'Tanggal'),
                  readOnly: true,
                  onTap: (){
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      firstDate: DateTime(2000),
                    ).then((value){
                      if(value!=null){
                        tanggal.text = dbDateFormat(value);
                      }
                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'Pilih tanggal kegiatan'
                  ),
                ),
              ),
              SizedBox(height: 20,),
              CustomButton(
                  label: 'Simpan',
                  onPressed: (){
                    FocusScope.of(context).unfocus();
                    if(_form.currentState!.validate()){
                      Map data = {
                        'id' : widget.model?.results?[widget.index].id,
                        'judul' : judul.text,
                        'isi' : isi.text,
                        'keterangan' : keterangan.text,
                        'tanggal' : tanggal.text,
                      };
                      Navigator.pop(context, data);
                    }
                  },
                  color: bluePrimary),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)
            ],
          ),
        ),
      ),
    );
  }
}

class CameraDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Pilih dari kamera'),
              onTap: (){
                Navigator.pop(context,ImageSource.camera);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Pilih dari galeri'),
              onTap: (){
                Navigator.pop(context,ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }
}