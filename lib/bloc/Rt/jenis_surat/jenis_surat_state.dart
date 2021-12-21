part of 'jenis_surat_cubit.dart';

abstract class JenisSuratState extends Equatable {
  const JenisSuratState();
  @override
  List<Object> get props => [];
}

class JenisSuratInitial extends JenisSuratState {}
class JenisSuratLoading extends JenisSuratState {}
class JenisSuratLoaded extends JenisSuratState {}
class JenisSuratFailure extends JenisSuratState {
  final String message;
  JenisSuratFailure(this.message);
}
class JenisSuratUpdating extends JenisSuratState {}
class JenisSuratUpdated extends JenisSuratState {}
class JenisSuratCreating extends JenisSuratState {}
class JenisSuratCreated extends JenisSuratState {}
class JenisSuratDeleting extends JenisSuratState {}
class JenisSuratDeleted extends JenisSuratState {}
class JenisSuratError extends JenisSuratState {
  final String message;
  JenisSuratError(this.message);
}
