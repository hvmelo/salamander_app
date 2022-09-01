import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:salamander_app/send/send_coins.dart';

class QRViewWidget extends StatefulWidget {
  QRViewWidget({Key? key}) : super(key: key);

  @override
  State<QRViewWidget> createState() => _QRViewWidgetState();
}

class _QRViewWidgetState extends State<QRViewWidget> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrViewController;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrViewController!.pauseCamera();
    } else if (Platform.isIOS) {
      qrViewController!.resumeCamera();
    }
  }

  @override
  void dispose() {
    qrViewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = MediaQuery.of(context).size.width * 0.5;
    return BlocBuilder<SendCoinsBloc, SendCoinsState>(
      builder: (context, state) {
        return QRView(
          key: qrKey,
          onQRViewCreated: (controller) {
            qrViewController = controller;
            controller.scannedDataStream.listen((scanData) {
              var code = scanData.code;
              if (code != null) {
                context.read<SendCoinsBloc>().add(QRCodeRead(code));
              }
            });
          },
          overlay: QrScannerOverlayShape(
              borderColor: Colors.blue,
              borderRadius: 15,
              borderLength: 20,
              borderWidth: 15,
              overlayColor: const Color.fromRGBO(0, 0, 0, 60),
              cutOutSize: scanArea),
          onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        );
      },
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    //log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No permission to access the camera')),
      );
    }
  }
}
