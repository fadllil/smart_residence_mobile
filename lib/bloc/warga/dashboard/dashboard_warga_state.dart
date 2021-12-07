part of 'dashboard_warga_cubit.dart';

abstract class DashboardWargaState extends Equatable {
  const DashboardWargaState();
  @override
  List<Object> get props => [];
}

class DashboardWargaInitial extends DashboardWargaState {}
class DashboardWargaLoading extends DashboardWargaState {}
class DashboardWargaLoaded extends DashboardWargaState {
  final String? nama;
  DashboardWargaLoaded({this.nama});
}
class DashboardWargaFailure extends DashboardWargaState {
  final String message;
  DashboardWargaFailure(this.message);
}
class TempState extends DashboardWargaState{}
