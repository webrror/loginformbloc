import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginformbloc/bloc/auth_bloc.dart';
import 'package:loginformbloc/login_view.dart';
import 'package:loginformbloc/widgets/gradient_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) {
              return const LoginScreen();
            },
          ), (route) => false);
        }
      },
      builder: (context, state) {
        if (state is AuthSuccess) {
          AuthSuccess data = state;
          return Scaffold(
            appBar: AppBar(
              title: Text("Welcome ${data.name}"),
            ),
            body: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.uid,
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    data.name,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GradientButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(LogoutEvent());
                    },
                    text: "Log out",
                  )
                ],
              ),
            ),
          );
        } else if (state is AuthLoader) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                strokeCap: StrokeCap.round,
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: SizedBox(),
          );
        }
      },
    );
  }
}
