part of 'kegiatan_peserta_cubit.dart';

abstract class KegiatanPesertaState extends Equatable {
  const KegiatanPesertaState();
  @override
  List<Object> get props => [];
}

class KegiatanPesertaInitial extends KegiatanPesertaState {}
class KegiatanPesertaLoading extends KegiatanPesertaState {}
class KegiatanPesertaLoaded extends KegiatanPesertaState {}
class KegiatanPesertaFailure extends KegiatanPesertaState {
  final String message;
  KegiatanPesertaFailure(this.message);
}

class KegiatanPesertaCreating extends KegiatanPesertaState {}
class KegiatanPesertaCreated extends KegiatanPesertaState {}
class KegiatanPesertaError extends KegiatanPesertaState {
  final String message;
  KegiatanPesertaError(this.message);
}
