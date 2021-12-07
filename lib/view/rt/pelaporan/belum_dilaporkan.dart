import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_residence/bloc/Rt/pelaporan/pelaporan_cubit.dart';
import 'package:smart_residence/bloc/warga/pelaporan/pelaporan_warga_cubit.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/config/router.gr.dart';
import 'package:smart_residence/constants/themes.dart';
import 'package:smart_residence/utils/image_picker_helper.dart';
import 'package:smart_residence/utils/string_helper.dart';
import 'package:smart_residence/utils/validate_helper.dart';
import 'package:smart_residence/view/components/custom_button.dart';
import 'package:smart_residence/view/components/custom_form.dart';
import 'package:smart_residence/view/components/error_component.dart';
import 'package:smart_residence/view/components/loading_com.dart';
import 'package:smart_residence/view/rt/informasi/informasi.dart';

class BelumDilaporkan extends StatefulWidget{
  const BelumDilaporkan({Key? key}) : super (key: key);

  @override
  _BelumDilaporkanState createState() => _BelumDilaporkanState();
}

class _BelumDilaporkanState extends State<BelumDilaporkan>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<PelaporanCubit>()..init(),
      child: Scaffold(
        body: BlocConsumer<PelaporanCubit, PelaporanState>(
          listener: (context, state){
            if(state is PelaporanCreating){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is PelaporanCreated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil menambah data');
              AutoRouter.of(context).popAndPush(PelaporanRoute());
            }else if(state is PelaporanUpdating){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is PelaporanUpdated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil merubah data');
              AutoRouter.of(context).popAndPush(KegiatanRoute());
            }else if(state is PelaporanUpdatingStatus){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is PelaporanUpdatedStatus){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil merubah status');
              AutoRouter.of(context).popAndPush(KegiatanRoute());
            }else if (state is PelaporanError){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message);
            }
          },
          builder: (context, state){
            if(state is PelaporanFailure){
              return ErrorComponent(onPressed: (){
                context.read<PelaporanCubit>().init();
              }, message: state.message,);
            }else if(state is PelaporanLoading){
              return LoadingComp();
            }
            return BelumDilaporkanBody(
                // model: context.select((PelaporanCubit bloc) => bloc.model)
            );
          },
        ),
      ),
    );
  }
}

class BelumDilaporkanBody extends StatefulWidget{
  // final ListKegiatanModel? model;
  const BelumDilaporkanBody({Key? key}) : super (key: key);

  @override
  _BelumDilaporkanBodyState createState() => _BelumDilaporkanBodyState();
}

class _BelumDilaporkanBodyState extends State<BelumDilaporkanBody>{
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
                return TambahPelaporan(c:context);
              }
          ).then((value){
            if(value!=null){
              context.read<PelaporanWargaCubit>().create(value);
            }
          });
        },
        label: Text('Tambah'), icon: Icon(Icons.add), backgroundColor: bluePrimary,
      ),
      // body: RefreshIndicator(
      //     key: _refresh,
      //     onRefresh: ()=>context.read<InformasiCubit>().init(),
      //     child: (widget.model?.results?.isEmpty??true)?NoData(message: 'Data belum ada') : SingleChildScrollView(
      //       controller: _scrollController..addListener(() {
      //       }),
      //       child: Container(
      //         padding: EdgeInsets.all(10),
      //         child: ListView.builder(
      //             itemCount: widget.model?.results?.length,
      //             physics: NeverScrollableScrollPhysics(),
      //             shrinkWrap: true,
      //             itemBuilder: (context, index) {
      //               DateTime? tgl = widget.model?.results?[index].tanggal;
      //               return Column(
      //                 children: [
      //                   InkWell(
      //                     onTap: () {
      //
      //                     },
      //                     child: Card(
      //                       shape: RoundedRectangleBorder(
      //                         borderRadius: BorderRadius.circular(10),
      //                       ),
      //                       child: Container(
      //                         padding: EdgeInsets.all(10),
      //                         child: Row(
      //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                           children: [
      //                             // Expanded(
      //                             //   child: CircleAvatar(
      //                             //     radius: 20,
      //                             //     backgroundColor: kPrimaryColor,
      //                             //     child: Icon(
      //                             //       Icons.perm_device_information,
      //                             //       color: Colors.white,
      //                             //     ),
      //                             //   ),
      //                             // ),
      //                             // Spacer(),
      //                             Expanded(
      //                               flex: 8,
      //                               child: Column(
      //                                 crossAxisAlignment: CrossAxisAlignment.start,
      //                                 children: [
      //                                   Row(
      //                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                                     children: [
      //                                       Text(widget.model?.results ? [index]
      //                                           .judul ?? '',
      //                                         style: TextStyle(fontSize: 18),),
      //                                       Column(
      //                                         crossAxisAlignment: CrossAxisAlignment.start,
      //                                         children: [
      //                                           Text('${convertDateTime(tgl!)}'),
      //                                         ],
      //                                       ),
      //                                     ],
      //                                   ),
      //                                   Container(
      //                                     child: Image.network('${widget.http.base}${widget.model?.results?[index].gambar}'),
      //                                   ),
      //                                   Divider(),
      //                                   Text(widget.model?.results?[index].isi ?? ''),
      //                                   Divider(),
      //                                   Text(widget.model?.results?[index].keterangan ?? ''),
      //                                   Row(
      //                                     crossAxisAlignment: CrossAxisAlignment.end,
      //                                     mainAxisAlignment: MainAxisAlignment.end,
      //                                     children: [
      //                                       IconButton(
      //                                           onPressed: (){
      //                                             showModalBottomSheet(
      //                                                 shape: RoundedRectangleBorder(
      //                                                     borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
      //                                                 ),
      //                                                 backgroundColor: Colors.white,
      //                                                 isScrollControlled: true,
      //                                                 context: context,
      //                                                 builder: (context) {
      //                                                   return EditInformasi(model: widget.model, c:context, index:index);
      //                                                 }
      //                                             ).then((value) {
      //                                               if(value!= null){
      //                                                 context.read<InformasiCubit>().updateInformasi(value);
      //                                               }
      //                                             });
      //                                           },
      //                                           icon: Icon(Icons.edit, color: bluePrimary,)
      //                                       ),
      //                                       IconButton(
      //                                           onPressed: (){
      //                                             int? id = widget.model?.results?[index].id;
      //                                             showModalBottomSheet(
      //                                                 shape: RoundedRectangleBorder(
      //                                                   borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      //                                                 ),
      //                                                 backgroundColor: Colors.white,
      //                                                 isScrollControlled: true,
      //                                                 context: context,
      //                                                 builder: (c) => Container(
      //                                                   padding: EdgeInsets.all(20),
      //                                                   child: Column(
      //                                                     mainAxisSize: MainAxisSize.min,
      //                                                     children: [
      //                                                       Text('Apakah anda ingin menghapus data?', style: TextStyle(fontSize: 18),),
      //                                                       SizedBox(height: 20,),
      //                                                       CustomButton(
      //                                                           label: 'Hapus',
      //                                                           onPressed: (){
      //                                                             FocusScope.of(context).unfocus();
      //                                                             String? _id = id.toString();
      //                                                             context.read<InformasiCubit>().deleteInformasi(_id);
      //                                                             Navigator.pop(context);
      //                                                           },
      //                                                           color: kPrimaryColor)
      //                                                     ],
      //                                                   ),
      //                                                 )
      //                                             );
      //                                           },
      //                                           icon: Icon(Icons.delete, color: Colors.red,)
      //                                       ),
      //                                     ],
      //                                   )
      //                                 ],
      //                               ),
      //                             )
      //                           ],
      //                         ),
      //                       ),
      //                     ),
      //                   )
      //                 ],
      //               );
      //             }
      //         ),
      //       ),
      //     )
      // ),
    );
  }
}

class TambahPelaporan extends StatefulWidget{
  final BuildContext c;
  const TambahPelaporan({Key? key, required this.c}) : super (key: key);

  @override
  _TambahPelaporanState createState() => _TambahPelaporanState();
}

class _TambahPelaporanState extends State<TambahPelaporan>{
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
                        'tgl_diproses' : tanggal.text,
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