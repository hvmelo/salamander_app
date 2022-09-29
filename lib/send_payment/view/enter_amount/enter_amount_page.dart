import 'package:flutter/material.dart';

import 'enter_amount_view.dart';

class EnterAmountPage extends StatelessWidget {
  const EnterAmountPage({Key? key}) : super(key: key);

  static Page page() {
    return const MaterialPage<void>(
      child: EnterAmountPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const EnterAmountView(),
      ),
    );
  }
}
