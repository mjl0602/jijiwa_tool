import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:local_cache_sync/local_cache_sync.dart';

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

  static var cacheLocale = DefaultValueCache<String>('cacheLocale', '');

  static const List<String> localeList = <String>[
    '',
    'en',
    'zh',
  ];

  static Locale? stringToLocale(String value) {
    final List<String> locale = value.split('_');
    if (locale.isNotEmpty && locale.first.isNotEmpty) {
      return Locale(locale.first, locale.last);
    }

    return null;
  }

  void init() {
    localeNotifier.value = stringToLocale(cacheLocale.value);
  }

  void switchLocale(String value) {
    if (!localeList.contains(value)) {
      return;
    }

    localeNotifier.value = stringToLocale(value);

    cacheLocale.value = value;
  }
}
