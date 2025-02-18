import 'dart:io';

void main(List<String> args) {
  var file = File(Platform.environment['PWD']! + '/pubspec.yaml');
  print(file.path);
  var content = file.readAsStringSync();
  var reg = RegExp(r'(?<=version:\s)(.+?)(?=' '\n' ')');
  var version = reg.stringMatch(content);
  if (version == null) {
    throw '没找到版本';
  }
  var versions = version.split(RegExp('[.+]'));
  if (versions.length != 4) {
    throw '版本号不合规范: a.b.c+x';
  }
  var newVersion = [
    int.parse(versions[0]), ".", //
    int.parse(versions[1]), ".", //
    int.parse(versions[2]) + 1, "+", //
    int.parse(versions[3]) + 1,
  ].join();
  var newContent = content.replaceFirst(
    RegExp(r'(?<=version:\s)(.+?)(?=' '\n' ')'),
    newVersion,
  );
  file.writeAsStringSync(newContent);
  print('''
+++++版本号+1成功
+++++新版本号：$newVersion
''');
}
