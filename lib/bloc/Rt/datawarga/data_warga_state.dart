part of 'data_warga_cubit.dart';

abstract class DataWargaState extends Equatable {
  const DataWargaState();

  @override
  List<Object> get props => [];
}

class DataWargaInitial extends DataWargaState {}
class DataWargaLoading extends DataWargaState {}
class DataWargaLoaded extends DataWargaState {

}
