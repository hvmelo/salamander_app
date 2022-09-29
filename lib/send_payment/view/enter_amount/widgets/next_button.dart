import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/send_payment/send_payment.dart';

class EnterAmountNextButton extends StatelessWidget {
  const EnterAmountNextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendPaymentBloc, SendPaymentState>(
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: ElevatedButton.icon(
            onPressed: () {
              context.read<SendPaymentBloc>().add(InputAmountSubmitted());
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
