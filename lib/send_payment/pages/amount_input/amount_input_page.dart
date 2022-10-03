import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'amount_input.dart';

class AmountInputPage extends StatelessWidget {
  const AmountInputPage({super.key});

  static MaterialPage<void> page() {
    return const MaterialPage<void>(child: AmountInputPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AmountInputCubit(),
      child: const AmountInputView(),
    );
  }
}
