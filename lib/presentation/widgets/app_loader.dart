import 'package:flutter/material.dart';
import 'package:get/get.dart';

Center showLoader({Color? color}) => Center(
    child: CircularProgressIndicator(
        color: color ?? Theme.of(Get.context!).colorScheme.onSurface));
