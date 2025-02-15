import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/app/app.dart';
import 'package:salamander_app/data/repositories/authentication_repository.dart';
import 'package:salamander_app/data/repositories/transaction_fees/transaction_fees_repository.dart';
import 'package:salamander_app/data/repositories/wallet/wallet_repository.dart';
import 'package:salamander_app/data/repositories/wallet_repository.dart';
import 'package:salamander_app/theme.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
    required WalletRepository walletRepository,
    required TransactionFeesRepository feesRepository,
  })  : _authenticationRepository = authenticationRepository,
        _walletRepository = walletRepository,
        _feesRepository = feesRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  final WalletRepository _walletRepository;
  final TransactionFeesRepository _feesRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>.value(
          value: _authenticationRepository,
        ),
        RepositoryProvider<WalletRepository>.value(
          value: _walletRepository,
        ),
        RepositoryProvider<TransactionFeesRepository>.value(
          value: _feesRepository,
        )
      ],
      child: BlocProvider(
        create: (context) =>
            AppBloc(authenticationRepository: _authenticationRepository),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Salamander',
        home: FlowBuilder<AppStatus>(
          state: context.select((AppBloc bloc) => bloc.state.status),
          onGeneratePages: onGenerateAppViewPages,
        ),
        theme: theme);
  }
}
