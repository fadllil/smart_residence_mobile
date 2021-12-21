import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_residence/bloc/warga/surat/surat_warga_cubit.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/config/router.gr.dart';
import 'package:smart_residence/constants/themes.dart';
import 'package:smart_residence/model/jenis_surat_model.dart';
import 'package:smart_residence/model/list_surat_warga_model.dart';
import 'package:smart_residence/service/http_service.dart';
import 'package:smart_residence/utils/string_helper.dart';
import 'package:smart_residence/utils/validate_helper.dart';
import 'package:smart_residence/view/components/custom_button.dart';
import 'package:smart_residence/view/components/custom_form.dart';
import 'package:smart_residence/view/components/error_component.dart';
import 'package:smart_residence/view/components/loading_com.dart';
import 'package:smart_residence/view/components/no_data.dart';
import 'package:smart_residence/view/rt/surat/surat.dart';

class PengajuanWarga extends StatefulWidget{
  const PengajuanWarga({Key? key}) : super (key: key);

  @override
  _PengajuanWargaState createState() => _PengajuanWargaState();
}

class _PengajuanWargaState extends State<PengajuanWarga>{
  final String status = "Pengajuan";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<SuratWargaCubit>()..getPengajuanSurat(status),
      child: Scaffold(
        body: BlocConsumer<SuratWargaCubit, SuratWargaState>(
          listener: (context, state){
            if(state is SuratWargaCreating){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is SuratWargaCreated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil menambah data');
              AutoRouter.of(context).popAndPush(SuratWargaRoute());
            }else if(state is SuratWargaUpdating){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is SuratWargaUpdated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil merubah data');
              AutoRouter.of(context).popAndPush(KegiatanRoute());
            }else if (state is SuratWargaError){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message);
            }
          },
          builder: (context, state){
            if(state is SuratWargaFailure){
              return ErrorComponent(onPressed: (){
                context.read<SuratWargaCubit>().getPengajuanSurat(status);
              }, message: state.message,);
            }else if(state is SuratWargaLoading){
              return LoadingComp();
            }
            return PengajuanWargaBody(
              model: context.select((SuratWargaCubit bloc) => bloc.model),
              jenisSuratModel: context.select((SuratWargaCubit bloc) => bloc.jenisSuratModel),
              http: context.select((SuratWargaCubit bloc) => bloc.httpService), status: status,);
          },
        ),
      ),
    );
  }
}

class PengajuanWargaBody extends StatefulWidget{
  final String status;
  final ListSuratWargaModel? model;
  final JenisSuratModel? jenisSuratModel;
  final HttpService http;
  const PengajuanWargaBody({Key? key, required this.status, required this.model, required this.jenisSuratModel, required this.http}) : super (key: key);

  @override
  _PengajuanWargaBodyState createState() => _PengajuanWargaBodyState();
}

class _PengajuanWargaBodyState extends State<PengajuanWargaBody>{
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
                return TambahSurat(c:context, jenisSuratModel: widget.jenisSuratModel,);
              }
          ).then((value){
            if(value!=null){
              context.read<SuratWargaCubit>().create(value);
            }
          });
        },
        label: Text('Tambah'), icon: Icon(Icons.add), backgroundColor: bluePrimary,
      ),
      body: RefreshIndicator(
          key: _refresh,
          onRefresh: ()=>context.read<SuratWargaCubit>().getPengajuanSurat(widget.status),
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
                                            Text('${widget.model?.results ? [index]
                                                .jenisSurat?.jenis}',
                                              style: TextStyle(fontSize: 18),),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('${convertDateTime(tgl!)}'),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                        Text(widget.model?.results?[index].keterangan ?? ''),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            // IconButton(
                                            //     onPressed: (){
                                            //       showModalBottomSheet(
                                            //           shape: RoundedRectangleBorder(
                                            //               borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                                            //           ),
                                            //           backgroundColor: Colors.white,
                                            //           isScrollControlled: true,
                                            //           context: context,
                                            //           builder: (context) {
                                            //             return EditInformasi(model: widget.model, c:context, index:index);
                                            //           }
                                            //       ).then((value) {
                                            //         if(value!= null){
                                            //           context.read<InformasiCubit>().updateInformasi(value);
                                            //         }
                                            //       });
                                            //     },
                                            //     icon: Icon(Icons.edit, color: bluePrimary,)
                                            // ),
                                            // IconButton(
                                            //     onPressed: (){
                                            //       int? id = widget.model?.results?[index].id;
                                            //       showModalBottomSheet(
                                            //           shape: RoundedRectangleBorder(
                                            //             borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                            //           ),
                                            //           backgroundColor: Colors.white,
                                            //           isScrollControlled: true,
                                            //           context: context,
                                            //           builder: (c) => Container(
                                            //             padding: EdgeInsets.all(20),
                                            //             child: Column(
                                            //               mainAxisSize: MainAxisSize.min,
                                            //               children: [
                                            //                 Text('Apakah anda ingin menghapus data?', style: TextStyle(fontSize: 18),),
                                            //                 SizedBox(height: 20,),
                                            //                 CustomButton(
                                            //                     label: 'Hapus',
                                            //                     onPressed: (){
                                            //                       FocusScope.of(context).unfocus();
                                            //                       String? _id = id.toString();
                                            //                       context.read<InformasiCubit>().deleteInformasi(_id);
                                            //                       Navigator.pop(context);
                                            //                     },
                                            //                     color: kPrimaryColor)
                                            //               ],
                                            //             ),
                                            //           )
                                            //       );
                                            //     },
                                            //     icon: Icon(Icons.delete, color: Colors.red,)
                                            // ),
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

class TambahSurat extends StatefulWidget{
  final BuildContext c;
  final JenisSuratModel? jenisSuratModel;
  const TambahSurat({Key? key, required this.c, required this.jenisSuratModel}) : super (key: key);

  @override
  _TambahSuratState createState() => _TambahSuratState();
}

class _TambahSuratState extends State<TambahSurat>{
  GlobalKey<FormState> _form = GlobalKey();
  TextEditingController keterangan = TextEditingController();
  TextEditingController tgl = TextEditingController();
  String? jenis;
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
              Text("Ajukan Pembuatan Surat", style: TextStyle(fontSize: 18),),
              CustomForm(
                label: 'Jenis Surat',
                child: DropdownButtonFormField(
                  items: widget.jenisSuratModel?.results?.map((e) => DropdownMenuItem(
                    child: Text('${e.jenis}'),
                    value: e.id.toString(),
                  ))
                      .toList(),
                  value: jenis,
                  validator: (value) =>
                      validateForm(value.toString(), label: 'Surat'),
                  onChanged: (value) {
                    jenis = value.toString();
                  },
                  hint: Text('Pilih jenis surat'),
                ),
              ),
              CustomForm(
                label: 'Tanggal Pemakaian Surat',
                child: TextFormField(
                  controller: tgl,
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
                        tgl.text = dbDateFormat(value);
                      }
                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'Pilih tanggal'
                  ),
                ),
              ),
              CustomForm(
                  label: "Keterangan",
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: keterangan,
                    validator: (value) => validateForm(value?.toString()?? '', label: 'Keterangan'),
                    decoration: InputDecoration(
                      hintText: 'Masukkan keterangan',
                    ),
                  )
              ),
              SizedBox(height: 20,),
              CustomButton(
                  label: 'Simpan',
                  onPressed: (){
                    FocusScope.of(context).unfocus();
                    if(_form.currentState!.validate()){
                      Map data = {
                        'id_jenis_surat' : jenis,
                        'keterangan' : keterangan.text,
                        'tanggal' : tgl.text
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