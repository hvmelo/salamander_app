import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/send_payment/send_payment.dart';

class EnterAmountInputForm extends StatefulWidget {
  EnterAmountInputForm({Key? key}) : super(key: key);

  @override
  State<EnterAmountInputForm> createState() => _EnterAmountInputFormState();
}

class _EnterAmountInputFormState extends State<EnterAmountInputForm> {
  final inputAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    inputAmountController.addListener(() => context
        .read<SendPaymentBloc>()
        .add(InputAmountChanged(inputAmountController.text)));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    inputAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendPaymentBloc, SendPaymentState>(
      listenWhen: (previous, current) {
        if (current is SendPaymentEnterAmountState &&
            previous is SendPaymentEnterAmountState) {
          return previous.amountInSats != current.amountInSats &&
              inputAmountController.text != current.amountInSats.toString();
        }
        return false;
      },
      listener: (context, state) {
        var currentState = state as SendPaymentEnterAmountState;
        inputAmountController.text = currentState.amountInSats.toString();
      },
      child: TextField(
        key: const Key('sendPayment_amountInput_textField'),
        controller: inputAmountController,
        minLines: 20,
        maxLines: null,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
