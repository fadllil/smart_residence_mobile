part of 'pelaporan_warga_cubit.dart';

abstract class PelaporanWargaState extends Equatable {
  const PelaporanWargaState();
  @override
  List<Object> get props => [];
}

class PelaporanWargaInitial extends PelaporanWargaState {}
class PelaporanWargaLoading extends PelaporanWargaState {}
class PelaporanWargaLoaded extends PelaporanWargaState {}
class PelaporanWargaFailure extends PelaporanWargaState {
  final String message;
  PelaporanWargaFailure(this.message);
}

class PelaporanWargaCreating extends PelaporanWargaState {}
class PelaporanWargaCreated extends PelaporanWargaState {}
class PelaporanWargaUpdating extends PelaporanWargaState {}
class PelaporanWargaUpdated extends PelaporanWargaState {}
class PelaporanWargaError extends PelaporanWargaState {
  final String message;
  PelaporanWargaError(this.message);
}
