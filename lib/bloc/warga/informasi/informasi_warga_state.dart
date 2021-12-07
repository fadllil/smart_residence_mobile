part of 'informasi_warga_cubit.dart';

abstract class InformasiWargaState extends Equatable {
  const InformasiWargaState();
  @override
  List<Object> get props => [];
}

class InformasiWargaInitial extends InformasiWargaState {}
class InformasiWargaLoading extends InformasiWargaState {}
class InformasiWargaLoaded extends InformasiWargaState {}
class InformasiWargaFailure extends InformasiWargaState {
  final String message;
  InformasiWargaFailure(this.message);
}
