import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:signup_validation/application/user_bloc/signup_bloc.dart';
import 'package:signup_validation/application/user_bloc/singup_state.dart';
import 'package:signup_validation/infrastructure/userRepository.dart';
import 'package:signup_validation/presentation/signup/signup_comform_password_input.dart';
import 'package:signup_validation/presentation/signup/signup_email_input.dart';
import 'package:signup_validation/presentation/signup/signup_name_input.dart';

import '../../application/user_bloc/signup_event.dart';
import '../../login_theme.dart';
import 'signup_password_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  UserRepository userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 47, 198, 209),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_outlined),
        //   iconSize: 35.0,
        //   color: Colors.white,
        //   onPressed: () {},
        // ),
      ),
      body: BlocProvider(
          create: (context) => SingupBloc(userRepository: userRepository),
          child: SignupForm()),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmpasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameFocusNode.addListener(() {
      if (!_nameFocusNode.hasFocus) {
        context.read<SingupBloc>().add(NameUnfocused());
        FocusScope.of(context).requestFocus(_emailFocusNode);
      }
    });
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<SingupBloc>().add(EmailUnfocused());
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<SingupBloc>().add(PasswordUnfocused());
      }
    });
    _confirmpasswordFocusNode.addListener(() {
      if (!_confirmpasswordFocusNode.hasFocus) {
        context.read<SingupBloc>().add(ConfirmPasswordUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmpasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SingupBloc, SignupState>(
        listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            showDialog<void>(
              context: context,
              builder: (_) => SuccessDialog(),
            );
          }
          if (state.status.isSubmissionInProgress) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Submitting...')),
              );
          }

          if (state is SignedState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(state.message.toString())),
              );
            context.go('/login');
          }
          if (state is FailedState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(state.message.toString())),
              );
          }
        },
        child: ListView(children: <Widget>[
          // start .. container of header login text
          Container(
            margin:
                const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 5),
            alignment: Alignment.center,
            child: Text(
              "Create Account",
              style: LoginTheme.textTheme.headline1,
            ),
          ),

          // end .. container of header login text

          // start .. container of fill form text
          Container(
            margin: const EdgeInsets.only(left: 30, right: 30, bottom: 40),
            alignment: Alignment.center,
            child: Text(
              "Please fill the form below here",
              style: LoginTheme.textTheme.headline3,
            ),
          ),

          Container(
              margin: const EdgeInsets.only(
                  left: 30, right: 30, top: 20, bottom: 10),
              child: Column(children: [
                NameInput(focusNode: _nameFocusNode),
                EmailInput(focusNode: _emailFocusNode),
                PasswordInput(focusNode: _passwordFocusNode),
                ConfirmPasswordInput(focusNode: _confirmpasswordFocusNode),
                // ConfirmPasswordInput(),
                SubmitButton(),
                Container(
                  margin: const EdgeInsets.only(bottom: 50, top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?",
                          style: LoginTheme.textTheme.headline3),
                      TextButton(
                          onPressed: () {
                            context.go('/login');
                          },
                          child: Text(
                            "Sign in",
                            style: LoginTheme.textTheme.headline5,
                          )),
                    ],
                  ),
                ),
              ])),
          // end .. container of fill form text

          // user name input field
        ]));
  }
}

// success dialog
class SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: const <Widget>[
                Icon(Icons.info),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Form Submitted Successfully!',
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingupBloc, SignupState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 11, horizontal: 65),
                primary: Color.fromARGB(255, 56, 231, 243),
                // background
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))
                // foreground
                ),
            onPressed: state.status.isValidated
                ? () => context.read<SingupBloc>().add(FormSubmitted())
                : null,
            child: const Text('Submit'),
          ),
        );
      },
    );
  }
}

class SubmitButttonm extends StatelessWidget {
  const SubmitButttonm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return // start ...login button container
        BlocBuilder<SingupBloc, SignupState>(
      buildWhen: ((previous, current) => previous.status != current.status),
      builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 10),
          // color: const Color.fromARGB(255, 56, 231, 243),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                textStyle: TextStyle(color: Colors.green),
                padding:
                    const EdgeInsets.symmetric(vertical: 11, horizontal: 65),
                primary: Color.fromARGB(255, 57, 85, 128),
                // background
                // background
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))
                // foreground
                ),
            onPressed: state.status.isValidated
                ? () => context.read<SingupBloc>().add(FormSubmitted())
                : null,
            child: Text("SignUp", style: LoginTheme.textTheme.headline1),
          ),
        );
      },
    );
  }
}
