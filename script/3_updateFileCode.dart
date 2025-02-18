import 'dart:io';

void main(List<String> args) {
  for (var element in Directory('./script/i18nAssets/').listSync()) {
    if (element is! File) continue;
    File file = element;
    if (!file.path.endsWith('.r.txt')) continue;
    print(file.path);

    final content = file.readAsStringSync();
    // 更新代码
    updateFileLines(content);
  }
}

void updateFileLines(String inputText) async {
  // 将输入文本按行分割
  List<String> lines = inputText.split('\n');

  // 遍历每一行
  for (var line in lines) {
    // 使用正则表达式解析文件路径、行号和新的代码文本
    RegExp exp = RegExp(r'^(.*\.dart):::(\d+):::(.*)$');
    var matches = exp.firstMatch(line);

    if (matches != null) {
      String filePath = matches.group(1)!;
      int lineNumber = int.parse(matches.group(2)!);
      String newText = matches.group(3)!;

      // 读取文件内容
      File file = File('./lib/$filePath');
      List<String> fileLines = await file.readAsLines();

      // 检查行号是否有效
      if (lineNumber > 0 && lineNumber <= fileLines.length) {
        // 更新指定行的文本
        fileLines[lineNumber - 1] = newText;

        // 将更新后的内容写回文件
        await file.writeAsString(fileLines.join('\n'));
        print('文件 $filePath 的第 $lineNumber 行已更新。');
      } else {
        print('无效的行号: $lineNumber');
      }
    } else {
      // print('无法解析的行: $line');
    }
  }
}
