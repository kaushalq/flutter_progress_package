import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:smooth_progress_bar_indicator/progress_indicator_smooth_transition.dart';

void main() {
  testWidgets('ProgressBarIndicator displays initial progress', (WidgetTester tester) async {
    // Define the end time
    final endTime = 5.obs;

    // Build the ProgressBarIndicator widget
    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(
          body: ProgressBarIndicator(
            endTime: endTime,
          ),
        ),
      ),
    );

    // Verify that the progress indicator is displayed
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });

  testWidgets('ProgressBarIndicator completes progress', (WidgetTester tester) async {
    // Define the end time
    final endTime = 1.obs;
    bool isCompleted = false;

    // Build the ProgressBarIndicator widget with onProgressComplete callback
    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(
          body: ProgressBarIndicator(
            endTime: endTime,
            onProgressComplete: () {
              isCompleted = true;
            },
          ),
        ),
      ),
    );

    // Wait for the duration of the animation
    await tester.pumpAndSettle(Duration(seconds: endTime.value));

    // Verify that the onProgressComplete callback was called
    expect(isCompleted, isTrue);
  });

  test('ProgressBarIndicatorController reBuildWidget method', () {
    // Define the end time
    final endTime = 5.obs;
    final controller = ProgressBarIndicatorController(endTime: endTime);

    // Initial animationKey value
    final initialKey = controller.animationKey.value;

    // Call the reBuildWidget method
    controller.reBuildWidget();

    // Verify that the animationKey value has incremented
    expect(controller.animationKey.value, initialKey + 1);
  });

  test('ProgressBarIndicatorController onProgressComplete method', () {
    // Define the end time
    final endTime = 5.obs;
    final controller = ProgressBarIndicatorController(endTime: endTime);

    // Verify that calling onProgressComplete does not throw an exception
    expect(controller.onProgressComplete, returnsNormally);
  });
}
