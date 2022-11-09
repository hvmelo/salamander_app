import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/app/app.dart';
import 'package:salamander_app/data/repositories/authentication_repository.dart';
import 'package:salamander_app/data/repositories/transaction_fees/transaction_fees_repository.dart';
import 'package:salamander_app/data/repositories/wallet_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authenticationRepository = AuthenticationRepository();
  final walletRepository = WalletRepository();
  final feesRepository = TransactionFeesRepository();
  await authenticationRepository.user.first;
  //await authenticationRepository.logOut();

  Bloc.observer = AppBlocObserver();

  runZonedGuarded(
    () => runApp(App(
      authenticationRepository: authenticationRepository,
      walletRepository: walletRepository,
      feesRepository: feesRepository,
    )),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
