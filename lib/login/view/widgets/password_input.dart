import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/login/login.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Container(
          width: MediaQuery.of(context).size.width / 1.3,
          child: TextField(
            key: const Key('loginForm_passwordInput_textField'),
            onChanged: (password) =>
                context.read<LoginCubit>().passwordChanged(password),
            style: const TextStyle(color: Colors.white),
            obscureText: true,
            decoration: InputDecoration(
              hintStyle: const TextStyle(
                color: Colors.white,
              ),
              labelText: 'Password',
              helperText: '',
              errorText: state.password.displayError != null ? 'invalid password' : null,
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
