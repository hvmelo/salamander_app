import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/send_payment/send_payment.dart';
import 'package:flow_builder/flow_builder.dart';

class EnterAddressNextButton extends StatelessWidget {
  const EnterAddressNextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendPaymentBloc, SendPaymentState>(
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: ElevatedButton.icon(
            onPressed: () {
              //context.read<SendPaymentBloc>().add(InputAddressSubmitted());
              context.flow<SendPaymentState>().update((state) =>
                  SendPaymentEnterAmountState(
                      address: "teste", amountInSats: 0));
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 20,
            ),
            label: const Text(
              'Next',
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
