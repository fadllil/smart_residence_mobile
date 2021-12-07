import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_residence/bloc/Rt/kegiatan/iuran/kegiatan_iuran_cubit.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/config/router.gr.dart';
import 'package:smart_residence/constants/themes.dart';
import 'package:smart_residence/model/detail_iuran_model.dart';
import 'package:smart_residence/model/list_kegiatan_model.dart';
import 'package:smart_residence/view/components/error_component.dart';
import 'package:smart_residence/view/components/loading_com.dart';
import 'package:smart_residence/view/components/no_data.dart';

class Iuran extends StatefulWidget{
  final int id;
  const Iuran({Key? key, required this.id}) : super (key: key);

  @override
  _IuranState createState() => _IuranState();
}

class _IuranState extends State<Iuran>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<KegiatanIuranCubit>()..init(widget.id.toString()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Detail Anggota Kegiatan'),
        ),
        body: BlocConsumer<KegiatanIuranCubit, KegiatanIuranState>(
          listener: (context, state){
            if(state is KegiatanIuranUpdating){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is KegiatanIuranUpdated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil merubah data');
              AutoRouter.of(context).popAndPush(IuranRoute(id: widget.id));
            }else if (state is KegiatanIuranError){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message);
            }
          },
          builder: (context, state){
            if(state is KegiatanIuranFailure){
              return ErrorComponent(onPressed: (){
                context.read<KegiatanIuranCubit>().init(widget.id.toString());
              }, message: state.message,);
            }else if(state is KegiatanIuranLoading){
              return LoadingComp();
            }
            return IuranBody(model: context.select((KegiatanIuranCubit bloc) => bloc.model), id: widget.id,);
          },
        ),
      ),
    );
  }
}

class IuranBody extends StatefulWidget{
  final int id;
  final DetailIuranModel? model;
  const IuranBody({Key? key, required this.id, required this.model}) : super (key: key);

  @override
  _IuranBodyState createState() => _IuranBodyState();
}

class _IuranBodyState extends State<IuranBody>{
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
        onRefresh: ()=>context.read<KegiatanIuranCubit>().init(widget.id.toString()),
        child: (widget.model?.results?.detailIuran?.isEmpty??true)?NoData(message: 'Data belum ada') : SingleChildScrollView(
          controller: _scrollController..addListener(() {

          }),
          child: Container(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
                itemCount: widget.model?.results?.detailIuran?.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index){
                  DateTime? tgl = widget.model?.results?.detailIuran?[index].tglPembayaran;
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
                                        Text(widget.model?.results?.detailIuran?[index]
                                            .user?.nama ?? '',
                                          style: TextStyle(fontSize: 18),),
                                        Divider(),
                                        Text(widget.model?.results?.detailIuran?[index].uang ?? ''),
                                        Divider(),
                                        Text('${tgl}'),
                                        Divider(),
                                        Text(widget.model?.results?.detailIuran?[index].status ?? ''),
                                        Divider(),
                                        Text(widget.model?.results?.detailIuran?[index].keterangan ?? ''),
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