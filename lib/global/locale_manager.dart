import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jijiwa_tool/database/cache.dart';

class LocaleManager {
  factory LocaleManager() => instance;

  LocaleManager._internal();

  static LocaleManager? _instance;

  static LocaleManager get instance => _instance ??= LocaleManager._internal();

  ValueNotifier<Locale?> localeNotifier = ValueNotifier(null);

  static Locale get currentLocale {
    var defLocale = Intl.defaultLocale ?? 'en';
    return LocaleManager.instance.localeNotifier.value ??
        Locale.fromSubtags(languageCode: defLocale);
  }

  static var locale = IsarUserDefault<Locale?>(
    'locale',
    null,
    builder: (str) {
      if (str == null || str == '') return null;
      var l = str.split('-');
      return Locale(l.first, l.last);
    },
    parser: (Locale? value) => value?.toLanguageTag(),
  );

  static const List<String> localeList = <String>[
    '',
    'en',
    'zh',
  ];

  void init() {
    localeNotifier.value = locale.value;
  }

  void switchLocale(String value) {
    if (!localeList.contains(value)) {
      return;
    }
    locale.setRawValue(value);
    localeNotifier.value = locale.value;
  }
}
