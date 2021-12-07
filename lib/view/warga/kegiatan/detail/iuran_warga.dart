import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_residence/bloc/warga/kegiatan/iuran/iuran_warga_cubit.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/config/router.gr.dart';
import 'package:smart_residence/constants/themes.dart';
import 'package:smart_residence/model/detail_iuran_warga_model.dart';
import 'package:smart_residence/utils/string_helper.dart';
import 'package:smart_residence/view/components/error_component.dart';
import 'package:smart_residence/view/components/loading_com.dart';
import 'package:smart_residence/view/components/no_data.dart';

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
                        subtitle: Text('${widget.model?.results?.nominal}'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.calendar_today_outlined),
                        title: Text('Terakhir Pembayaran'),
                        subtitle: Text('${convertDateTime(tgl!)}'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.notification_important),
                        title: Text('Status'),
                        subtitle: Text('${widget.model?.results?.getIuran?.status}'),
                      ),
                    ],
                  ),
                ),
                // Card(
                //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                //   color: blueSecondary,
                //   child: ListTile(
                //     leading: CircleAvatar(radius:20,child: Icon(Icons.edit,color: bluePrimary,),backgroundColor: Colors.white,),
                //     title: Text('Ubah Data',style: TextStyle(color: Colors.white),),
                //     onTap: (){
                //       showModalBottomSheet(
                //           shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(
                //                   20)),
                //           backgroundColor: Colors.white,
                //           isScrollControlled: true,
                //           context: context,
                //           builder: (context){
                //             return SheetProfil(model: widget.model,c: context,);
                //           }
                //       ).then((value){
                //         if(value!=null){
                //           context.read<ProfilRtCubit>().update(value);
                //         }
                //       });
                //     },
                //   ),
                // ),
                // Card(
                //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                //   color: Colors.red,
                //   child: ListTile(
                //     onTap: (){
                //       context.read<AuthenticationCubit>().logout();
                //     },
                //     leading: CircleAvatar(radius: 20, backgroundColor: Colors.white, child: Icon(Icons.logout, color: Colors.red,),),
                //     title: Text('Logout', style: TextStyle(color: Colors.white),),
                //   ),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}