import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SubmitEvent>(_onSubmit);
    on<LogoutEvent>(_onLogout);
  }

  // Commented as Observer is added
  // @override
  // void onChange(Change<AuthState> change) {
  //   debugPrint("AuthBloc : $change");
  //   super.onChange(change);
  // }

  // // Only in Bloc
  // @override
  // void onTransition(Transition<AuthEvent, AuthState> transition) {
  //   debugPrint("AuthBloc : $transition");
  //   // Gives additional info - what event caused change in state
  //   super.onTransition(transition);
  // }

  void _onSubmit(SubmitEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoader());
    try {
      final email = event.email;
      final pass = event.password;

      if (pass.length < 6) {
        return emit(AuthFailure('Password must be at least 6 characters long'));
      }

      if (email.isEmpty) {
        return emit(AuthFailure('Enter you email'));
      }

      if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email)) {
        return emit(AuthFailure('Enter a valid email'));
      }

      await Future.delayed(
        const Duration(seconds: 1),
        () {
          return emit(
            AuthSuccess(
              uid: Random().nextInt(4917).toString(),
              name: email.split("@").first,
            ),
          );
        },
      );
    } catch (e) {
      return emit(AuthFailure(e.toString()));
    }
  }

  void _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoader());
    try {
      await Future.delayed(
        const Duration(seconds: 4),
        () {
          return emit(AuthInitial());
        },
      );
    } catch (e) {
      return emit(AuthFailure(e.toString()));
    }
  }
}
