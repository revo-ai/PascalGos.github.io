import 'package:optimizer/src/core/utils/format_helper.dart';

class InputParameter {
  InputParameter({
    required this.key,
    required this.bounds,
    required this.cm_File,
  });

  String key;
  List<double> bounds;
  String cm_File;

  static InputParameter fromJson(Map<String, dynamic> json) => InputParameter(
        key: json['key'],
        bounds: json['bounds'].map<double>((bound) => bound as double).toList(),
        cm_File: json['CM_File'],
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
        key: json['key'],
        operation: Operation.fromJson(json['operation']),
      );

  Map<String, dynamic> toJson() => {
        '"key"': addQuatationMarkIfNeeded(key),
        '"operation"': operation.toJson(),
      };
}

class Operation {
  Operation({
    required this.key,
    this.bounds = const [0, 0],
  });

  String key;
  List<double> bounds;

  static Operation fromJson(Map<String, dynamic> json) => Operation(
        key: json['key'],
        bounds: json['bounds'].map<double>((bound) => bound as double).toList(),
      );

  Map<String, dynamic> toJson() => {
        '"key"': addQuatationMarkIfNeeded(key),
        '"bounds"': bounds,
      };
}
