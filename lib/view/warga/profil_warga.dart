import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:smart_residence/bloc/auth/authentication_cubit.dart';
import 'package:smart_residence/bloc/warga/profil/profil_warga_cubit.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/constants/themes.dart';
import 'package:smart_residence/model/profil_warga_model.dart';
import 'package:smart_residence/utils/validate_helper.dart';
import 'package:smart_residence/view/components/custom_form.dart';
import 'package:smart_residence/view/components/custom_outline_button.dart';
import 'package:smart_residence/view/components/error_component.dart';
import 'package:smart_residence/view/components/loading_com.dart';

class ProfilWarga extends StatefulWidget{
  final TabController tab;
  const ProfilWarga({Key? key, required this.tab}) : super (key: key);

  @override
  _ProfilWargaState createState() => _ProfilWargaState();
}

class _ProfilWargaState extends State<ProfilWarga>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<ProfilWargaCubit>()..init(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profil'),
          elevation: 0,
        ),
        body: BlocConsumer<ProfilWargaCubit, ProfilWargaState>(
          listener: (context, state){
            if(state is ProfilWargaUpdating){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if (state is ProfilWargaUpdated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil merubah profil');
            }else if (state is ProfilWargaError){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message);
            }
          },
          builder: (context, state){
            if(state is ProfilWargaFailure){
              return ErrorComponent(onPressed: context.read<ProfilWargaCubit>().init,message: state.message,);
            }else if(state is ProfilWargaLoading){
              return LoadingComp();
            }
            return ProfilWargaBody(model: context.select((ProfilWargaCubit bloc) => bloc.model),);
          },
        ),
      ),
    );
  }
}

class ProfilWargaBody extends StatefulWidget{
  final ProfilWargaModel? model;
  const ProfilWargaBody({Key? key, required this.model}) : super (key: key);

  @override
  _ProfilWargaBodyState createState() => _ProfilWargaBodyState();
}

class _ProfilWargaBodyState extends State<ProfilWargaBody>{
  @override
  Widget build(BuildContext context) {
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
                  child: Icon(Icons.person, color: bluePrimary, size: 64,),
                ),
                SizedBox(height: 10,),
                Text('${widget.model?.results?.nama}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                Text('${widget.model?.results?.email}', style: TextStyle(color: Colors.white),),
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
                        leading: Icon(Icons.person),
                        title: Text('NIK'),
                        subtitle: Text('${widget.model?.results?.warga?.nik}'),
                      ),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Nomor KK'),
                        subtitle: Text('${widget.model?.results?.warga?.noKk}'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.phone_android),
                        title: Text('No Hp'),
                        subtitle: Text('${widget.model?.results?.warga?.noHp}'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text('Alamat'),
                        subtitle: Text('${widget.model?.results?.warga?.alamat}'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.family_restroom),
                        title: Text('Jumlah Anggota Keluarga'),
                        subtitle: Text('${widget.model?.results?.warga?.jmlAnggotaKeluarga}'),
                      ),
                    ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: blueSecondary,
                  child: ListTile(
                    leading: CircleAvatar(radius:20,child: Icon(Icons.edit,color: bluePrimary,),backgroundColor: Colors.white,),
                    title: Text('Ubah Data',style: TextStyle(color: Colors.white),),
                    onTap: (){
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20)),
                          backgroundColor: Colors.white,
                          isScrollControlled: true,
                          context: context,
                          builder: (context){
                            return SheetProfil(model: widget.model,c: context,);
                          }
                      ).then((value){
                        if(value!=null){
                          context.read<ProfilWargaCubit>().update(value);
                        }
                      });
                    },
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: Colors.red,
                  child: ListTile(
                    onTap: (){
                      context.read<AuthenticationCubit>().logout();
                    },
                    leading: CircleAvatar(radius: 20, backgroundColor: Colors.white, child: Icon(Icons.logout, color: Colors.red,),),
                    title: Text('Logout', style: TextStyle(color: Colors.white),),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SheetProfil extends StatefulWidget{
  final ProfilWargaModel? model;
  final BuildContext c;
  const SheetProfil({Key? key, required this.model, required this.c}) : super (key: key);

  @override
  _SheetProfilState createState() => _SheetProfilState();
}

class _SheetProfilState extends State<SheetProfil>{
  TextEditingController? nama = TextEditingController();
  TextEditingController? email = TextEditingController();
  TextEditingController? nik = TextEditingController();
  TextEditingController? no_kk = TextEditingController();
  TextEditingController? no_hp = TextEditingController();
  TextEditingController? alamat = TextEditingController();
  TextEditingController? jml_anggota_keluarga = TextEditingController();
  GlobalKey<FormState> _form = GlobalKey();
  @override
  void initState() {
    super.initState();
    nama?.text = widget.model?.results?.nama??'';
    email?.text = widget.model?.results?.email??'';
    nik?.text = widget.model?.results?.warga?.nik??'';
    no_kk?.text = widget.model?.results?.warga?.noKk??'';
    no_hp?.text = widget.model?.results?.warga?.noHp??'';
    alamat?.text = widget.model?.results?.warga?.alamat??'';
    jml_anggota_keluarga?.text = widget.model?.results?.warga?.jmlAnggotaKeluarga??'';
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
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              CustomForm(
                label: 'Nama',
                child:  TextFormField(
                  controller: nama,
                  validator: (value) =>
                      validateForm(value.toString(), label: 'Nama'),
                  decoration:InputDecoration(
                    hintText: 'Masukkan Nama',

                  ),
                ),
              ),
              CustomForm(
                label: 'Email',
                child:  TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  validator: (value) =>
                      validateForm(value.toString(), label: 'Email'),
                  decoration:InputDecoration(
                    hintText: 'Masukkan email',

                  ),
                ),
              ),
              CustomForm(
                label: 'NIK',
                child:  TextFormField(
                  controller: nik,
                  validator: (value) =>
                      validateForm(value.toString(), label: 'NIK'),
                  decoration:InputDecoration(
                    hintText: 'Masukkan NIK',
                  ),
                ),
              ),
              CustomForm(
                label: 'Nomor KK',
                child:  TextFormField(
                  controller: no_kk,
                  validator: (value) =>
                      validateForm(value.toString(), label: 'Nomor KK'),
                  decoration:InputDecoration(
                    hintText: 'Masukkan nomor KK',
                  ),
                ),
              ),
              CustomForm(
                label: 'No HP',
                child:  TextFormField(
                  controller: no_hp,
                  validator: (value) =>
                      validateForm(value.toString(), label: 'No HP'),
                  decoration:InputDecoration(
                    hintText: 'Masukkan no HP',
                  ),
                ),
              ),
              CustomForm(
                label: 'Alamat',
                child:  TextFormField(
                  controller: alamat,
                  validator: (value) =>
                      validateForm(value.toString(), label: 'Alamat'),
                  decoration:InputDecoration(
                    hintText: 'Masukkan alamat',
                  ),
                ),
              ),
              CustomForm(
                label: 'Jumlah Anggota Keluarga',
                child:  TextFormField(
                  controller: jml_anggota_keluarga,
                  validator: (value) =>
                      validateForm(value.toString(), label: 'Jumlah Anggota Keluarga'),
                  decoration:InputDecoration(
                    hintText: 'Masukkan jumlah anggota keluarga',
                  ),
                ),
              ),
              SizedBox(height: 10,),
              CustomOutlineButton(label: 'Simpan',onPressed: (){
                if(_form.currentState!.validate()){
                  Map data = {
                    "id": widget.model?.results?.id,
                    "nama":nama?.text,
                    "email":email?.text,
                    "nik":nik?.text,
                    "no_kk":no_kk?.text,
                    "alamat":alamat?.text,
                    "no_hp":no_hp?.text,
                    "jml_anggota_keluarga":jml_anggota_keluarga?.text
                  };
                  Navigator.pop(context,data);
                }
              },color: bluePrimary,),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)
            ],
          ),
        ),
      ),
    );
  }
}