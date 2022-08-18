import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/wallet/view/widgets/receive_dialog.dart';
import 'package:salamander_app/wallet/wallet.dart';

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
                  onPressed: () {
                    print('Send Pressed');
                  },
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
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );
        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return ReceiveCoinsDialog(address: address);
      },
    );
  }
}
