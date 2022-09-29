import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/send_payment/send_payment.dart';

class EnterAddressPasteButton extends StatefulWidget {
  EnterAddressPasteButton({Key? key}) : super(key: key);

  @override
  State<EnterAddressPasteButton> createState() =>
      _EnterAddressPasteButtonState();
}

class _EnterAddressPasteButtonState extends State<EnterAddressPasteButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendPaymentBloc, SendPaymentState>(
      builder: (context, state) {
        return ElevatedButton.icon(
          onPressed: () async {
            var cdata = await Clipboard.getData(Clipboard.kTextPlain);
            var copiedtext = cdata?.text;
            if (copiedtext != null) {
              context
                  .read<SendPaymentBloc>()
                  .add(PasteFromClipboardRequested(copiedtext));
            }
          },
          icon: const Icon(
            Icons.paste,
            size: 20,
          ),
          label: const Text(
            'Paste from Clipboard',
            style: TextStyle(fontSize: 14),
          ),
          style: ElevatedButton.styleFrom(
            primary: const Color.fromARGB(255, 4, 96, 171),
          ),
        );
      },
    );
  }
}
