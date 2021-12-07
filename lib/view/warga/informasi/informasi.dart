import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_residence/bloc/warga/informasi/informasi_warga_cubit.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/model/list_informasi_model.dart';
import 'package:smart_residence/service/http_service.dart';
import 'package:smart_residence/utils/string_helper.dart';
import 'package:smart_residence/view/components/error_component.dart';
import 'package:smart_residence/view/components/loading_com.dart';
import 'package:smart_residence/view/components/no_data.dart';

class InformasiWarga extends StatefulWidget{
  final TabController tab;
  const InformasiWarga({Key? key, required this.tab}) : super (key: key);

  @override
  _InformasiWargaState createState() => _InformasiWargaState();
}

class _InformasiWargaState extends State<InformasiWarga>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<InformasiWargaCubit>()..init(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profil'),
          elevation: 0,
        ),
        body: BlocBuilder<InformasiWargaCubit, InformasiWargaState>(
          builder: (context, state){
            if(state is InformasiWargaFailure){
              return ErrorComponent(onPressed: context.read<InformasiWargaCubit>().init,message: state.message,);
            }else if(state is InformasiWargaLoading){
              return LoadingComp();
            }
            return InformasiWargaBody(model: context.select((InformasiWargaCubit bloc) => bloc.model), http: context.select((InformasiWargaCubit bloc) => bloc.httpService),);
          },
        ),
      ),
    );
  }
}

class InformasiWargaBody extends StatefulWidget{
  final ListInformasiModel? model;
  final HttpService http;
  const InformasiWargaBody({Key? key, required this.model, required this.http}) : super (key: key);


  @override
  _InformasiBodyState createState() => _InformasiBodyState();
}

class _InformasiBodyState extends State<InformasiWargaBody>{
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
          onRefresh: ()=>context.read<InformasiWargaCubit>().init(),
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