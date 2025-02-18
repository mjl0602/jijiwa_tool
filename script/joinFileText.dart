import 'dart:io';

void main() async {
  // 输出文件路径
  final outputFile = File('output.txt');
  // 确保输出文件存在
  await outputFile.create(recursive: true);
  // 初始化行数计数器
  int lineCount = 0;
  // 开始递归扫描并写入文件
  await scanDartFiles(Directory('./lib'), outputFile, lineCount);
}

Future<void> scanDartFiles(
    Directory directory, File outputFile, int lineCount) async {
  // 检查行数是否已经超过12000
  if (lineCount >= 12000) return;

  try {
    // 获取目录下的所有实体
    final entities = directory.listSync();
    for (var entity in entities) {
      // 如果是文件并且是Dart文件
      if (entity is File &&
          entity.path.endsWith('.dart') &&
          !entity.path.contains('.g.dart') &&
          !entity.path.contains('mock') &&
          !entity.path.contains('l10n')) {
        // 读取文件内容
        final content = await entity.readAsString();
        // 获取文件的行数
        final lines = content.split('\n').length;
        // 检查加上当前文件的行数后是否会超过12000行
        if (lineCount + lines > 12000) {
          // 如果会超过，只写入部分内容
          final linesToWrite = 12000 - lineCount;
          final partContent = content.split('\n').take(linesToWrite).join('\n');
          outputFile.writeAsStringSync('${entity.path}\n$partContent\n',
              mode: FileMode.append);
          return; // 达到12000行，结束递归
        } else {
          // 如果不会超过，写入整个文件内容
          outputFile.writeAsStringSync('${entity.path}\n$content\n',
              mode: FileMode.append);
          lineCount += lines; // 更新行数计数器
        }
      } else if (entity is Directory) {
        // 如果是目录，递归处理
        await scanDartFiles(entity, outputFile, lineCount);
      }
    }
  } catch (e) {
    print('Error reading directory: $e');
  }
}
