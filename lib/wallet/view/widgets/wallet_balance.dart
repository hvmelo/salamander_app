import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/wallet/wallet.dart';

class WalletBalance extends StatelessWidget {
  const WalletBalance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        if (state.status != WalletStatus.error) {
          return GestureDetector(
            onTap: () => context.read<WalletBloc>().add(WalletUnitChanged()),
            child: Text(
              state.balanceStr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        } else {
          return const Text(
            "Can't retrieve balance",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32.0,
              fontWeight: FontWeight.w500,
            ),
          );
        }
      },
    );
  }
}
