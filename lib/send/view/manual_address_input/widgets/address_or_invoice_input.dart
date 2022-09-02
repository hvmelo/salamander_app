import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/send/send_coins.dart';

class ManualAddressEntryAddressInput extends StatefulWidget {
  ManualAddressEntryAddressInput({Key? key}) : super(key: key);

  @override
  State<ManualAddressEntryAddressInput> createState() =>
      _ManualAddressEntryAddressInputState();
}

class _ManualAddressEntryAddressInputState
    extends State<ManualAddressEntryAddressInput> {
  final inputAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    inputAddressController.addListener(() => context
        .read<SendCoinsBloc>()
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
    return BlocListener<SendCoinsBloc, SendCoinsState>(
      listenWhen: (previous, current) {
        if (current is SendCoinsManualEntryState &&
            previous is SendCoinsManualEntryState) {
          return previous.value != current.value &&
              inputAddressController.text != current.value;
        }
        return false;
      },
      listener: (context, state) {
        var currentState = state as SendCoinsManualEntryState;
        inputAddressController.text = currentState.value;
      },
      child: TextField(
        key: const Key('sendCoins_addressInput_textField'),
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
