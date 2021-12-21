import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_residence/bloc/Rt/keuangan/pemasukan/pemasukan_cubit.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/constants/themes.dart';
import 'package:smart_residence/model/keuangan_model.dart';
import 'package:smart_residence/model/list_pemasukan_model.dart';
import 'package:smart_residence/utils/string_helper.dart';
import 'package:smart_residence/view/components/error_component.dart';
import 'package:smart_residence/view/components/loading_com.dart';
import 'package:smart_residence/view/components/no_data.dart';

class PemasukanWarga extends StatefulWidget{
  const PemasukanWarga({Key? key}) : super (key: key);

  @override
  _PemasukanWargaState createState() => _PemasukanWargaState();
}

class _PemasukanWargaState extends State<PemasukanWarga>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<PemasukanCubit>()..init(),
      child: Scaffold(
        body: BlocBuilder<PemasukanCubit, PemasukanState>(
          builder: (context, state){
            if(state is PemasukanFailure){
              return ErrorComponent(onPressed: (){
                context.read<PemasukanCubit>().init();
              }, message: state.message,);
            }else if(state is PemasukanLoading){
              return LoadingComp();
            }
            return PemasukanWargaBody(
              model: context.select((PemasukanCubit bloc) => bloc.model),
              keuanganModel: context.select((PemasukanCubit bloc) => bloc.keuanganModel),
            );
          },
        ),
      ),
    );
  }
}

class PemasukanWargaBody extends StatefulWidget{
  final ListPemasukanModel? model;
  final KeuanganModel? keuanganModel;
  const PemasukanWargaBody({Key? key, required this.model, required this.keuanganModel}) : super (key: key);

  @override
  _PemasukanWargaBodyState createState() => _PemasukanWargaBodyState();
}

class _PemasukanWargaBodyState extends State<PemasukanWargaBody>{
  ScrollController _scrollController = ScrollController();
  GlobalKey<RefreshIndicatorState> _refresh = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    int? kas = widget.keuanganModel?.resultss?.nominal;
    return Scaffold(
      body: RefreshIndicator(
          key: _refresh,
          onRefresh: ()=>context.read<PemasukanCubit>().init(),
          child: (widget.model?.results?.isEmpty??true)?NoData(message: 'Data belum ada') : SingleChildScrollView(
            controller: _scrollController..addListener(() {
            }),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.money),
                          title: Text('Kas RT'),
                          subtitle: Text('${kas != null ? valueRupiah(kas) : 'Belum Ada Kas'}'),
                        ),
                      ],
                    ),
                  ),
                ),
                Text('Pemasukan'),
                Container(
                  padding: EdgeInsets.all(10),
                  child: ListView.builder(
                      itemCount: widget.model?.results?.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        DateTime? tgl = widget.model?.results?[index].createdAt;
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
                                      Expanded(
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: kPrimaryColor,
                                          child: Icon(
                                            Icons.money,
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
                                                Text('${widget.model?.results ? [index].kegiatan?.nama}',
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
                                            Text('${widget.model?.results?[index].nominal}'),
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
              ],
            ),
          )
      ),
    );
  }
}