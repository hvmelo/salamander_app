import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/qr_scan_cubit.dart';
import 'view/qr_scan_view.dart';

class QRScanPage extends StatelessWidget {
  const QRScanPage({super.key});

  static MaterialPage<void> page() {
    return const MaterialPage<void>(child: QRScanPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QRScanCubit(),
      child: const QRScanView(),
    );
  }
}
