import 'package:flutter/material.dart';
import 'package:flutter_admin_perwalian_if/screen/view/onboarding/onboarding.dart';
import 'package:flutter_admin_perwalian_if/screen/view_model/view_model_add_dosen.dart';
import 'package:flutter_admin_perwalian_if/screen/view_model/view_model_edit_dosen.dart';
import 'package:flutter_admin_perwalian_if/screen/view_model/view_model_home.dart';
import 'package:flutter_admin_perwalian_if/screen/view_model/view_model_onboarding.dart';
import 'package:flutter_admin_perwalian_if/screen/view_model/view_model_update_data_mahasiswa.dart';
import 'package:provider/provider.dart';

import 'screen/view_model/view_model_dosen.dart';
import 'screen/view_model/view_model_login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ViewModelLogin(),
        ),
        ChangeNotifierProvider(
          create: (_) => ViewModelOnBoarding(),
        ),
        ChangeNotifierProvider(
          create: (_) => ViewModelHome(),
        ),
        ChangeNotifierProvider(
          create: (_) => ViewModelAddDosen(),
        ),
        ChangeNotifierProvider(
          create: (_) => ViewModelDosen(),
        ),
        ChangeNotifierProvider(
          create: (_) => ViewModelUpdateDataMahasiswa(),
        ),
        ChangeNotifierProvider(
          create: (_) => ViewModelEditDosen(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: false,
          brightness: Brightness.light,
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xff0067AC),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const Onboarding(),
      ),
    );
  }
}
