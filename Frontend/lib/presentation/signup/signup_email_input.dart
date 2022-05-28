import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_validation/application/user_bloc/signup_event.dart';

import '../../application/user_bloc/signup_bloc.dart';
import '../../application/user_bloc/singup_state.dart';
import '../../login_theme.dart';

class EmailInput extends StatelessWidget {
  EmailInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  var outlineInputBorder = OutlineInputBorder(
    gapPadding: 8,
    borderSide:
        const BorderSide(width: 1.2, color: Color.fromARGB(255, 9, 144, 153)),
    borderRadius: BorderRadius.circular(40),
  );
  var outlineErrorBorder = OutlineInputBorder(
    gapPadding: 8,
    borderSide: const BorderSide(width: 1.2, color: Colors.red),
    borderRadius: BorderRadius.circular(40),
  );
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingupBloc, SignupState>(builder: (context, state) {
      return Container(
        height: 90,
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        child: TextFormField(
          initialValue: state.email.value,
          focusNode: focusNode,
          keyboardType: TextInputType.emailAddress,
          showCursor: true,
          style: LoginTheme.textTheme.headline2,
          decoration: InputDecoration(
            errorStyle: const TextStyle(fontSize: 16),
            border: outlineInputBorder,
            focusedErrorBorder: outlineErrorBorder,
            errorBorder: outlineErrorBorder,
            focusedBorder: outlineInputBorder,
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 15, right: 5),
              child: Icon(
                Icons.person_outline,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            hintText: "Email",
            hintStyle: LoginTheme.textTheme.headline4,
            labelText: "Enter name",
            labelStyle: LoginTheme.textTheme.headline3,
            errorText: state.email.invalid
                ? 'Please ensure the email entered is valid'
                : null,
          ),
          onChanged: (value) {
            context.read<SingupBloc>().add(EmailChanged(email: value));
          },
          textInputAction: TextInputAction.next,
        ),
      );
    });
  }
}
