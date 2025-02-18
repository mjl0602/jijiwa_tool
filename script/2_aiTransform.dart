import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as Http;

import '0_gptKey.dart';

void main(List<String> args) async {
  for (FileSystemEntity file in Directory('./script/i18nAssets').listSync()) {
    if (file is! File) continue;
    if (file.path.endsWith('.r.txt')) continue;
    final text = file.readAsStringSync();
    print(file.path);
    final i18nResult = await loadI18n(text);
    print(i18nResult);
    final newFile = File(file.path.replaceAll('.dart.txt', '.r.txt'));
    newFile.writeAsStringSync(i18nResult);
  }
}

Future<String> loadI18n(String text) {
  final res = askAI("你是一个dart代码专家：\n$text\n" +
      r'''
把以上dart代码片段文本中的中文换成i18n的key（S.current.#key#），key使用小驼峰命名，并总结中文的i18n的json，英文的i18n的json，输出在代码块里。
你要输出：
1. 替换key后的原文（输出在代码块中），例如：
/main.dart:::58:::                S.current.pageCrashed
/model/deviceInfo.dart:::91:::      "${S.current.rawData}: ${bytes.hex}",
/model/deviceInfo.dart:::92:::      "${S.current.hardwareVersion}: $hardwareVersion",
2. 中文json
3. 英文json
''');
  return res;
}

Future<String> askAI(String text) async {
  Map<String, String> headers = new HashMap();
  headers['Authorization'] = 'Bearer $apiKey';
  headers['Content-type'] = 'application/json';
  Http.Response response = await Http.post(
    Uri.parse(gptUrl),
    headers: headers,
    body: jsonEncode({
      "chatId": null,
      "stream": false,
      "detail": false,
      "messages": [
        {"content": text, "role": "user"}
      ]
    }),
    encoding: Encoding.getByName('utf-8'),
  );
  return jsonDecode(response.body)['choices'][0]['message']['content']
      .toString();
}
