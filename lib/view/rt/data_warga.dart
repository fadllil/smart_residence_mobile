import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataWarga extends StatefulWidget{
  const DataWarga({Key? key}) : super (key: key);

  @override
  _DataWargaState createState() => _DataWargaState();
}

class _DataWargaState extends State<DataWarga>{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: create
    )
  }
}