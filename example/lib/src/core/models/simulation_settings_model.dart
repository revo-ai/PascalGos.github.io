import 'package:example/src/core/models/parameter_model.dart';
import 'package:example/src/core/utils/format_helper.dart';

//TODO: Add "" to incoming String for JSON EXPORT
class SimulationSettings {
  SimulationSettings({
    required this.cmConfig,
    required this.testParams,
    required this.optConfig,
  });

  CMConfig cmConfig;
  List<Parameter> testParams;
  OPTConfig optConfig;

  static SimulationSettings fromJson(Map<String, dynamic> json) {
    var list = json['"Test_params"'] as List;
    List<Parameter> paramList = list.map((i) => Parameter.fromJson(i)).toList();

    return SimulationSettings(
      cmConfig: json['"CM_config"'],
      testParams: paramList,
      optConfig: json['"opt_config"'],
    );
  }

  Map<String, dynamic> toJson() {
    List<Map> params = this.testParams.map((i) => i.toJson()).toList();

    return {
      '"CM_config"': cmConfig.toJson(),
      '"Test_params"': params,
      '"opt_config"': optConfig.toJson(),
    };
  }
}

class CMConfig {
  final String cmPath;
  final String cmProj;
  final String cmTestrun;
  final String tarQuantity;

  CMConfig({
    required this.cmPath,
    required this.cmProj,
    required this.cmTestrun,
    required this.tarQuantity,
  });

  static CMConfig fromJson(Map<String, dynamic> json) => CMConfig(
        cmPath: json['"CM_PATH"'],
        cmProj: json['"CM_PROJ"'],
        cmTestrun: json['"CM_TESTRUN"'],
        tarQuantity: json['"TAR_QUANTITY"'],
      );

  Map<String, dynamic> toJson() => {
        '"CM_PATH"': addQuatationMarkIfNeeded(cmPath),
        '"CM_PROJ"': addQuatationMarkIfNeeded(cmProj),
        '"CM_TESTRUN"': addQuatationMarkIfNeeded(cmTestrun),
        '"TAR_QUANTITY"': addQuatationMarkIfNeeded(tarQuantity),
      };
}

class OPTConfig {
  Algos algos;
  final int iterations;
  final int time;

  OPTConfig({
    required this.algos,
    required this.iterations,
    required this.time,
  });

  static OPTConfig fromJson(Map<String, dynamic> json) => OPTConfig(
        algos: json['"algos"'],
        iterations: json['"Iterations"'],
        time: json['"Time"'],
      );

  Map<String, dynamic> toJson() => {
        '"algos"': algos.toJson(),
        '"Iterations"': iterations,
        '"Time"': time,
      };
}

class Algos {
  bool deOptimizer;
  bool boRFLibVersion;
  bool randomOPT;
  bool boGpLibVersion;
  bool customBo;
  bool cmaEs;

  Algos({
    required this.deOptimizer,
    required this.boRFLibVersion,
    required this.randomOPT,
    required this.boGpLibVersion,
    required this.customBo,
    required this.cmaEs,
  });

  static Algos fromJson(Map<String, dynamic> json) => Algos(
        deOptimizer: json['"DEOptimizer"'],
        boRFLibVersion: json['"bo_rf_lib_version"'],
        randomOPT: json['"random_opt"'],
        boGpLibVersion: json['"bo_gp_lib_version"'],
        customBo: json['"custom_bo"'],
        cmaEs: json['"CMA-ES"'],
      );

  Map<String, dynamic> toJson() => {
        '"DEOptimizer"': deOptimizer,
        '"bo_rf_lib_version"': boRFLibVersion,
        '"random_opt"': randomOPT,
        '"bo_gp_lib_version"': boGpLibVersion,
        '"custom_bo"': customBo,
        '"CMA-ES"': cmaEs,
      };
}
