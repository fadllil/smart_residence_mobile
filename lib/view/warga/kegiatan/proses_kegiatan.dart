import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_residence/bloc/Rt/kegiatan/kegiatan_cubit.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/config/router.gr.dart';
import 'package:smart_residence/constants/themes.dart';
import 'package:smart_residence/model/list_kegiatan_model.dart';
import 'package:smart_residence/utils/string_helper.dart';
import 'package:smart_residence/view/components/custom_button.dart';
import 'package:smart_residence/view/components/error_component.dart';
import 'package:smart_residence/view/components/loading_com.dart';
import 'package:smart_residence/view/components/no_data.dart';

class ProsesKegiatan extends StatefulWidget{
  const ProsesKegiatan({Key? key}) :super (key: key);

  @override
  _ProsesKegiatanState createState() => _ProsesKegiatanState();
}

class _ProsesKegiatanState extends State<ProsesKegiatan>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<KegiatanCubit>()..proses(),
      child: Scaffold(
        body: BlocConsumer<KegiatanCubit, KegiatanState>(
          listener: (context, state){
            if(state is KegiatanUpdating){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is KegiatanUpdated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil merubah data');
            }else if(state is KegiatanUpdatingStatus){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is KegiatanUpdatedStatus){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil merubah status');
            }else if (state is KegiatanError){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message);
            }
          },
          builder: (context, state){
            if(state is KegiatanFailure){
              return ErrorComponent(onPressed: (){
                context.read<KegiatanCubit>().proses();
              }, message: state.message,);
            }else if(state is KegiatanLoading){
              return LoadingComp();
            }
            return ProsesKegiatanBody(model: context.select((KegiatanCubit bloc) => bloc.model));
          },
        ),
      ),
    );
  }
}

class ProsesKegiatanBody extends StatefulWidget{
  final ListKegiatanModel? model;
  const ProsesKegiatanBody({Key? key, required this.model}) : super (key: key);

  @override
  _ProsesKegiatanBodyState createState() => _ProsesKegiatanBodyState();
}

class _ProsesKegiatanBodyState extends State<ProsesKegiatanBody>{
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
        onRefresh: ()=>context.read<KegiatanCubit>().proses(),
        child: (widget.model?.results?.isEmpty??true)?NoData(message: 'Data belum ada') : SingleChildScrollView(
          controller: _scrollController..addListener(() {

          }),
          child: Container(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
                itemCount: widget.model?.results?.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index){
                  DateTime? tgl_mulai = widget.model?.results?[index].tglMulai;
                  DateTime? tgl_selesai = widget.model?.results?[index].tglSelesai;
                  return Column(
                    children: [
                      InkWell(
                        onTap: (){

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
                                Expanded(
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: kPrimaryColor,
                                    child: Icon(
                                      Icons.perm_device_information,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Expanded(
                                  flex: 8,
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(widget.model?.results ? [index]
                                                .nama ?? '',
                                              style: TextStyle(fontSize: 18),),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('${convertDateTime(tgl_mulai!)}'),
                                                Text('${convertDateTime(tgl_selesai!)}'),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                        Text(widget.model?.results?[index].lokasi ?? ''),
                                        Divider(),
                                        Text(widget.model?.results?[index].catatan ?? ''),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            (widget.model?.results?[index].anggota?.isEmpty == false) ? IconButton(
                                                onPressed: (){
                                                  int? id = widget.model?.results?[index].id;
                                                  AutoRouter.of(context).push(AnggotaRoute(id: id!));
                                                },
                                                icon: Icon(Icons.people, color: bluePrimary,)
                                            ) : SizedBox(),
                                            (widget.model?.results?[index].iuran?.isEmpty == false) ? IconButton(
                                                onPressed: (){
                                                  int? id = widget.model?.results?[index].id;
                                                  AutoRouter.of(context).push(IuranWargaRoute(id: id!));
                                                },
                                                icon: Icon(Icons.money, color: Colors.green,)
                                            ) : SizedBox(),
                                          ],
                                        )
                                      ]
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
        ),
      ),
    );
  }
}