import 'package:flutter/material.dart';

import 'qr_scan_view.dart';

class QRScanPage extends StatelessWidget {
  const QRScanPage({Key? key}) : super(key: key);

  static Page page() {
    return const MaterialPage<void>(
      child: QRScanPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const QRScanView(),
      ),
    );
  }
}
