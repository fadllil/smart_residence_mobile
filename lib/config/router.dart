import 'package:auto_route/auto_route.dart';
import 'package:smart_residence/view/components/option_with_search.dart';
import 'package:smart_residence/view/login.dart';
import 'package:smart_residence/view/rt/home_rt.dart';
import 'package:smart_residence/view/rt/informasi/informasi.dart';
import 'package:smart_residence/view/rt/jenis_surat/jenis_surat.dart';
import 'package:smart_residence/view/rt/kegiatan/detail/anggota.dart';
import 'package:smart_residence/view/rt/kegiatan/detail/iuran.dart';
import 'package:smart_residence/view/rt/kegiatan/kegiatan.dart';
import 'package:smart_residence/view/rt/kegiatan/tambah_kegiatan.dart';
import 'package:smart_residence/view/rt/keuangan/keuangan.dart';
import 'package:smart_residence/view/rt/pelaporan/pelaporan.dart';
import 'package:smart_residence/view/rt/surat/surat.dart';
import 'package:smart_residence/view/rt/warga/detail_warga.dart';
import 'package:smart_residence/view/rt/warga/warga.dart';
import 'package:smart_residence/view/splash_screen.dart';
import 'package:smart_residence/view/warga/kegiatan/detail/iuran_warga.dart';
import 'package:smart_residence/view/warga/kegiatan/detail/kegiatan_peserta.dart';
import 'package:smart_residence/view/warga/kegiatan/kegiatan_warga.dart';
import 'package:smart_residence/view/warga/pelaporan/pelaporan_warga.dart';
import 'package:smart_residence/view/warga/surat/surat_warga.dart';
import 'package:smart_residence/view/welcome-screen/WelcomeScreen.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: SplashScreen, initial: true,path: '/'),
    AutoRoute(page: WelcomeScreen, path: '/welcome-screen'),
    AutoRoute(page: HomeRt, path: '/home-rt'),
    AutoRoute(page: Login, path: '/login'),
    AutoRoute(page: Warga, path: '/warga'),
    AutoRoute(page: DetailWarga, path: '/detail_warga'),
    AutoRoute(page: Kegiatan, path: '/kegiatan'),
    AutoRoute(page: KegiatanPeserta, path: '/kegiatan_peserta'),
    AutoRoute(page: Anggota, path: '/anggota'),
    AutoRoute(page: Iuran, path: '/iuran'),
    AutoRoute(page: IuranWarga, path: '/iuran_warga'),
    AutoRoute(page: Informasi, path: '/informasi'),
    AutoRoute(page: Pelaporan, path: '/pelaporan'),
    AutoRoute(page: PelaporanWarga, path: '/pelaporan_warga'),
    AutoRoute(page: Surat, path: '/surat'),
    AutoRoute(page: Keuangan, path: '/keuangan'),
    AutoRoute(page: TambahKegiatan, path: '/tambah_kegiatan'),
    AutoRoute(page: CustomOptionWithSearch,path: '/custom-option'),
    AutoRoute(page: SuratWarga,path: '/surat_warga'),
    AutoRoute(page: JenisSurat,path: '/jenis_surat'),
  ],
)
class $AppRouter {}