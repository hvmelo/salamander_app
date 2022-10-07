import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/send_payment/pages/qr_scan/qr_scan.dart';
import 'package:salamander_app/send_payment/send_payment.dart';
import 'qr_view_widget.dart';

class QRScanView extends StatelessWidget {
  const QRScanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<QRScanCubit, QRScanState>(
      listener: (context, state) {
        switch (state.status) {
          case QRScanStatus.successWithAddress:
            context
                .flow<PaymentFlowData>()
                .update((s) => s.copyWith(address: state.address));
            break;
          case QRScanStatus.successWithInvoice:
            context
                .flow<PaymentFlowData>()
                .update((s) => s.copyWith(invoice: state.invoice));
            break;
          case QRScanStatus.failure:
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..clearSnackBars()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Unknown error'),
                ),
              );
            break;
          default:
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: GestureDetector(
            onTap: () => context.flow<PaymentFlowData>().complete(),
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
                        BlocBuilder<QRScanCubit, QRScanState>(
                          builder: (context, state) {
                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  context.flow<PaymentFlowData>().update(
                                      (state) =>
                                          state.copyWith(useQRCode: false));
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  size: 20,
                                ),
                                label: const Text(
                                  'Enter address manually',
                                  style: TextStyle(fontSize: 14),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blueGrey[900],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
