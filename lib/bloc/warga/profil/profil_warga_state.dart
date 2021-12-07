part of 'profil_warga_cubit.dart';

abstract class ProfilWargaState extends Equatable {
  const ProfilWargaState();
  @override
  List<Object> get props => [];
}

class ProfilWargaInitial extends ProfilWargaState {}
class ProfilWargaLoading extends ProfilWargaState {}
class ProfilWargaLoaded extends ProfilWargaState {}
class ProfilWargaFailure extends ProfilWargaState {
  final String message;
  ProfilWargaFailure(this.message);
}

class ProfilWargaUpdating extends ProfilWargaState {}
class ProfilWargaUpdated extends ProfilWargaState {}
class ProfilWargaError extends ProfilWargaState {
  final String message;
  ProfilWargaError(this.message);
}
