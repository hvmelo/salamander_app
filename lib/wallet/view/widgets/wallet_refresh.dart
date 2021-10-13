import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shopping_cart/wallet/cubit/wallet_cubit.dart';

class WalletRefresh extends StatelessWidget {
  const WalletRefresh({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        if (state.status != WalletStatus.error) {
          return const Center(
            child: SizedBox(
              height: 40,
              width: 40,
              child: Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  //child: CircularProgressIndicator(),
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: SizedBox(
              height: 40,
              width: 40,
              child: IconButton(
                  icon: const Icon(Icons.refresh),
                  padding: const EdgeInsets.all(5),
                  iconSize: 25,
                  color: Colors.blue.shade300,
                  onPressed: () => context.read<WalletCubit>().startSyncing()),
            ),
          );
        }
      },
    );
  }
}
