import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_residence/bloc/Rt/datawarga/data_warga_cubit.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/config/router.gr.dart';
import 'package:smart_residence/constants/themes.dart';
import 'package:smart_residence/model/list_warga_model.dart';
import 'package:smart_residence/utils/validate_helper.dart';
import 'package:smart_residence/view/components/custom_button.dart';
import 'package:smart_residence/view/components/custom_form.dart';
import 'package:smart_residence/view/components/error_component.dart';
import 'package:smart_residence/view/components/loading_com.dart';
import 'package:smart_residence/view/components/no_data.dart';

class Aktif extends StatefulWidget{
  const Aktif({Key? key}) :super (key: key);

  @override
  _AktifState createState() => _AktifState();
}

class _AktifState extends State<Aktif>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<DataWargaCubit>()..init(),
      child: Scaffold(
        body: BlocConsumer<DataWargaCubit, DataWargaState>(
          listener: (context, state){
            if(state is DataWargaCreating){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is DataWargaCreated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil menambah data');
              AutoRouter.of(context).popAndPush(WargaRoute());
            }else if(state is DataWargaUpdating){
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
                context.read<DataWargaCubit>().init();
              }, message: state.message,);
            }else if(state is DataWargaLoading){
              return LoadingComp();
            }
            return AktifBody(model: context.select((DataWargaCubit bloc) => bloc.model));
          },
        ),
      ),
    );
  }
}

class AktifBody extends StatefulWidget{
  final ListWargaModel? model;
  const AktifBody({Key? key, required this.model}) : super (key: key);

  @override
  _AktifBodyState createState() => _AktifBodyState();
}

class _AktifBodyState extends State<AktifBody>{
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
              builder: (context) {
                return Tambah(c:context);
              }
          ).then((value){
            if(value!=null){
              context.read<DataWargaCubit>().create(value);
            }
          });
        },
        label: Text('Tambah'), icon: Icon(Icons.add), backgroundColor: bluePrimary,
      ),
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
                        IconButton(icon: Icon(Icons.edit, color: bluePrimary,), onPressed: (){
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                              ),
                              backgroundColor: Colors.white,
                              isScrollControlled: true,
                              context: context,
                              builder: (context){
                                return Update(model: widget.model, c:context, index:index);
                              }
                          ).then((value) {
                            if (value!=null){
                              context.read<DataWargaCubit>().update(value);
                            }
                          });
                        },
                        ),
                        IconButton(icon: Icon(Icons.cancel), onPressed: (){
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
                                    Text('Apakah anda ingin menonaktifkan akun warga?', style: TextStyle(fontSize: 18),),
                                    SizedBox(height: 20,),
                                    CustomButton(
                                        label: 'Ya',
                                        onPressed: (){
                                          FocusScope.of(context).unfocus();
                                          context.read<DataWargaCubit>().updateStatus(id.toString());
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

class Tambah extends StatefulWidget{
  final BuildContext c;
  const Tambah({Key? key, required this.c}) : super (key: key);

  @override
  _TambahState createState() => _TambahState();
}

class _TambahState extends State<Tambah>{
  GlobalKey<FormState> _form = GlobalKey();
  TextEditingController nama = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Tambah Warga", style: TextStyle(fontSize: 18),),
            CustomForm(
                label: "Nama",
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: nama,
                  validator: (value) => validateForm(value?.toString()?? '', label: 'Nama'),
                  decoration: InputDecoration(
                    hintText: 'Masukkan nama warga',
                  ),
                )
            ),
            CustomForm(
                label: "Email",
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  validator: (value) => validateForm(value?.toString()?? '', label: 'Email'),
                  decoration: InputDecoration(
                    hintText: 'Masukkan email warga',
                  ),
                )
            ),
            CustomForm(
                label: "Password",
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: password,
                  validator: (value) => validateForm(value?.toString()?? '', label: 'Password'),
                  decoration: InputDecoration(
                    hintText: 'Masukkan password warga',
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
                      'nama' : nama.text,
                      'email' : email.text,
                      'password' : password.text
                    };
                    Navigator.pop(context, data);
                  }
                },
                color: bluePrimary),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)
          ],
        ),
      ),
    );
  }
}

class Update extends StatefulWidget{
  final BuildContext c;
  final ListWargaModel? model;
  final int index;
  const Update({Key? key, required this.c, required this.model, required this.index}) : super (key: key);

  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update>{
  GlobalKey<FormState> _form = GlobalKey();
  TextEditingController nama = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  void initState() {
    super.initState();
    nama.text = widget.model?.results?[widget.index].user?.nama??'';
    email.text = widget.model?.results?[widget.index].user?.email??'';
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _form,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Edit Warga", style: TextStyle(fontSize: 18),),
            CustomForm(
                label: "Nama",
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: nama,
                  validator: (value) => validateForm(value?.toString()?? '', label: 'Nama'),
                  decoration: InputDecoration(
                    hintText: 'Masukkan nama warga',
                  ),
                )
            ),
            CustomForm(
                label: "Email",
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  validator: (value) => validateForm(value?.toString()?? '', label: 'Email'),
                  decoration: InputDecoration(
                    hintText: 'Masukkan email warga',
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
                      'id' : widget.model?.results?[widget.index].idUser,
                      'nama' : nama.text,
                      'email' : email.text,
                    };
                    Navigator.pop(context, data);
                  }
                },
                color: bluePrimary),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)
          ],
        ),
      ),
    );
  }
}