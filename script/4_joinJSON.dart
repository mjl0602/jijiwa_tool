import 'dart:io';

void main(List<String> args) {
  final targetEN = File('./script/i18nAssets/json/i18n_en.json');
  final targetZH = File('./script/i18nAssets/json/i18n_zh.json');

  targetEN.createSync(recursive: true);
  targetZH.createSync(recursive: true);

  final enJSON = [];
  final zhJSON = [];
  for (var element in Directory('./script/i18nAssets/').listSync()) {
    if (element is! File) continue;
    File file = element;
    if (!file.path.endsWith('.r.txt')) continue;
    print(file.path);

    final lines = file.readAsLinesSync();

    String locale = '';
    bool inJson = false;
    for (var line in lines) {
      if (line.trim() == '```json') {
        if (locale.isNotEmpty)
          locale = "en";
        else
          locale = 'zh';
      }
      if (line.trim() == '}') inJson = false;
      if (inJson) {
        if (!line.endsWith(',')) line += ',';
        if (locale == "en") {
          enJSON.add(line);
        }
        if (locale == "zh") {
          zhJSON.add(line);
        }
      }
      if (line.trim() == '{') inJson = true;
    }
  }

  targetEN.writeAsStringSync('{\n${enJSON.toSet().join('\n')}\n}');
  targetZH.writeAsStringSync('{\n${zhJSON.toSet().join('\n')}\n');
}
