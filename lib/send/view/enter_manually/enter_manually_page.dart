import 'package:flutter/material.dart';
import 'enter_manually_view.dart';

class EnterManuallyPage extends StatelessWidget {
  const EnterManuallyPage({Key? key}) : super(key: key);

  static Page page() {
    return const MaterialPage<void>(
      child: EnterManuallyPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const EnterManuallyView(),
      ),
    );
  }
}
