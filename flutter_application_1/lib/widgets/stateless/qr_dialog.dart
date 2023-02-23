import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../classes/task.dart';

class QRDialog extends StatelessWidget {
  QRDialog({super.key, required this.task}) {
    qrFutureBuilder = Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(task.title),
        ),
        CustomPaint(
          size: Size.square(200),
          painter: QrPainter(
            data: jsonEncode(task.toQR()),
            version: QrVersions.auto,
            eyeStyle: const QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: Color(0xff128760),
            ),
            dataModuleStyle: const QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.circle,
              color: Color(0xff1a5441),
            ),
          ),
        ),
      ],
    );
  }
  var qrFutureBuilder;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        height: 300,
        width: 300,
        child: qrFutureBuilder,
      ),
    );
  }
}
