import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:salamander_app/send_payment/send_payment.dart';
import 'package:salamander_app/send_payment/view/qr_scan/widgets/next_button.dart';

import 'widgets/qr_view_widget.dart';

class QRScanView extends StatelessWidget {
  const QRScanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () => context.flow<SendPaymentState>().complete(),
          child: const Icon(Icons.close),
        ),
        title: const Text(
          'SEND PAYMENT',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Stack(
          children: <Widget>[
            QRViewWidget(),
            Column(
              children: [
                Expanded(
                  child: Container(),
                ),
                Container(
                  height: 70,
                  child: Column(
                    children: [
                      const QRScanNextButton(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
