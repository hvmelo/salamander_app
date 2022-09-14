import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/send/send_coins.dart';

class ManualAddressEntryNextButton extends StatelessWidget {
  const ManualAddressEntryNextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendCoinsBloc, SendCoinsState>(
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: ElevatedButton.icon(
            onPressed: () {
              context.read<SendCoinsBloc>().add(ManualInputConfirmed());
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
