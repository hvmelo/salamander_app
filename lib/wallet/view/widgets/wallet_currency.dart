import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/wallet/wallet.dart';

class WalletCurrency extends StatelessWidget {
  const WalletCurrency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        if (state.status != WalletStatus.error) {
          return GestureDetector(
            onTap: () => context.read<WalletBloc>().add(WalletUnitChanged()),
            child: Text(
              state.getUnitStr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return const Center();
        }
      },
    );
  }
}
