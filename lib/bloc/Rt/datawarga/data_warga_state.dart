part of 'data_warga_cubit.dart';

abstract class DataWargaState extends Equatable {
  const DataWargaState();

  @override
  List<Object> get props => [];
}

class DataWargaInitial extends DataWargaState {}
class DataWargaLoading extends DataWargaState {}
class DataWargaLoaded extends DataWargaState {}
class DataWargaFailure extends DataWargaState {
  final String? message;

  DataWargaFailure(this.message);
}

class DataWargaCreating extends DataWargaState {}
class DataWargaCreated extends DataWargaState {}
class DataWargaUpdating extends DataWargaState {}
class DataWargaUpdated extends DataWargaState {}
class DataWargaError extends DataWargaState {
  final String? message;

  DataWargaError(this.message);
}