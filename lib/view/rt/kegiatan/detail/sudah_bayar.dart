import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_residence/bloc/Rt/kegiatan/iuran/kegiatan_iuran_cubit.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/constants/themes.dart';
import 'package:smart_residence/model/detail_iuran_model.dart';
import 'package:smart_residence/utils/string_helper.dart';
import 'package:smart_residence/view/components/error_component.dart';
import 'package:smart_residence/view/components/loading_com.dart';
import 'package:smart_residence/view/components/no_data.dart';

class SudahBayar extends StatefulWidget{
  final int id;
  const SudahBayar({Key? key, required this.id}) : super (key: key);

  @override
  _SudahBayarState createState() => _SudahBayarState();
}

class _SudahBayarState extends State<SudahBayar>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<KegiatanIuranCubit>()..sudahBayar(widget.id.toString()),
      child: Scaffold(
        body: BlocBuilder<KegiatanIuranCubit, KegiatanIuranState>(
          builder: (context, state){
            if(state is KegiatanIuranFailure){
              return ErrorComponent(onPressed: (){
                context.read<KegiatanIuranCubit>().sudahBayar(widget.id.toString());
              }, message: state.message,);
            }else if(state is KegiatanIuranLoading){
              return LoadingComp();
            }
            return SudahBayarBody(model: context.select((KegiatanIuranCubit bloc) => bloc.model), id: widget.id,);
          },
        ),
      ),
    );
  }
}

class SudahBayarBody extends StatefulWidget{
  final int id;
  final DetailIuranModel? model;
  const SudahBayarBody({Key? key, required this.id, required this.model}) : super (key: key);

  @override
  _SudahBayarBodyState createState() => _SudahBayarBodyState();
}

class _SudahBayarBodyState extends State<SudahBayarBody>{
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
        onRefresh: ()=>context.read<KegiatanIuranCubit>().sudahBayar(widget.id.toString()),
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
                  DateTime? tgl = widget.model?.results?[index].tglPembayaran;
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
                                        Text(widget.model?.results?[index]
                                            .user?.nama ?? '',
                                          style: TextStyle(fontSize: 18),),
                                        Divider(),
                                        Text('${widget.model?.results?[index].uang}'),
                                        Divider(),
                                        Text('${tgl != null ? convertDateTime(tgl) : 'Belum Bayar' }'),
                                        Divider(),
                                        Text(widget.model?.results?[index].status ?? ''),
                                        Divider(),
                                        Text(widget.model?.results?[index].keterangan ?? ''),
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