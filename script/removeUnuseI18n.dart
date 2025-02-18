import 'dart:convert';
import 'dart:io';

void main() async {
  final usedKeys = await scanDartFilesForKeys('lib');
  final arbFiles = Directory('lib/l10n')
      .listSync()
      .where((file) => file.path.endsWith('.arb'));

  for (var file in arbFiles) {
    final content = await File(file.path).readAsString();
    final Map<String, dynamic> jsonContent = json.decode(content);

    final keysToRemove = <String>[];
    for (var key in jsonContent.keys) {
      if (!usedKeys.contains(key) && key != '@@locale') {
        keysToRemove.add(key);
      }
    }

    keysToRemove.forEach(jsonContent.remove);
    await File(file.path).writeAsString(prettyPrint(jsonContent));
  }
}

Future<Set<String>> scanDartFilesForKeys(String directoryPath) async {
  final RegExp keyRegExp = RegExp(r'S\.(current|of\(context\))\.(\w+)');
  final Set<String> keys = {};

  await for (final file in Directory(directoryPath).list(recursive: true)) {
    if (file.path.endsWith('.dart')) {
      final content = await File(file.path).readAsString();
      final matches = keyRegExp.allMatches(content);
      for (final match in matches) {
        keys.add(match.group(2)!);
      }
    }
  }

  return keys;
}

String prettyPrint(dynamic object) {
  var encoder = const JsonEncoder.withIndent('  ');
  return encoder.convert(object);
}
