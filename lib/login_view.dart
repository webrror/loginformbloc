import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginformbloc/bloc/auth_bloc.dart';
import 'package:loginformbloc/home_screen.dart';
import 'package:loginformbloc/widgets/gradient_button.dart';
import 'package:loginformbloc/widgets/login_field.dart';
import 'package:loginformbloc/widgets/social_button.dart';

// TWO WAYS

// 1. BlocListener(for logic part) + BlocBuilder(for UI) (sep. widgets)
// 2. BlocConsumer (single widget) (basically BlocListener + BlocBuilder)

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ONE WAY TO IMPLEMENT BLOC
      //   body: BlocListener<AuthBloc, AuthState>(
      //     listener: (context, state) {
      //       if (state is AuthFailure) {
      //         ScaffoldMessenger.of(context).showSnackBar(
      //           SnackBar(
      //             content: Text(state.error),
      //             behavior: SnackBarBehavior.floating,
      //           ),
      //         );
      //       }

      //       if (state is AuthSuccess) {
      //         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      //           builder: (context) {
      //             return const HomeScreen();
      //           },
      //         ), (route) => false);
      //       }
      //     },
      //     child: BlocBuilder<AuthBloc, AuthState>(
      //       builder: (context, state) {
      //         return SingleChildScrollView(
      //           child: Center(
      //             child: Column(
      //               children: [
      //                 Image.asset('assets/images/signin_balls.png'),
      //                 const Text(
      //                   'Sign in.',
      //                   style: TextStyle(
      //                     fontWeight: FontWeight.bold,
      //                     fontSize: 50,
      //                   ),
      //                 ),
      //                 const SizedBox(height: 50),
      //                 const SocialButton(
      //                     iconPath: 'assets/svgs/g_logo.svg',
      //                     label: 'Continue with Google'),
      //                 const SizedBox(height: 20),
      //                 const SocialButton(
      //                   iconPath: 'assets/svgs/f_logo.svg',
      //                   label: 'Continue with Facebook',
      //                   horizontalPadding: 90,
      //                 ),
      //                 const SizedBox(height: 15),
      //                 const Text(
      //                   'or',
      //                   style: TextStyle(
      //                     fontSize: 17,
      //                   ),
      //                 ),
      //                 const SizedBox(height: 15),
      //                 LoginField(
      //                   hintText: 'Email',
      //                   controller: emailController,
      //                 ),
      //                 const SizedBox(height: 15),
      //                 LoginField(
      //                   hintText: 'Password',
      //                   controller: passwordController,
      //                 ),
      //                 const SizedBox(height: 20),
      //                 if (state is AuthLoader) ...[
      //                   const CircularProgressIndicator(
      //                     strokeCap: StrokeCap.round,
      //                   )
      //                 ] else ...[
      //                   GradientButton(
      //                     onPressed: () {
      //                       context.read<AuthBloc>().add(
      //                             SubmitEvent(
      //                               email: emailController.text.trim(),
      //                               password: passwordController.text.trim(),
      //                             ),
      //                           );
      //                     },
      //                   ),
      //                 ],
      //                 const SizedBox(height: 100),
      //               ],
      //             ),
      //           ),
      //         );
      //       },
      //     ),
      //   ),

      // ANOTHER WAY
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Image.asset('assets/images/signin_balls.png'),
                  const Text(
                    'Sign in to your account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                  const SizedBox(height: 50),
                  const SocialButton(
                      iconPath: 'assets/svgs/g_logo.svg',
                      label: 'Continue with Google'),
                  const SizedBox(height: 15),
                  const Text(
                    'or',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 15),
                  LoginField(
                    hintText: 'Email',
                    controller: emailController,
                  ),
                  const SizedBox(height: 15),
                  LoginField(
                    hintText: 'Password',
                    controller: passwordController,
                  ),
                  const SizedBox(height: 20),
                  if (state is AuthLoader) ...[
                    const CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                    )
                  ] else ...[
                    GradientButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              SubmitEvent(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
                      },
                    ),
                  ],
                  const SizedBox(height: 50),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }

          if (state is AuthSuccess) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (context) {
                return const HomeScreen();
              },
            ), (route) => false);
          }
        },
      ),
    );
  }
}
