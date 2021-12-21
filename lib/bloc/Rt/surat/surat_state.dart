part of 'surat_cubit.dart';

abstract class SuratState extends Equatable {
  const SuratState();
  @override
  List<Object> get props => [];
}

class SuratInitial extends SuratState {}
class SuratLoading extends SuratState {}
class SuratLoaded extends SuratState {}
class SuratFailure extends SuratState {
  final String message;
  SuratFailure(this.message);
}
class SuratUpdating extends SuratState {}
class SuratUpdated extends SuratState {}
class SuratError extends SuratState {
  final String message;
  SuratError(this.message);
}
