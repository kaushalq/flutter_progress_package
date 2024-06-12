import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_progress_bar_indicator/progress_indicator_smooth_transition.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: ProgressBarExample(),
    );
  }
}

class ProgressBarExample extends StatefulWidget {
  const ProgressBarExample({key});

  @override
  _ProgressBarExampleState createState() => _ProgressBarExampleState();
}

class _ProgressBarExampleState extends State<ProgressBarExample> {
  // Define the end time as a reactive value
  final RxInt endTime = 10.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Bar Indicator Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ProgressBarIndicator(
              width: 300,
              height: 10,
              color: Colors.blue,
              endTime: endTime,
              onProgressComplete: () {
                // Show a snackbar when the progress is complete
                Get.snackbar(
                  'Progress Complete',
                  'The progress bar has completed.',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Restart the progress bar
                setState(() {
                  endTime.value = 10;
                  Get.find<ProgressBarIndicatorController>().reBuildWidget();
                });
              },
              child: Text('Restart Progress'),
            ),
          ],
        ),
      ),
    );
  }
}
