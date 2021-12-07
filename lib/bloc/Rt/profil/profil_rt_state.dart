part of 'profil_rt_cubit.dart';

abstract class ProfilRtState extends Equatable {
  const ProfilRtState();
  @override
  List<Object> get props => [];
}

class ProfilRtInitial extends ProfilRtState {}
class ProfilRtLoading extends ProfilRtState {}
class ProfilRtLoaded extends ProfilRtState {}
class ProfilRtFailure extends ProfilRtState {
  final String? message;

  ProfilRtFailure(this.message);
}

class ProfilRtUpdating extends ProfilRtState {}
class ProfilRtUpdated extends ProfilRtState {}
class ProfilRtError extends ProfilRtState {
  final String? message;

  ProfilRtError(this.message);
}
