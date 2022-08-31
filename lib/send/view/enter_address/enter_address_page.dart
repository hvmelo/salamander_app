import 'package:flutter/material.dart';
import 'package:salamander_app/send/send_coins.dart';
import 'package:salamander_app/send/view/enter_address/enter_address_view.dart';
import 'package:salamander_app/util/page_routes.dart';

class EnterAddressPage extends StatelessWidget {
  const EnterAddressPage({Key? key}) : super(key: key);

  static Page page() {
    return const MaterialPage<void>(
      child: EnterAddressPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const EnterAddressView(),
      ),
    );
  }
}
