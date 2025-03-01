import 'dart:ui';

import 'package:jijiwa_tool/database/cache.dart';

const kApiCacheChannel = 'api_cache';

class UserDefault {
  /// 判断第一次进入App
  static var notFirstOpen = IsarUserDefault<bool>('notFirstOpen', false);

  static var userToken = IsarUserDefault('userToken', '');

  static var homePageDeviceMac = IsarUserDefault('homePageDeviceMac', '');

  static var lastLoginTel = IsarUserDefault('lastLoginTel', '');

  static var bleCmdDelay = IsarUserDefault('bleCmdDelay', 120);

  static var blePackagePageSize = IsarUserDefault('blePackagePageSize', 20);

  /// 可调试
  static var canDebug = IsarUserDefault('canDebug', false);
  static var fconsoleShow = IsarUserDefault('fconsoleShow', false);
  static var debugHomePage = IsarUserDefault('debugHomePage', false);

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

  // 字体大小设置
  static var fontSize = IsarUserDefault<int?>('fontSize', null);
}
