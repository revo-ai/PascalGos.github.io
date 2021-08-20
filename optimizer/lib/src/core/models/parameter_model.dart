import 'package:optimizer/src/core/utils/format_helper.dart';

class InputParameter {
  InputParameter({
    required this.key,
    required this.bounds,
    required this.cm_File,
  });

  String key;
  var bounds;
  String cm_File;

  static InputParameter fromJson(Map<String, dynamic> json) => InputParameter(
        key: json['"key"'],
        bounds: json['"bounds"'],
        cm_File: json['"CM_File"'],
      );

  Map<String, dynamic> toJson() => {
        '"key"': addQuatationMarkIfNeeded(key),
        '"bounds"': bounds,
        '"CM_File"': addQuatationMarkIfNeeded(cm_File),
      };
}

class TargetParameter {
  TargetParameter({
    required this.key,
    required this.operation,
  });

  String key;
  Operation operation;

  static TargetParameter fromJson(Map<String, dynamic> json) => TargetParameter(
        key: json['"key"'],
        operation: json['"operation"'],
      );

  Map<String, dynamic> toJson() => {
        '"key"': addQuatationMarkIfNeeded(key),
        '"operation"': operation.toJson(),
      };
}

class Operation {
  Operation({
    required this.key,
    this.bounds,
  });

  String key;
  var bounds;

  static Operation fromJson(Map<String, dynamic> json) => Operation(
        key: json['"key"'],
        bounds: json['"bounds"'],
      );

  Map<String, dynamic> toJson() => {
        '"key"': addQuatationMarkIfNeeded(key),
        '"bounds"': bounds,
      };
}
