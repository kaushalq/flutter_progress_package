
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A widget that displays a linear progress bar which animates over a specified duration.
class ProgressBarIndicator extends GetView<ProgressBarIndicatorController> {
  final Alignment? alignment;
  //width of the horizontal bar
  final double? width;
  final double? height;
  final int? startTime;
  final RxInt endTime;
  final Color? color;
  final VoidCallback? onProgressComplete;

  /// Creates a [ProgressBarIndicator].
  ///
  /// The [endTime] parameter must not be null.
  const ProgressBarIndicator({
    Key? key,
    this.alignment = Alignment.topCenter,
    this.width,
    this.height,
    this.color,
    this.startTime = 0,
    required this.endTime,
    this.onProgressComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProgressBarIndicatorController>(
      init: ProgressBarIndicatorController(endTime: endTime),
      builder: (controller) {
        return Obx(() {
          return Container(
            alignment: alignment,
            width: width,
            height: height,
            child: TweenAnimationBuilder<double>(
              key: ValueKey(controller.animationKey.value), // Add key to reset animation
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(seconds: endTime.value),
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  value: value,
                  color: color,
                );
              },
              onEnd: () {
                if (onProgressComplete == null) {
                  controller.onProgressComplete();
                } else {
                  onProgressComplete!();
                }
              },
            ),
          );
        });
      },
    );
  }
}

/// Controller for [ProgressBarIndicator].
class ProgressBarIndicatorController extends GetxController {
  final RxInt endTime;
  RxInt animationKey = 0.obs;

  /// Creates a [ProgressBarIndicatorController].
  ///
  /// The [endTime] parameter must not be null.
  ProgressBarIndicatorController({required this.endTime});

  @override
  void onInit() {
    super.onInit();
  }

  /// Resets the value of the tween animation, causing the widget to rebuild.
  void reBuildWidget() {
    animationKey.value++;
  }

  /// Default method called after the progress animation completes, if no custom method is provided.
  void onProgressComplete() {}

  @override
  void onClose() {
    super.onClose();
  }
}
