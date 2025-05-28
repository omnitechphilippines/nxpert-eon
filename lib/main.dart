import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Add this
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:month_year_picker/month_year_picker.dart'; // Add this
import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('auth');
  runApp(const ProviderScope(child: NxpertEonApp()));
}

class NxpertEonApp extends StatelessWidget {
  const NxpertEonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'NXPERT EON',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(fontFamily: 'Roboto'),
      localizationsDelegates: const [ // Add these
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
      supportedLocales: const [ // Add this
        Locale('en', ''),
      ],
    );
  }
}