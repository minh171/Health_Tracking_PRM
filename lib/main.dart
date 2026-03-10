import 'package:flutter/material.dart';
import 'package:health_tracking/viewmodels/alert_setting_vm.dart';
import 'package:provider/provider.dart';

// Import Database & Interfaces
import 'data/database/database_helper.dart';
import 'implementation/repository/setting_repo_impl.dart';
import 'implementation/service/setting_service_impl.dart';
import 'interface/repository/isetting_repository.dart';
import 'interface/service/isetting_service.dart';

// --- AUTH ---
import 'implementation/repository/auth_repo_impl.dart';
import 'implementation/service/auth_service_impl.dart';
import 'viewmodels/register_vm.dart';
import 'viewmodels/login_vm.dart';

// --- HOME ---
import 'implementation/repository/home_repo_impl.dart';
import 'implementation/service/home_service_impl.dart';
import 'viewmodels/home_vm.dart';

// --- PROFILE ---
import 'implementation/repository/profile_repo_impl.dart';
import 'implementation/service/profile_service_impl.dart';
import 'viewmodels/profile_vm.dart';

// --- HEALTH RECORD ---
import 'implementation/repository/health_record_repo_impl.dart';
import 'implementation/service/health_record_service_impl.dart';
import 'viewmodels/heath_record_vm.dart';

// --- ALERT SETTING (Mới thêm) ---

// Import Views
import 'views/login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Database trước khi chạy App (tùy chọn nhưng khuyến khích)
  await DatabaseHelper.instance.database;

  runApp(
    MultiProvider(
      providers: [
        // ================= AUTH SECTION =================
        Provider<AuthRepository>(create: (_) => AuthRepository()),
        ProxyProvider<AuthRepository, AuthService>(
          update: (_, authRepo, __) => AuthService(authRepo),
        ),
        ChangeNotifierProvider(
          create: (context) => RegisterViewModel(context.read<AuthService>()),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginViewModel(context.read<AuthService>()),
        ),

        // ================= HOME SECTION =================
        Provider<HomeRepository>(create: (_) => HomeRepository()),
        ProxyProvider<HomeRepository, HomeService>(
          update: (_, homeRepo, __) => HomeService(homeRepo),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(context.read<HomeService>()),
        ),

        // ================= PROFILE SECTION =================
        Provider<ProfileRepository>(create: (_) => ProfileRepository()),
        ProxyProvider<ProfileRepository, ProfileService>(
          update: (_, profileRepo, __) => ProfileService(profileRepo),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileViewModel(context.read<ProfileService>()),
        ),

        // ================= HEALTH RECORD SECTION =================
        Provider<HealthRecordRepository>(create: (_) => HealthRecordRepository()),
        ProxyProvider2<HealthRecordRepository, ProfileRepository, HealthRecordService>(
          update: (_, recordRepo, profileRepo, __) =>
              HealthRecordService(recordRepo, profileRepo),
        ),
        ChangeNotifierProvider(
          create: (context) => HealthRecordViewModel(context.read<HealthRecordService>()),
        ),

        // ================= ALERT SETTING SECTION =================
        // 1. Đăng ký Repository
        Provider<ISettingRepository>(
          create: (_) => SettingRepository(),
        ),

        // 2. Đăng ký Service (Phụ thuộc vào ISettingRepository)
        ProxyProvider<ISettingRepository, ISettingService>(
          update: (_, repo, __) => SettingService(repo),
        ),

        // 3. Đăng ký ViewModel (Phụ thuộc vào ISettingService)
        ChangeNotifierProvider(
          create: (context) => AlertSettingViewModel(context.read<ISettingService>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Tracking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF4A90E2),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}