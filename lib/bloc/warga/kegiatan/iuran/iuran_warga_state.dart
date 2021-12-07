part of 'iuran_warga_cubit.dart';

abstract class IuranWargaState extends Equatable {
  const IuranWargaState();
  @override
  List<Object> get props => [];
}

class IuranWargaInitial extends IuranWargaState {}
class IuranWargaLoading extends IuranWargaState {}
class IuranWargaLoaded extends IuranWargaState {}
class IuranWargaFailure extends IuranWargaState {
  final String message;
  IuranWargaFailure(this.message);
}
class IuranWargaUpdating extends IuranWargaState {}
class IuranWargaUpdated extends IuranWargaState {}
class IuranWargaError extends IuranWargaState {
  final String message;
  IuranWargaError(this.message);
}
