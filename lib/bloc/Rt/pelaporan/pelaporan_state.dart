part of 'pelaporan_cubit.dart';

abstract class PelaporanState extends Equatable {
  const PelaporanState();
  @override
  List<Object> get props => [];
}

class PelaporanInitial extends PelaporanState {}
class PelaporanLoading extends PelaporanState {}
class PelaporanLoaded extends PelaporanState {}
class PelaporanFailure extends PelaporanState {
  final String message;

  PelaporanFailure(this.message);
}

class PelaporanCreating extends PelaporanState {}
class PelaporanCreated extends PelaporanState {}
class PelaporanUpdating extends PelaporanState {}
class PelaporanUpdated extends PelaporanState {}
class PelaporanUpdatingStatus extends PelaporanState {}
class PelaporanUpdatedStatus extends PelaporanState {}
class PelaporanError extends PelaporanState {
  final String message;

  PelaporanError(this.message);
}
