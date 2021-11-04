import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/login/cubit/login_cubit.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Container(
          width: MediaQuery.of(context).size.width / 1.3,
          child: TextField(
            key: const Key('loginForm_emailInput_textField'),
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white),
            onChanged: (email) =>
                context.read<LoginCubit>().emailChanged(email),
            decoration: InputDecoration(
              hintStyle: const TextStyle(
                color: Colors.white,
              ),
              labelText: 'Email',
              helperText: '',
              errorText: state.email.invalid ? 'invalid email' : null,
              labelStyle: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
