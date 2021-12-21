import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:smart_residence/bloc/Rt/tambah_kegiatan/tambah_kegiatan_cubit.dart';
import 'package:smart_residence/config/locator.dart';
import 'package:smart_residence/config/router.gr.dart';
import 'package:smart_residence/constants/themes.dart';
import 'package:smart_residence/model/list_warga_model.dart';
import 'package:smart_residence/utils/string_helper.dart';
import 'package:smart_residence/utils/validate_helper.dart';
import 'package:smart_residence/view/components/custom_button.dart';
import 'package:smart_residence/view/components/custom_form.dart';
import 'package:smart_residence/view/components/custom_outline_button.dart';
import 'package:smart_residence/view/components/error_component.dart';
import 'package:smart_residence/view/components/loading_com.dart';

class TambahKegiatan extends StatelessWidget{
  const TambahKegiatan({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>locator<TambahKegiatanCubit>()..init(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tambah Kegiatan'),
        ),
        body: BlocConsumer<TambahKegiatanCubit,TambahKegiatanState>(
          listener: (context,state){
            if(state is TambahKegiatanCreating){
              EasyLoading.show(status: 'Loading',dismissOnTap: false,maskType: EasyLoadingMaskType.black);
            }else if(state is TambahKegiatanCreated){
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Berhasil menambah data Pengeluaran');
              AutoRouter.of(context).popUntil(ModalRoute.withName(KegiatanRoute.name));
            }else if(state is TambahKegiatanError){
              EasyLoading.dismiss();
              EasyLoading.showError(state.message);
            }
          },
          builder: (context,state){
            if(state is TambahKegiatanLoading){
              return LoadingComp();
            }else if(state is TambahKegiatanFailure){
              return ErrorComponent(onPressed: (){
                context.read<TambahKegiatanCubit>()..init();
              });
            }
            return TambahKegiatanBody(warga: context.select((TambahKegiatanCubit bloc) => bloc.warga),);
          },
        ),
      ),
    );
  }
}

class TambahKegiatanBody extends StatefulWidget{
  final ListWargaModel? warga;
  const TambahKegiatanBody({Key? key, required this.warga}) : super (key: key);

  @override
  _TambahKegiatanBodyState createState() => _TambahKegiatanBodyState();
}

class _TambahKegiatanBodyState extends State<TambahKegiatanBody>{
  GlobalKey<FormState> _form = GlobalKey();
  TextEditingController nama = TextEditingController();
  TextEditingController tgl_mulai = TextEditingController();
  TextEditingController tgl_selesai = TextEditingController();
  TextEditingController lokasi = TextEditingController();
  TextEditingController catatan = TextEditingController();
  TextEditingController nominal = TextEditingController();
  TextEditingController tgl_pembayaran = TextEditingController();
  String? iuran;
  String? jenis_anggota;
  DateTime now = DateTime.now();
  DateFormat formattedDate = DateFormat('yyyy-MM-dd');
  bool _iuran = false;
  bool _nominal = false;
  bool _anggota = false;
  bool _detail_anggota = false;
  List<String>? anggota = [];
  List<String>? keterangan = [];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomForm(
                  label: 'Nama Kegiatan',
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    controller: nama,
                    decoration: InputDecoration(
                        hintText: "Masukkan Nama Kegiatan"
                    ),
                  )
              ),
              CustomForm(
                label: 'Tanggal Mulai',
                child: TextFormField(
                  controller: tgl_mulai,
                  validator: (value)=>validateForm(value.toString(), label: 'Tanggal Mulai'),
                  readOnly: true,
                  onTap: (){
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      firstDate: DateTime(2000),
                    ).then((value){
                      if(value!=null){
                        tgl_mulai.text = dbDateFormat(value);
                      }
                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'Pilih tanggal mulai'
                  ),
                ),
              ),
              CustomForm(
                label: 'Tanggal Selesai',
                child: TextFormField(
                  controller: tgl_selesai,
                  validator: (value)=>validateForm(value.toString(), label: 'Tanggal Selesai'),
                  readOnly: true,
                  onTap: (){
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      firstDate: DateTime(2000),
                    ).then((value){
                      if(value!=null){
                        tgl_selesai.text = dbDateFormat(value);
                      }
                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'Pilih tanggal kegiatan'
                  ),
                ),
              ),
              CustomForm(
                  label: 'Lokasi Kegiatan',
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    controller: lokasi,
                    decoration: InputDecoration(
                        hintText: "Masukkan Lokasi Kegiatan"
                    ),
                  )
              ),
              CustomForm(
                  label: 'Catatan',
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    controller: catatan,
                    decoration: InputDecoration(
                        hintText: "Masukkan Catatan"
                    ),
                  )
              ),
              (_iuran == true)?CustomForm(
                label: 'Jenis Iuran',
                child: DropdownButtonFormField(
                  items: ['Wajib','Tidak Wajib'].map((e) => DropdownMenuItem(
                    child: Text('$e'),
                    value: e,
                  ))
                      .toList(),
                  value: iuran,
                  validator: (value) =>
                      validateForm(value.toString(), label: 'Iuran'),
                  onChanged: (value) {
                    iuran = value.toString();
                    setState(() {
                      if(value=='Wajib'){
                        _nominal = true;
                      }else{
                        _nominal = false;
                      }
                    });
                  },
                  hint: Text('Pilih jenis iuran'),
                ),
              ):SizedBox(),
              (_nominal==true)? CustomForm(
                  label: 'Nominal Iuran',
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    textCapitalization: TextCapitalization.sentences,
                    controller: nominal,
                    decoration: InputDecoration(
                        hintText: "Masukkan nominal iuran"
                    ),
                  )
              ) : SizedBox(),
              (_nominal == true)? CustomForm(
                label: 'Tanggal Pembayaran',
                child: TextFormField(
                  controller: tgl_pembayaran,
                  validator: (value)=>validateForm(value.toString(), label: 'Tanggal Pembayaran'),
                  readOnly: true,
                  onTap: (){
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      firstDate: DateTime(2000),
                    ).then((value){
                      if(value!=null){
                        tgl_pembayaran.text = dbDateFormat(value);
                      }
                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'Pilih tanggal pembayaran'
                  ),
                ),
              ) : SizedBox(),
              SizedBox(height: 20,),
              (_iuran == true)?CustomOutlineButton(
                  label: "Hapus Iuran",
                  onPressed: (){
                    setState(() {
                      if(_iuran == true){
                        _iuran = false;
                        _nominal = false;
                      }
                    });
                  },
                  color: kPrimaryColor):CustomOutlineButton(
                  label: "Tambah Iuran",
                  onPressed: (){
                    setState(() {
                      if(_iuran == false){
                        _iuran = true;
                      }
                    });
                  },
                  color: bluePrimary),
              SizedBox(height: 20,),
              (_anggota == true)?CustomForm(
                label: 'Jenis Anggota',
                child: DropdownButtonFormField(
                  items: ['Panitia','Peserta'].map((e) => DropdownMenuItem(
                    child: Text('$e'),
                    value: e,
                  ))
                      .toList(),
                  value: jenis_anggota,
                  validator: (value) =>
                      validateForm(value.toString(), label: 'Jenis Anggota'),
                  onChanged: (value) {
                    jenis_anggota = value.toString();
                    setState(() {
                      if(value=='Panitia'){
                        _detail_anggota = true;
                      }else{
                        _detail_anggota = false;
                      }
                    });
                  },
                  hint: Text('Pilih jenis anggota'),
                ),
              ):SizedBox(),
              (_detail_anggota == true)?CustomForm(label: 'Anggota', child:
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey),
                ),
                child: (anggota==null||(anggota?.isEmpty??true))?Text('Anggota belum ditambahkan',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),):Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: anggota?.map((e) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.warga?.results?.where((element) => element.idUser.toString()==e).first.user?.nama} - ${keterangan?[anggota?.indexOf(e)??-1]}',
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                      IconButton(onPressed: (){
                        int j = anggota?.indexOf(e)??0;
                        anggota?.removeAt(j);
                        keterangan?.removeAt(j);
                        setState(() {

                        });
                      }, icon: Icon(Icons.delete),color: Colors.red,)
                    ],
                  )).toList()??[],
                ),
              )
              ):SizedBox(),
              SizedBox(height: 20,),
              (_detail_anggota == true)?CustomOutlineButton(label: 'Tambah Anggota', onPressed: (){
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20)),
                  backgroundColor: Colors.white,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) =>
                      SheetAnggota(warga: widget.warga, id: anggota??[],),
                ).then((value){
                  if(value!=null){
                    int i = (anggota?.indexWhere((element) => element==value['anggota'])??-1);
                    anggota?.add(value['anggota']);
                    keterangan?.add(value['keterangan']);
                    setState(() {
                    });
                  }
                });
              }, color: bluePrimary): SizedBox(),
              SizedBox(height: 20,),
              (_anggota == true)?CustomOutlineButton(
                  label: "Hapus Detail Anggota",
                  onPressed: (){
                    setState(() {
                      if(_anggota == true){
                        _anggota = false;
                        _detail_anggota = false;
                      }
                    });
                  },
                  color: kPrimaryColor):CustomOutlineButton(
                  label: "Tambah Detail Anggota",
                  onPressed: (){
                    setState(() {
                      if(_anggota == false){
                        _anggota = true;
                      }
                    });
                  },
                  color: bluePrimary),
              SizedBox(height: 20,),
              CustomOutlineButton(
                  label: "Tambah",
                  onPressed: (){
                    FocusScope.of(context).unfocus();
                    if(_form.currentState!.validate()){
                      Map data = {
                        'nama' : nama.text,
                        'tgl_mulai' : tgl_mulai.text,
                        'tgl_selesai' : tgl_selesai.text,
                        'lokasi' : lokasi.text,
                        'catatan' : catatan.text,
                      };
                      if(_iuran){
                        data['status'] = iuran;
                        if(_nominal){
                          data['nominal'] = nominal.text;
                          data['tgl_terakhir_pembayaran'] = tgl_pembayaran.text;
                        }
                      }
                      if(_anggota){
                        data['status_anggota'] = jenis_anggota;
                        if(_detail_anggota){
                          data['id_user'] = anggota;
                          data['keterangan'] = keterangan;
                        }
                      }
                      context.read<TambahKegiatanCubit>().create(data);
                    }
                  },
                  color: bluePrimary)
            ],
          ),
        ),
      ),
    );
  }
}

class SheetAnggota extends StatefulWidget{
  final ListWargaModel? warga;
  final List<String> id;
  const SheetAnggota({Key? key, required this.warga, required this.id}) : super (key: key);

  @override
  _SheetAnggotaState createState() => _SheetAnggotaState();
}

class _SheetAnggotaState extends State<SheetAnggota>{
  TextEditingController? anggota = TextEditingController();
  String? id_user;
  String? keterangan;
  GlobalKey<FormState> _form = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              CustomForm(
                label: 'Nama Anggota',
                child:  TextFormField(
                  readOnly: true,
                  onTap: (){
                    AutoRouter.of(context).push(CustomOptionWithSearchRoute(options:widget.warga?.results
                        ?.map((e)=>{'id':e.idUser.toString(),'nama':'${e.user?.nama}'}).toList() as List,title: 'Pilih Warga' ))
                        .then((value){
                      if(value!=null){
                        print(value);
                        Result anggotas = widget.warga?.results?.where((element) => element.idUser.toString()==value.toString()).first??Result();
                        anggota?.text = '${anggotas.user?.nama}';
                        id_user = value.toString();
                        print(anggota?.text);
                      }
                    });
                  },
                  controller: anggota,
                  validator: (value) =>
                      validateForm(value.toString(), label: 'Warga'),
                  decoration:InputDecoration(
                      hintText: 'Pilih warga',
                      suffixIcon: Icon(Icons.arrow_right)
                  ),
                ),
              ),
              CustomForm(label: 'Keterangan', child: TextFormField(
                keyboardType: TextInputType.text,
                onChanged: (value){
                  keterangan = value;
                },
                decoration: InputDecoration(
                    hintText: 'Masukkan Keterangan (boleh kosong)'
                ),
              ),
              ),
              SizedBox(height: 20,),
              CustomButton(label: 'Simpan',onPressed: (){
                if(_form.currentState!.validate()){
                  Navigator.pop(context, {
                    'anggota': id_user,
                    'keterangan':keterangan??''
                  });
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