import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_residence/bloc/Rt/datawarga/data_warga_cubit.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/config/router.gr.dart';
import 'package:smart_residence/constants/themes.dart';
import 'package:smart_residence/model/list_warga_model.dart';
import 'package:smart_residence/view/components/custom_button.dart';
import 'package:smart_residence/view/components/error_component.dart';
import 'package:smart_residence/view/components/loading_com.dart';
import 'package:smart_residence/view/components/no_data.dart';

class TidakAktif extends StatefulWidget{
  const TidakAktif({Key? key}) :super (key: key);

  @override
  _TidakAktifState createState() => _TidakAktifState();
}

class _TidakAktifState extends State<TidakAktif>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<DataWargaCubit>()..tidakAktif(),
      child: Scaffold(
        body: BlocConsumer<DataWargaCubit, DataWargaState>(
          listener: (context, state){
            if(state is DataWargaUpdating){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is DataWargaUpdated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil merubah data');
              AutoRouter.of(context).popAndPush(WargaRoute());
            }else if (state is DataWargaError){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message!);
            }
          },
          builder: (context, state){
            if(state is DataWargaFailure){
              return ErrorComponent(onPressed: (){
                context.read<DataWargaCubit>().tidakAktif();
              }, message: state.message,);
            }else if(state is DataWargaLoading){
              return LoadingComp();
            }
            return TidakAktifBody(model: context.select((DataWargaCubit bloc) => bloc.model));
          },
        ),
      ),
    );
  }
}

class TidakAktifBody extends StatefulWidget{
  final ListWargaModel? model;
  const TidakAktifBody({Key? key, required this.model}) : super (key: key);

  @override
  _TidakAktifBodyState createState() => _TidakAktifBodyState();
}

class _TidakAktifBodyState extends State<TidakAktifBody>{
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
        onRefresh: ()=>context.read<DataWargaCubit>().init(),
        child: (widget.model?.results?.isEmpty??true)?NoData(message: 'Data belum ada') : SingleChildScrollView(
          controller: _scrollController..addListener(() {

          }),
          child: Container(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: widget.model?.results?.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index)=>Column(
                children: [
                  ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.model?.results?[index].user?.nama??''),
                        Text(widget.model?.results?[index].user?.email??''),
                      ],
                    ),
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: bluePrimary,
                      child: Icon(Icons.person, color: Colors.white,),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(icon: Icon(Icons.check_box), onPressed: (){
                          int? id = widget.model?.results?[index].idUser;
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
                                    Text('Apakah anda ingin mengaktifkan akun warga?', style: TextStyle(fontSize: 18),),
                                    SizedBox(height: 20,),
                                    CustomButton(
                                        label: 'Ya',
                                        onPressed: (){
                                          FocusScope.of(context).unfocus();
                                          context.read<DataWargaCubit>().updateStatus(id.toString());
                                          Navigator.pop(context);
                                        },
                                        color: bluePrimary)
                                  ],
                                ),
                              ));
                        },
                          color: Colors.green,
                        ),
                      ],
                    ),
                    onTap: (){
                      AutoRouter.of(context).push(DetailWargaRoute(model: widget.model, index: index));
                    },
                  ),
                  Divider()
                ],
              ) ,
            ),
          ),
        ),
      ),
    );
  }
}