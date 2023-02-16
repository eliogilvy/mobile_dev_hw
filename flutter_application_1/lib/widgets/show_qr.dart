import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../classes/Task.dart';

class ShowQR extends StatelessWidget {
  const ShowQR({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(280.0),
      painter: QrPainter(
          data: task.toString(),
          version: QrVersions.auto,
          eyeStyle: const QrEyeStyle(
            eyeShape: QrEyeShape.square,
          ),
          dataModuleStyle: const QrDataModuleStyle(
            dataModuleShape: QrDataModuleShape.circle,
          )),
    );
  }
}
