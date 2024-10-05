import 'package:get/get.dart';

import '../helpers/size_helper.dart';

extension NumSizeExtension on num {
  static SizeManager get sizeManager => Get.find<SizeManager>();

  double get h => sizeManager.height(toDouble());
  double get w => sizeManager.width(toDouble());
  double get sp => sizeManager.fontSize(toDouble());
  double get r => sizeManager.radius(toDouble());
}
