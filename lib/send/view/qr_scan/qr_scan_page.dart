import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/send/send_coins.dart';
import 'package:salamander_app/util/page_routes.dart';

class QRScanPage extends StatelessWidget {
  const QRScanPage({Key? key}) : super(key: key);

  static Route route() {
    return BottomUpPageRoute<void>(
      builder: (_) => const QRScanPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: BlocProvider<QRScanCubit>(
          create: (context) => QRScanCubit(),
          child: const QRScanView(),
        ),
      ),
    );
  }
}
