part of 'dashboard_rt_cubit.dart';

abstract class DashboardRtState extends Equatable {
  const DashboardRtState();
  @override
  List<Object> get props => [];
}

class DashboardRtInitial extends DashboardRtState {}
class DashboardRtLoading extends DashboardRtState {}
class DashboardRtLoaded extends DashboardRtState {
  final String? nama;
  DashboardRtLoaded(
      {this.nama});
}
class DashboardRtFailure extends DashboardRtState {
  final String? message;

  DashboardRtFailure(this.message);
}
class TempState extends DashboardRtState{}
