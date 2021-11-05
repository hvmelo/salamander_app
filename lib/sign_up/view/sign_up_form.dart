import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:salamander_app/sign_up/sign_up.dart';
import 'package:salamander_app/sign_up/view/widgets.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text(state.errorMessage ?? 'Sign Up Failure')));
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const EmailInput(),
          SizedBox(height: MediaQuery.of(context).size.height / 35),
          const PasswordInput(),
          SizedBox(height: MediaQuery.of(context).size.height / 35),
          const ConfirmedPasswordInput(),
          SizedBox(height: MediaQuery.of(context).size.height / 35),
          const SignUpButton(),
        ],
      ),
    );
  }
}
