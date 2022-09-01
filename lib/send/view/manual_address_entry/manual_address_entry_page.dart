import 'package:flutter/material.dart';
import 'manual_address_entry_view.dart';

class ManualAddressEntryPage extends StatelessWidget {
  const ManualAddressEntryPage({Key? key}) : super(key: key);

  static Page page() {
    return const MaterialPage<void>(
      child: ManualAddressEntryPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const ManualAddressEntryView(),
      ),
    );
  }
}
