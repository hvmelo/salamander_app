import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/wallet/view/widgets/retry_button.dart';
import 'package:salamander_app/wallet/wallet.dart';

class WalletSetup extends StatelessWidget {
  const WalletSetup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(),
              ),
              Container(
                child: state.status == WalletStatus.error
                    ? const RetryButton()
                    : const CircularProgressIndicator(),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      Text(
                        state.status == WalletStatus.initial
                            ? 'Retrieving wallet data...'
                            : (state.status == WalletStatus.creating
                                ? 'Creating your wallet...'
                                : state.errorMessage ?? 'Error'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
