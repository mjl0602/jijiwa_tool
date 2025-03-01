import 'dart:async';

import 'package:fconsole/fconsole.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jijiwa_tool/global/data_base.dart';
import 'package:jijiwa_tool/global/locale_manager.dart';
import 'package:jijiwa_tool/global/user_default.dart';
import 'package:jijiwa_tool/l10n/generated/l10n.dart';
import 'package:jijiwa_tool/pages/home_page.dart';
import 'package:jijiwa_tool/style/color.dart';
import 'package:jijiwa_tool/style/theme.dart';
import 'package:oktoast/oktoast.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

typedef ErrHandler = void Function(
    Zone, ZoneDelegate, Zone, Object, StackTrace);

void main() async {
  runAppWithFConsole(
    OKToast(
      radius: 4,
      backgroundColor: ColorPalette.black.withOpacity(0.6),
      dismissOtherOnShow: true,
      child: MyApp(),
    ),
    beforeRun: () async {
      WidgetsFlutterBinding.ensureInitialized();
      await DataBase.init();
      LocaleManager.instance.init();

      if (kReleaseMode) {
        /// 自定义报错页面
        ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
          debugPrint(flutterErrorDetails.toString());
          return Material(
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 20,
                ),
                child: Text(
                  "Error...",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        };
      } else {
        WakelockPlus.enable();
      }
    },
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      UserDefault.canDebug.value = true;
      UserDefault.fconsoleShow.value = true;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (UserDefault.fconsoleShow.value == true || kDebugMode) {
        showConsole();
      } else {
        hideConsole();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale?>(
      valueListenable: LocaleManager.instance.localeNotifier,
      builder: (_, Locale? locale, __) {
        return MaterialApp(
          title: 'JiJiWa',
          theme: MyTheme.standard(),
          home: HomePage(),
          locale: locale,
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
        );
      },
    );
  }
}
