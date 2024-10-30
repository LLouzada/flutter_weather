import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A widget that shows a loader
Center showLoader({Color? color}) => Center(
    child: CircularProgressIndicator(
        color: color ?? Theme.of(Get.context!).colorScheme.onSurface));
