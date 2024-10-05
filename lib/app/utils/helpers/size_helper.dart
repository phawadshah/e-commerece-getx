// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

DeviceType? _deviceType;
DeviceType? get deviceType => _deviceType;

class SizeManager extends GetxService {
  static Orientation? _orientation;
  static double? _width;
  static double? _height;

  @override
  void onInit() {
    init(MediaQuery.of(Get.context!).size,
        MediaQuery.of(Get.context!).orientation);
    super.onInit();
  }

  void init(Size size, Orientation orientation) {
    _orientation = orientation;
    if (orientation == Orientation.portrait) {
      _width = size.width;
      _height = size.height;
    } else {
      _width = size.height;
      _height = size.width;
    }

    _deviceType =
        _width != null ? _getDeviceType(_width!) : DeviceType.appMobile;
  }

  static get orientation => _orientation;

  DeviceType _getDeviceType(double width) {
    if (width <= 380) {
      return DeviceType.sMobile;
    } else if (width <= 480) {
      return DeviceType.appMobile;
    } else if (width <= 600) {
      return DeviceType.sMTablet;
    } else if (width <= 810) {
      return DeviceType.appTablet;
    } else {
      return DeviceType.lgTablet;
    }
  }

  double height(double value) {
    switch (deviceType) {
      case DeviceType.sMobile:
        return (value * 1.16).h;

      default:
        return value.h;
    }
  }

  double width(double value) {
    switch (deviceType) {
      case DeviceType.sMobile:
        return (value * .9).w;
      case DeviceType.sMTablet:
        return (value * 1.3);
      case DeviceType.appTablet:
        return value * 1.55;
      case DeviceType.lgTablet:
        return value * 1.6;
      default:
        return value.w;
    }
  }

  double fontSize(double baseSize) {
    switch (deviceType) {
      case DeviceType.sMobile:
        return (baseSize * 0.8).sp;
      case DeviceType.sMTablet:
        return (baseSize * .7).sp;
      case DeviceType.appTablet:
        return (baseSize * .65).sp;
      case DeviceType.lgTablet:
        return (baseSize * .58).sp;
      default:
        return baseSize.sp;
    }
  }

  double radius(double baseSize) {
    switch (deviceType) {
      case DeviceType.sMobile:
        return (baseSize * 0.7).sp;
      case DeviceType.sMTablet:
        return (baseSize * .6).sp;
      case DeviceType.appTablet:
        return (baseSize * .55).sp;
      case DeviceType.lgTablet:
        return (baseSize * .5).sp;
      default:
        return baseSize.sp;
    }
  }

  double iconSize({
    required double lgTab,
    required double appTab,
    required double sMTab,
    required double appMobVal,
    required double sMobVal,
  }) {
    switch (deviceType) {
      case DeviceType.lgTablet:
        return lgTab;
      case DeviceType.appTablet:
        return appTab;
      case DeviceType.sMTablet:
        return sMTab;
      case DeviceType.appMobile:
        return appMobVal;
      case DeviceType.sMobile:
        return sMobVal;
      default:
        return appMobVal;
    }
  }
}

enum DeviceType {
  sMobile,
  appMobile,
  sMTablet,
  appTablet,
  lgTablet,
}
