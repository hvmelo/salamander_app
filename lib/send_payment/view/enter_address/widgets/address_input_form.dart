import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/send_payment/send_payment.dart';

class EnterAddressInputForm extends StatefulWidget {
  EnterAddressInputForm({Key? key}) : super(key: key);

  @override
  State<EnterAddressInputForm> createState() => _EnterAddressInputFormState();
}

class _EnterAddressInputFormState extends State<EnterAddressInputForm> {
  final inputAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // var theState =
    //     context.read<SendPaymentBloc>().state as SendPaymentEnterAddressState;
    inputAddressController
      //..text = theState.address
      ..addListener(() => context
          .read<SendPaymentBloc>()
          .add(InputAddressChanged(inputAddressController.text)));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    inputAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendPaymentBloc, SendPaymentState>(
      listenWhen: (previous, current) =>
          current is SendPaymentEnterAddressState,
      listener: (context, state) {
        if (state is SendPaymentEnterAddressState) {
          inputAddressController.text = state.address;
        }
      },
      child: TextField(
        key: const Key('sendPayment_addressInput_textField'),
        controller: inputAddressController,
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
