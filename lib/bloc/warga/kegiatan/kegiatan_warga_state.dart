part of 'kegiatan_warga_cubit.dart';

abstract class KegiatanWargaState extends Equatable {
  const KegiatanWargaState();
  @override
  List<Object> get props => [];
}

class KegiatanWargaInitial extends KegiatanWargaState {}
class KegiatanWargaLoading extends KegiatanWargaState {}
class KegiatanWargaLoaded extends KegiatanWargaState {}
class KegiatanWargaFailure extends KegiatanWargaState {
  final String message;
  KegiatanWargaFailure(this.message);
}

class KegiatanWargaUpdating extends KegiatanWargaState {}
class KegiatanWargaUpdated extends KegiatanWargaState {}
class KegiatanWargaError extends KegiatanWargaState {
  final String message;
  KegiatanWargaError(this.message);
}