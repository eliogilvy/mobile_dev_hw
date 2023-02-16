// import 'package:flutter/material.dart';

// import 'package:mobile_scanner/mobile_scanner.dart';

// class QRScanner extends StatefulWidget {
//   const QRScanner({super.key});

//   @override
//   State<QRScanner> createState() => _QRScannerState();
// }

// class _QRScannerState extends State<QRScanner> {
//   late MobileScannerController controller = MobileScannerController();
//   Barcode? barcode;
//   BarcodeCapture? barcodeCapture;
//   MobileScannerArguments? arguments;

//   Future<void> onDetect(BarcodeCapture barcode) async {
//     setState(() {
//       this.barcode = barcode.barcodes.first;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final scanWindow = Rect.fromCenter(
//       center: MediaQuery.of(context).size.center(Offset.zero),
//       width: 200,
//       height: 200,
//     );
//     return Stack(
//       fit: StackFit.expand,
//       children: [
//         MobileScanner(
//           onDetect: onDetect,
//           scanWindow: scanWindow,
//           controller: controller,
//           onScannerStarted: ((arguments) {
//             setState(() {
//               this.arguments = arguments;
//             });
//           }),
//         ),
//       ],
//     );
//   }
// }
