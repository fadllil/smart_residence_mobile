import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_residence/bloc/warga/surat/surat_warga_cubit.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/config/router.gr.dart';
import 'package:smart_residence/model/list_surat_warga_model.dart';
import 'package:smart_residence/service/http_service.dart';
import 'package:smart_residence/utils/string_helper.dart';
import 'package:smart_residence/view/components/error_component.dart';
import 'package:smart_residence/view/components/loading_com.dart';
import 'package:smart_residence/view/components/no_data.dart';

class SelesaiWarga extends StatefulWidget{
  const SelesaiWarga({Key? key}) : super (key: key);

  @override
  _SelesaiWargaState createState() => _SelesaiWargaState();
}

class _SelesaiWargaState extends State<SelesaiWarga>{
  final String status = 'Selesai';
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
            return SelesaiWargaBody(model: context.select((SuratWargaCubit bloc) => bloc.model), http: context.select((SuratWargaCubit bloc) => bloc.httpService), status: status,);
          },
        ),
      ),
    );
  }
}

class SelesaiWargaBody extends StatefulWidget{
  final String status;
  final ListSuratWargaModel? model;
  final HttpService http;
  const SelesaiWargaBody({Key? key, required this.status, required this.model, required this.http}) : super (key: key);

  @override
  _SelesaiWargaBodyState createState() => _SelesaiWargaBodyState();
}

class _SelesaiWargaBodyState extends State<SelesaiWargaBody>{
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