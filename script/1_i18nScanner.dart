// 导入dart:io库，用于文件操作

import 'dart:io';

/// 模板路径
Uri libPath = Platform.script.resolve('../lib/');

// 定义一个函数，接受一个文件夹路径作为参数，返回一个结果数组
void findChineseStrings(String folderPath) {
  // 创建一个空数组，用于存储结果
  List<String> result = [];
  // 创建一个文件夹对象
  Directory folder = Directory(folderPath);
  // 判断文件夹是否存在
  if (folder.existsSync()) {
    // 获取文件夹下所有的文件和子文件夹
    List<FileSystemEntity> files = folder.listSync();
    // 遍历每一个文件或子文件夹
    for (var file in files) {
      if (file.path.contains('l10n')) continue;
      // 如果是文件，并且扩展名是.dart
      if (file is File && file.path.endsWith('.dart')) {
        // 读取文件的所有行
        List<String> lines = file.readAsLinesSync();
        bool hasMatch = false;
        // 遍历每一行
        for (int i = 0; i < lines.length; i++) {
          // 获取当前行
          String line = lines[i];
          // 定义一个正则表达式，匹配中文字符串，单引号或双引号
          RegExp regex = RegExp("['\"].+['\"]");
          // 如果当前行包含中文字符串
          if (regex.hasMatch(line)) {
            if (line.contains('FlowLog')) continue;
            if (line.contains('print(')) continue;
            if (line.contains('logger.add(')) continue;
            if (line.contains('.log(')) continue;
            if (line.contains('.error(')) continue;
            if (line.contains('.end(')) continue;
            if (line.contains('import ')) continue;
            if (line.startsWith('//')) continue;
            if (line.startsWith(RegExp(r'\s+//'))) continue;
            if (!checkZh(line)) continue;
            // 将文件路径，行数，和当前行拼接成一个字符串，添加到结果数组中
            result.add(
                '${file.path.replaceAll(libPath.path, '/')}:::${i + 1}:::$line');
            hasMatch = true;
          }
        }
        // if (hasMatch) result.add('');
        if (hasMatch) {
          String fileName =
              '${file.path.replaceAll(libPath.path, '_')}'.replaceAll('/', '_');
          final saveFile = File(libPath
              .resolve('../script/i18nAssets/_${result.length}$fileName.txt')
              .path);
          saveFile.createSync(recursive: true);
          saveFile.writeAsStringSync(result.join('\n'));
          result.clear();
        }
      }
      // 如果是子文件夹，递归调用函数
      else if (file is Directory) {
        findChineseStrings(file.path);
      }
    }
  } else {
    // 如果文件夹不存在，打印错误信息
    print('Folder does not exist: $folderPath');
  }
}

bool checkZh(String s) {
  // 使用正则表达式匹配双引号之间的内容
  RegExp reg = RegExp("['\"]([^\"]*)[\"']");
  // 遍历所有匹配结果
  for (var match in reg.allMatches(s)) {
    // 取出双引号之间的字
    String word = match.group(1) ?? "";
    // 判断是否有中文，使用Unicode范围
    return word.contains(RegExp(r'[\u4e00-\u9fa5]'));
  }
  return false;
}

void main(List<String> args) {
  findChineseStrings(libPath.path);
}
