// ignore_for_file: use_key_in_widget_constructors
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventary_go/utils/utils.dart';

import 'splash_controller.dart';

class SplashPage extends GetWidget<SplashController> {
  @override
  Widget build(BuildContext context) {
    return log2();
  }

  log2() {
    return Container(
      color: colorPrincipal,
      width: Get.width * 1,
      height: Get.height * 1,
      child: Stack(
        children: [
          //
          FadeIn(
            delay: const Duration(milliseconds: 1000),
            child: Align(
              child: SizedBox(
                width: Get.width * 0.85,
                child: Image.asset(
                  'lib/assets/logoinventarygo.png',
                  cacheWidth: 500,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: Get.height * 0.035,
            right: Get.width * 0.1,
            left: Get.width * 0.1,
            child: FadeInUpBig(
              delay: const Duration(milliseconds: 1000),
              child: Align(
                child: SizedBox(
                  width: Get.width * 0.45,
                  child: Image.asset(
                    'lib/assets/powerBy.png',
                    cacheWidth: 500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
