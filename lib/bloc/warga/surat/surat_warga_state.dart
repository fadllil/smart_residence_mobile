part of 'surat_warga_cubit.dart';

abstract class SuratWargaState extends Equatable {
  const SuratWargaState();
  @override
  List<Object> get props => [];
}

class SuratWargaInitial extends SuratWargaState {}
class SuratWargaLoading extends SuratWargaState {}
class SuratWargaLoaded extends SuratWargaState {}
class SuratWargaFailure extends SuratWargaState {
  final String message;
  SuratWargaFailure(this.message);
}
class SuratWargaCreating extends SuratWargaState {}
class SuratWargaCreated extends SuratWargaState {}
class SuratWargaUpdating extends SuratWargaState {}
class SuratWargaUpdated extends SuratWargaState {}
class SuratWargaError extends SuratWargaState {
  final String message;
  SuratWargaError(this.message);
}
