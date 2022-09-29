import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/send_payment/send_payment.dart';
import 'package:flow_builder/flow_builder.dart';

class QRScanNextButton extends StatelessWidget {
  const QRScanNextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendPaymentBloc, SendPaymentState>(
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: ElevatedButton.icon(
            onPressed: () {
              context
                  .flow<SendPaymentState>()
                  .update((state) => SendPaymentEnterAddressState.initial);
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
    );
  }
}
