import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_residence/bloc/Rt/jenis_surat/jenis_surat_cubit.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/config/router.gr.dart';
import 'package:smart_residence/constants/themes.dart';
import 'package:smart_residence/model/jenis_surat_model.dart';
import 'package:smart_residence/utils/validate_helper.dart';
import 'package:smart_residence/view/components/custom_button.dart';
import 'package:smart_residence/view/components/custom_form.dart';
import 'package:smart_residence/view/components/error_component.dart';
import 'package:smart_residence/view/components/loading_com.dart';
import 'package:smart_residence/view/components/no_data.dart';

class JenisSurat extends StatefulWidget{
  const JenisSurat({Key? key}) :super (key: key);

  @override
  _JenisSuratState createState() => _JenisSuratState();
}

class _JenisSuratState extends State<JenisSurat>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<JenisSuratCubit>()..init(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Jenis Surat'),
        ),
        body: BlocConsumer<JenisSuratCubit, JenisSuratState>(
          listener: (context, state){
            if(state is JenisSuratCreating){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is JenisSuratCreated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil menambah data');
              AutoRouter.of(context).popAndPush(JenisSuratRoute());
            }else if(state is JenisSuratUpdating){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is JenisSuratUpdated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil merubah data');
              AutoRouter.of(context).popAndPush(InformasiRoute());
            }else if(state is JenisSuratDeleting){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is JenisSuratDeleted){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil menghapus data');
              AutoRouter.of(context).popAndPush(InformasiRoute());
            }else if (state is JenisSuratError){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message);
            }
          },
          builder: (context, state){
            if(state is JenisSuratFailure){
              return ErrorComponent(onPressed: (){
                context.read<JenisSuratCubit>().init();
              }, message: state.message,);
            }else if(state is JenisSuratLoading){
              return LoadingComp();
            }
            return JenisSuratBody(
              model: context.select((JenisSuratCubit bloc) => bloc.model),
            );
          },
        ),
      ),
    );
  }
}

class JenisSuratBody extends StatefulWidget{
  final JenisSuratModel? model;
  const JenisSuratBody({Key? key, required this.model}) : super (key: key);


  @override
  _JenisSuratBodyState createState() => _JenisSuratBodyState();
}

class _JenisSuratBodyState extends State<JenisSuratBody>{
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
                return TambahJenisSurat(c:context);
              }
          ).then((value){
            if(value!=null){
              context.read<JenisSuratCubit>().create(value);
            }
          });
        },
        label: Text('Tambah'), icon: Icon(Icons.add), backgroundColor: bluePrimary,
      ),
      body: RefreshIndicator(
          key: _refresh,
          onRefresh: ()=>context.read<JenisSuratCubit>().init(),
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
                          Text(widget.model?.results?[index].jenis??''),
                        ],
                      ),
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: bluePrimary,
                        child: Icon(Icons.insert_drive_file_rounded, color: Colors.white,),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(icon: Icon(Icons.edit, color: bluePrimary,), onPressed: (){
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                ),
                                backgroundColor: Colors.white,
                                isScrollControlled: true,
                                context: context,
                                builder: (context){
                                  return UpdateJenisSurat(model: widget.model, c:context, index:index);
                                }
                            ).then((value) {
                              if (value!=null){
                                context.read<JenisSuratCubit>().update(value);
                              }
                            });
                          },
                          ),
                          IconButton(icon: Icon(Icons.delete), onPressed: (){
                            int? id = widget.model?.results?[index].id;
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
                                      Text('Apakah anda ingin mengahapus data?', style: TextStyle(fontSize: 18),),
                                      SizedBox(height: 20,),
                                      CustomButton(
                                          label: 'Ya',
                                          onPressed: (){
                                            FocusScope.of(context).unfocus();
                                            context.read<JenisSuratCubit>().delete(id.toString());
                                            Navigator.pop(context);
                                          },
                                          color: kPrimaryColor)
                                    ],
                                  ),
                                ));
                          },
                            color: Colors.red,
                          ),
                        ],
                      ),

                    ),
                    Divider()
                  ],
                ) ,
              ),
            ),
          )
      ),
    );
  }
}

class UpdateJenisSurat extends StatefulWidget{
  final JenisSuratModel? model;
  final BuildContext c;
  final int index;
  const UpdateJenisSurat({Key? key, required this.c, required this.model, required this.index}) : super (key: key);

  @override
  _UpdateJenisSuratState createState() => _UpdateJenisSuratState();
}

class _UpdateJenisSuratState extends State<UpdateJenisSurat>{
  GlobalKey<FormState> _form = GlobalKey();
  TextEditingController jenis = TextEditingController();
  @override
  void initState() {
    super.initState();
    jenis.text = widget.model?.results?[widget.index].jenis ?? '';
  }
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
              Text("Tambah Jenis Surat", style: TextStyle(fontSize: 18),),
              CustomForm(
                  label: "Jenis Surat",
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: jenis,
                    validator: (value) => validateForm(value?.toString()?? '', label: 'Jenis Surat'),
                    decoration: InputDecoration(
                      hintText: 'Masukkan jenis surat',
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
                        'id' : widget.model?.results?[widget.index].id,
                        'jenis' : jenis.text,
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

class TambahJenisSurat extends StatefulWidget{
  final BuildContext c;
  const TambahJenisSurat({Key? key, required this.c}) : super (key: key);

  @override
  _TambahJenisSuratState createState() => _TambahJenisSuratState();
}

class _TambahJenisSuratState extends State<TambahJenisSurat>{
  GlobalKey<FormState> _form = GlobalKey();
  TextEditingController jenis = TextEditingController();
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
              Text("Tambah Jenis Surat", style: TextStyle(fontSize: 18),),
              CustomForm(
                  label: "Jenis Surat",
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: jenis,
                    validator: (value) => validateForm(value?.toString()?? '', label: 'Jenis Surat'),
                    decoration: InputDecoration(
                      hintText: 'Masukkan jenis surat',
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
                        'jenis' : jenis.text,
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