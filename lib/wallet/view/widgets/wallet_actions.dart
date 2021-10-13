import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shopping_cart/wallet/cubit/wallet_cubit.dart';

class WalletActions extends StatelessWidget {
  const WalletActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: OutlinedButton.icon(
              label: const Text('RECEIVE'),
              icon: const Icon(Icons.download),
              onPressed: () {
                print('Receive Pressed');
              },
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
  }
}
