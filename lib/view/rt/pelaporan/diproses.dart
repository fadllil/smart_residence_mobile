import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_residence/bloc/Rt/pelaporan/pelaporan_cubit.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/config/router.gr.dart';
import 'package:smart_residence/model/list_pelaporan_model.dart';
import 'package:smart_residence/service/http_service.dart';
import 'package:smart_residence/utils/string_helper.dart';
import 'package:smart_residence/view/components/error_component.dart';
import 'package:smart_residence/view/components/loading_com.dart';
import 'package:smart_residence/view/components/no_data.dart';
import 'package:smart_residence/view/rt/pelaporan/belum_diproses.dart';

class Diproses extends StatefulWidget{
  final String status;
  const Diproses({Key? key, required this.status}) : super (key: key);

  @override
  _DiprosesState createState() => _DiprosesState();
}

class _DiprosesState extends State<Diproses>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<PelaporanCubit>()..init(widget.status),
      child: Scaffold(
        body: BlocConsumer<PelaporanCubit, PelaporanState>(
          listener: (context, state){
            if(state is PelaporanUpdating){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is PelaporanUpdated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil merubah data');
              AutoRouter.of(context).popAndPush(PelaporanRoute());
            }else if (state is PelaporanError){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message);
            }
          },
          builder: (context, state){
            if(state is PelaporanFailure){
              return ErrorComponent(onPressed: (){
                context.read<PelaporanCubit>().init(widget.status);
              }, message: state.message,);
            }else if(state is PelaporanLoading){
              return LoadingComp();
            }
            return DiprosesBody(
              model: context.select((PelaporanCubit bloc) => bloc.model), http: context.select((PelaporanCubit bloc) => bloc.httpService), status: widget.status,
            );
          },
        ),
      ),
    );
  }
}

class DiprosesBody extends StatefulWidget{
  final String status;
  final ListPelaporanModel? model;
  final HttpService http;
  const DiprosesBody({Key? key, required this.status, required this.model, required this.http}) : super (key: key);

  @override
  _DiprosesBodyState createState() => _DiprosesBodyState();
}

class _DiprosesBodyState extends State<DiprosesBody>{
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
          onRefresh: ()=>context.read<PelaporanCubit>().init(widget.status),
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
                    DateTime? tgl = widget.model?.results?[index].createdAt;
                    DateTime? tgl_diproses = widget.model?.results?[index].tglDiproses;
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                                ),
                                backgroundColor: Colors.white,
                                isScrollControlled: true,
                                context: context,
                                builder: (context){
                                  return ProsesPelaporan(c:context, model: widget.model?.results?[index]);
                                }
                            ).then((value){
                              if(value!=null){
                                context.read<PelaporanCubit>().prosesPelaporan(value, "Selesai");
                              }
                            });
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
                                        Divider(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(widget.model?.results?[index].status ?? ''),
                                            Text('${convertDateTime(tgl_diproses!)}'),
                                          ],
                                        ),
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