import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/send_payment/pages/address_input.dart';

class AddressInputForm extends StatefulWidget {
  AddressInputForm({Key? key}) : super(key: key);

  @override
  State<AddressInputForm> createState() => _AddressInputFormState();
}

class _AddressInputFormState extends State<AddressInputForm> {
  final inputAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var state = context.read<AddressInputState>();
    inputAddressController
      ..text = state.input
      ..addListener(() => context
          .read<AddressInputCubit>()
          .formInputChanged(inputAddressController.text));
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
    return BlocListener<AddressInputCubit, AddressInputState>(
      listener: (context, state) {
        inputAddressController.text = state.input;
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
