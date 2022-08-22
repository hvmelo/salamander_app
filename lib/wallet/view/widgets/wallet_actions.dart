import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/send/send_coins.dart';
import 'package:salamander_app/util/transitions.dart';
import 'package:salamander_app/wallet/wallet.dart';

import '../widgets.dart';

class WalletActions extends StatelessWidget {
  const WalletActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        return Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  label: const Text('RECEIVE'),
                  icon: const Icon(Icons.download),
                  onPressed: state.status == WalletStatus.synced
                      ? () => _displayReceiveDialog(context, state.address)
                      : null,
                ),
              ),
              Container(
                width: 1,
                height: 30,
                color: Colors.blue.shade200,
              ),
              Expanded(
                child: OutlinedButton.icon(
                  label: const Text('SEND'),
                  icon: const Icon(Icons.upload),
                  onPressed: state.status == WalletStatus.synced
                      ? () => Navigator.of(context)
                          .push<void>(SendCoinsPage.route())
                      : null,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _displayReceiveDialog(BuildContext context, String address) {
    showGeneralDialog(
      context: context,
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return BottomUpTransition(animation: animation, child: child);
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return ReceiveCoinsDialog(address: address);
      },
    );
  }
}
