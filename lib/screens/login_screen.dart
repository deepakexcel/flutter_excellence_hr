import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';
import '../services/authentication_services.dart';
import '../widgets/login/login.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              print("login screen line 21");
              print(state.toString());
              if (state is NotAuthenticated) {
                return _AuthForm(); // show authentication form
              }

              // show splash screen
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            },
          )),
    ));
  }
}

class _AuthForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = RepositoryProvider.of<AuthenticationService>(context);

    return Container(
      alignment: Alignment.center,
      child: Column(
          //      mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Logo(),
              ],
            ),
            WelcomeScreen(),
            LoginPage(),
            GoogleLogin(),
            LoginBottom(),
          ],
        )
    );
  }
}
