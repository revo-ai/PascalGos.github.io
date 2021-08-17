//TODO: Add "" to incoming String for JSON EXPORT
import 'package:optimizer/src/core/utils/format_helper.dart';

class Parameter {
  Parameter({
    required this.key,
    required this.bounds,
    required this.cm_File,
    required this.val_index,
  });

  String key;
  var bounds;
  String cm_File;
  int val_index;

  //TODO: Convert nested JSON Array into Dart Array

  static Parameter fromJson(Map<String, dynamic> json) => Parameter(
        key: json['"key"'],
        bounds: json['"bounds"'],
        cm_File: json['"CM_File"'],
        val_index: json['"val_index"'],
      );

  Map<String, dynamic> toJson() => {
        '"key"': addQuatationMarkIfNeeded(key),
        '"bounds"': bounds,
        '"CM_File"': addQuatationMarkIfNeeded(cm_File),
        '"val_index"': val_index,
      };
}
