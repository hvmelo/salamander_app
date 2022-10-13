import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/data/repositories/wallet_repository.dart';

import 'amount_input.dart';

class AmountInputPage extends StatelessWidget {
  const AmountInputPage({super.key});

  static MaterialPage<void> page() {
    return const MaterialPage<void>(child: AmountInputPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          AmountInputCubit(walletRepository: context.read<WalletRepository>())
            ..init(),
      child: const AmountInputView(),
    );
  }
}
