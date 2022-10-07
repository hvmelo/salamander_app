import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/send_payment/pages/address_input/address_input.dart';

class AddressInputPage extends StatelessWidget {
  const AddressInputPage({super.key});

  static MaterialPage<void> page() {
    return const MaterialPage<void>(child: AddressInputPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddressInputCubit(),
      child: const AddressInputView(),
    );
  }
}
