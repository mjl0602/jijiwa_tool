import 'dart:io';

void main() async {
  // 读取文件并获取每个键的行号
  final enLines = await loadFileLinesWithKeys('lib/l10n/intl_en.arb');
  final zhLines = await loadFileLinesWithKeys('lib/l10n/intl_zh.arb');

  // 比较并报告不在同一行的键
  compareLineNumbers(enLines, zhLines, 'EN', 'ZH');
  compareLineNumbers(zhLines, enLines, 'ZH', 'EN');
}

Future<Map<String, int>> loadFileLinesWithKeys(String path) async {
  final file = File(path);
  final lines = await file.readAsLines();
  Map<String, int> keysWithLineNumbers = {};

  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    if (line.startsWith('"') && line.contains('":')) {
      final key = line.split('":')[0].trim();
      keysWithLineNumbers[key] = i + 1; // +1 because line numbers are 1-based
    }
  }

  return keysWithLineNumbers;
}

void compareLineNumbers(Map<String, int> data1, Map<String, int> data2, String label1, String label2) {
  print('Comparing line numbers for $label1 and $label2...');
  for (var entry in data1.entries) {
    final key = entry.key;
    final lineNumber = entry.value;
    if (data2.containsKey(key) && data2[key] != lineNumber) {
      print('Key "$key" is in both but on different lines: $label1 line $lineNumber, $label2 line ${data2[key]}');
    }
  }
}