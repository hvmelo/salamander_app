import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/app/app.dart';
import 'package:salamander_app/data/repositories/authentication_repository.dart';
import 'package:salamander_app/data/repositories/wallet_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authenticationRepository = AuthenticationRepository();
  final walletRepository = WalletRepository();
  await authenticationRepository.user.first;
  //await authenticationRepository.logOut();
  BlocOverrides.runZoned(
    () => runApp(App(
      authenticationRepository: authenticationRepository,
      walletRepository: walletRepository,
    )),
    blocObserver: AppBlocObserver(),
  );
}
