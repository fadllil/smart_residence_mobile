import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_residence/bloc/warga/kegiatan/peserta/kegiatan_peserta_cubit.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/constants/themes.dart';
import 'package:smart_residence/model/detail_anggota_model.dart';
import 'package:smart_residence/view/components/error_component.dart';
import 'package:smart_residence/view/components/loading_com.dart';
import 'package:smart_residence/view/components/no_data.dart';

class Peserta extends StatefulWidget{
  final int id;
  const Peserta({Key? key, required this.id}) : super (key: key);

  @override
  _PesertaState createState() => _PesertaState();
}

class _PesertaState extends State<Peserta>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<KegiatanPesertaCubit>()..init(widget.id),
      child: Scaffold(
        body: BlocBuilder<KegiatanPesertaCubit, KegiatanPesertaState>(
          builder: (context, state){
            if(state is KegiatanPesertaFailure){
              return ErrorComponent(onPressed: (){
                context.read<KegiatanPesertaCubit>().init(widget.id);
              }, message: state.message,);
            }else if(state is KegiatanPesertaLoading){
              return LoadingComp();
            }
            return PesertaBody(model: context.select((KegiatanPesertaCubit bloc) => bloc.model), id: widget.id);
          },
        ),
      ),
    );
  }
}

class PesertaBody extends StatefulWidget{
  final int id;
  final DetailAnggotaModel? model;
  const PesertaBody({Key? key, required this.id, required this.model}) : super (key: key);
  @override
  _PesertaBodyState createState() => _PesertaBodyState();
}

class _PesertaBodyState extends State<PesertaBody>{
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
        onRefresh: ()=>context.read<KegiatanPesertaCubit>().init(widget.id),
        child: (widget.model?.results?.detailAnggota?.isEmpty??true)?NoData(message: 'Data belum ada') : SingleChildScrollView(
          controller: _scrollController..addListener(() {

          }),
          child: Container(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
                itemCount: widget.model?.results?.detailAnggota?.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index){
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
                                        Text(widget.model?.results?.detailAnggota?[index]
                                            .user?.nama ?? '',
                                          style: TextStyle(fontSize: 18),),
                                        Divider(),
                                        Text(widget.model?.results?.detailAnggota?[index].keterangan ?? ''),
                                        Divider(),
                                        (widget.model?.results?.detailAnggota?[index].namaDidaftarkan == null)?Text(widget.model?.results?.detailAnggota?[index].namaDidaftarkan ?? '') : SizedBox(),
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