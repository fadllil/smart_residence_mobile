import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_residence/service/kegiatan_service.dart';

part 'kegiatan_warga_state.dart';

@injectable
class KegiatanWargaCubit extends Cubit<KegiatanWargaState> {
  final KegiatanService kegiatanService;
  KegiatanWargaCubit(this.kegiatanService) : super(KegiatanWargaInitial());

}
