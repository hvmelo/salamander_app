import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/send/send_coins.dart';

class PasteFromClipboardButton extends StatefulWidget {
  PasteFromClipboardButton({Key? key}) : super(key: key);

  @override
  State<PasteFromClipboardButton> createState() =>
      _PasteFromClipboardButtonState();
}

class _PasteFromClipboardButtonState extends State<PasteFromClipboardButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendCoinsBloc, SendCoinsState>(
      builder: (context, state) {
        return ElevatedButton.icon(
          onPressed: () async {
            var cdata = await Clipboard.getData(Clipboard.kTextPlain);
            var copiedtext = cdata?.text;
            if (copiedtext != null) {
              context
                  .read<SendCoinsBloc>()
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
