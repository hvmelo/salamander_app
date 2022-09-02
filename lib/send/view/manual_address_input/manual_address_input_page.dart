import 'package:flutter/material.dart';
import 'manual_address_input_view.dart';

class ManualAddressInputPage extends StatelessWidget {
  const ManualAddressInputPage({Key? key}) : super(key: key);

  static Page page() {
    return const MaterialPage<void>(
      child: ManualAddressInputPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const ManualAddressInputView(),
      ),
    );
  }
}
