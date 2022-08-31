import 'package:flutter/material.dart';
import 'package:salamander_app/send/send_coins.dart';
import 'package:salamander_app/util/page_routes.dart';

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
