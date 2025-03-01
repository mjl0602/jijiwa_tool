import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:jijiwa_tool/global/data_base.dart';

part 'cache.g.dart';

class IsarUserDefault<T> extends ValueNotifier<T> {
  final String key;
  final T defaultValue;

  final T? Function(String? str)? builder;
  final String? Function(T? value)? parser;

  IsarUserDefault(
    this.key,
    this.defaultValue, {
    this.builder,
    this.parser,
  }) : super(defaultValue);

  @override
  T get value =>
      IsarCacheItem.getWithKeySync<T>(
        key,
        builder: builder,
      ) ??
      defaultValue;

  @override
  set value(T? value) {
    IsarCacheItem.setWithKeySync<T?>(
      key,
      value,
      parser: parser,
    );
    super.value = this.value;
  }

  setRawValue(String value) {
    IsarCacheItem.setWithKeySync<T?>(
      key,
      null,
      parser: (_) => value,
    );
    super.value = this.value;
  }
}

// 运行 dart run build_runner build
@collection
class IsarCacheItem {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String key;

  String valueJson;

  IsarCacheItem({
    required this.key,
    required this.valueJson,
  });

  static void setWithKeySync<T>(
    String k,
    T? v, {
    String? Function(T value)? parser,
  }) {
    isar.writeTxnSync(() {
      if (v != null) {
        String? result = jsonEncode({'_v': v});
        if (parser != null) {
          result = parser(v);
        }
        if (result != null) {
          isar.isarCacheItems.putSync(
            IsarCacheItem(
              key: k,
              valueJson: result,
            ),
          );
          return;
        }
      }
      // 清理数据
      isar.isarCacheItems.filter().keyEqualTo(k).deleteAll();
    });
  }

  static T? getWithKeySync<T>(
    String k, {
    T? Function(String?)? builder,
  }) {
    IsarCacheItem? item;
    isar.writeTxnSync(() {
      item = isar.isarCacheItems.filter().keyEqualTo(k).findFirstSync();
    });
    if (builder != null) {
      return builder.call(item?.valueJson ?? "");
    }
    if (item == null) return null;
    if (item!.valueJson.isEmpty) return null;
    return jsonDecode(item?.valueJson ?? '{}')['_v'] as T;
  }
}
