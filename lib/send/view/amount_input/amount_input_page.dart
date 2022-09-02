import 'package:flutter/material.dart';

class AmountInputPage extends StatelessWidget {
  const AmountInputPage({Key? key}) : super(key: key);

  static Page page() {
    return const MaterialPage<void>(
      child: AmountInputPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const AmountInputPage(),
      ),
    );
  }
}
