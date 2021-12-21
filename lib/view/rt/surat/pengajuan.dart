import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_residence/bloc/Rt/surat/surat_cubit.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/config/router.gr.dart';
import 'package:smart_residence/model/list_surat_model.dart';
import 'package:smart_residence/utils/string_helper.dart';
import 'package:smart_residence/view/components/error_component.dart';
import 'package:smart_residence/view/components/loading_com.dart';
import 'package:smart_residence/view/components/no_data.dart';

class Pengajuan extends StatefulWidget{
  const Pengajuan({Key? key}) : super (key: key);

  @override
  _PengajuanState createState() => _PengajuanState();
}

class _PengajuanState extends State<Pengajuan>{
  final String status = "Pengajuan";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<SuratCubit>()..getSurat(status),
      child: Scaffold(
        body: BlocConsumer<SuratCubit, SuratState>(
          listener: (context, state){
            if(state is SuratUpdating){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is SuratUpdated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil merubah data');
              AutoRouter.of(context).popAndPush(SuratRoute());
            }else if (state is SuratError){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message);
            }
          },
          builder: (context, state){
            if(state is SuratFailure){
              return ErrorComponent(onPressed: (){
                context.read<SuratCubit>().getSurat(status);
              }, message: state.message,);
            }else if(state is SuratLoading){
              return LoadingComp();
            }
            return PengajuanBody(
              model: context.select((SuratCubit bloc) => bloc.model), status: status,);
          },
        ),
      ),
    );
  }
}

class PengajuanBody extends StatefulWidget{
  final String status;
  final ListSuratModel? model;
  const PengajuanBody({Key? key, required this.status, required this.model}) : super (key: key);

  @override
  _PengajuanBodyState createState() => _PengajuanBodyState();
}

class _PengajuanBodyState extends State<PengajuanBody>{
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
          onRefresh: ()=>context.read<SuratCubit>().getSurat(widget.status),
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
                                                .user?.nama}',
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
                                        Text('${widget.model?.results ? [index]
                                            .jenisSurat?.jenis}',
                                          style: TextStyle(fontSize: 14),),
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