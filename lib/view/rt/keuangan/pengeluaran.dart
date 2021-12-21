import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_residence/bloc/Rt/keuangan/pengeluaran/pengeluaran_cubit.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/config/router.gr.dart';
import 'package:smart_residence/constants/themes.dart';
import 'package:smart_residence/model/keuangan_model.dart';
import 'package:smart_residence/model/list_data_kegiatan_model.dart';
import 'package:smart_residence/model/list_pengeluaran_model.dart';
import 'package:smart_residence/utils/string_helper.dart';
import 'package:smart_residence/utils/validate_helper.dart';
import 'package:smart_residence/view/components/custom_button.dart';
import 'package:smart_residence/view/components/custom_form.dart';
import 'package:smart_residence/view/components/error_component.dart';
import 'package:smart_residence/view/components/loading_com.dart';
import 'package:smart_residence/view/components/no_data.dart';

class Pengeluaran extends StatefulWidget{
  const Pengeluaran({Key? key}) : super (key: key);

  @override
  _PengeluaranState createState() => _PengeluaranState();
}

class _PengeluaranState extends State<Pengeluaran>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<PengeluaranCubit>()..init(),
      child: Scaffold(
        body: BlocConsumer<PengeluaranCubit, PengeluaranState>(
          listener: (context, state){
            if(state is PengeluaranCreating){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is PengeluaranCreated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil menambah data');
              AutoRouter.of(context).popAndPush(KeuanganRoute());
            }else if(state is PengeluaranUpdating){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is PengeluaranUpdated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil merubah data');
              AutoRouter.of(context).popAndPush(KeuanganRoute());
            }else if (state is PengeluaranError){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message);
            }
          },
          builder: (context, state){
            if(state is PengeluaranFailure){
              return ErrorComponent(onPressed: (){
                context.read<PengeluaranCubit>().init();
              }, message: state.message,);
            }else if(state is PengeluaranLoading){
              return LoadingComp();
            }
            return PengeluaranBody(
              listDataKegiatanModel: context.select((PengeluaranCubit bloc) => bloc.listDataKegiatanModel),
              model: context.select((PengeluaranCubit bloc) => bloc.model),
              keuanganModel: context.select((PengeluaranCubit bloc) => bloc.keuanganModel),
            );
          },
        ),
      ),
    );
  }
}

class PengeluaranBody extends StatefulWidget{
  final ListPengeluaranModel? model;
  final KeuanganModel? keuanganModel;
  final ListDataKegiatanModel? listDataKegiatanModel;
  const PengeluaranBody({Key? key, required this.model, required this.listDataKegiatanModel, required this.keuanganModel}) : super (key: key);
  @override
  _PengeluaranBodyState createState() => _PengeluaranBodyState();
}

class _PengeluaranBodyState extends State<PengeluaranBody>{
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
              ),
              backgroundColor: Colors.white,
              isScrollControlled: true,
              context: context,
              builder: (context){
                return TambahPengeluaran(c:context, listDataKegiatanModel:widget.listDataKegiatanModel);
              }
          ).then((value){
            if(value!=null){
              context.read<PengeluaranCubit>().createPengeluaran(value);
            }
          });
        },
        label: Text('Tambah'), icon: Icon(Icons.add), backgroundColor: bluePrimary,
      ),
      body: RefreshIndicator(
          key: _refresh,
          onRefresh: ()=>context.read<PengeluaranCubit>().init(),
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

class TambahPengeluaran extends StatefulWidget{
  final ListDataKegiatanModel? listDataKegiatanModel;
  final BuildContext c;
  const TambahPengeluaran({Key? key, required this.listDataKegiatanModel, required this.c}) : super (key: key);

  @override
  _TambahPengeluaranState createState() => _TambahPengeluaranState();
}

class _TambahPengeluaranState extends State<TambahPengeluaran>{
  GlobalKey<FormState> _form = GlobalKey();
  TextEditingController kegiatan = TextEditingController();
  TextEditingController nominal = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  String? id_kegiatan;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Tambah Pengeluaran", style: TextStyle(fontSize: 18),),
              CustomForm(
                label: 'Kegiatan',
                child:  TextFormField(
                  readOnly: true,
                  onTap: (){
                    AutoRouter.of(context).push(CustomOptionWithSearchRoute(options:widget.listDataKegiatanModel?.results
                        ?.map((e)=>{'id':e.id.toString(),'nama':'${e.nama}'}).toList() as List,title: 'Pilih Kegiatan' ))
                        .then((value){
                      if(value!=null){
                        print(value);
                        Results kegiatans = widget.listDataKegiatanModel?.results?.where((element) => element.id.toString()==value.toString()).first??Results();
                        kegiatan.text = '${kegiatans.nama}';
                        id_kegiatan = value.toString();
                        print(kegiatan.text);
                      }
                    });
                  },
                  controller: kegiatan,
                  validator: (value) =>
                      validateForm(value.toString(), label: 'Warga'),
                  decoration:InputDecoration(
                      hintText: 'Pilih kegiatan',
                      suffixIcon: Icon(Icons.arrow_right)
                  ),
                ),
              ),
              CustomForm(
                  label: 'Nominal Pengeluaran',
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    textCapitalization: TextCapitalization.sentences,
                    controller: nominal,
                    decoration: InputDecoration(
                        hintText: "Masukkan nominal pengeluaran"
                    ),
                  )
              ),
              CustomForm(
                  label: "Keterangan",
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: keterangan,
                    validator: (value) => validateForm(value?.toString()?? '', label: 'Keterangan'),
                    decoration: InputDecoration(
                      hintText: 'Masukkan keterangan informasi',
                    ),
                  )
              ),
              SizedBox(height: 20,),
              CustomButton(
                  label: 'Simpan',
                  onPressed: (){
                    FocusScope.of(context).unfocus();
                    if(_form.currentState!.validate()){
                      Map data = {
                        'id_kegiatan' : id_kegiatan,
                        'nominal' : nominal.text,
                        'keterangan' : keterangan.text,
                      };
                      Navigator.pop(context, data);
                    }
                  },
                  color: bluePrimary),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)
            ],
          ),
        ),
      ),
    );
  }
}