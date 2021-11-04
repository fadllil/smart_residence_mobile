import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'data_warga_state.dart';

@injectable
class DataWargaCubit extends Cubit<DataWargaState> {
  DataWargaCubit() : super(DataWargaInitial());
}
