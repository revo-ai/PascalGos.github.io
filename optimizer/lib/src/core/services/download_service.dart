import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;

class DownloadService {
  static Future saveStringAsJson(String data) async {
    var anchor;
    Uint8List stringInBytes = Uint8List.fromList(utf8.encode(data));
    final blob = html.Blob([stringInBytes], 'application/json');
    final url = html.Url.createObjectUrlFromBlob(blob);
    anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = "config.json";
    html.document.body!.children.add(anchor);
    anchor.click();
  }
}
