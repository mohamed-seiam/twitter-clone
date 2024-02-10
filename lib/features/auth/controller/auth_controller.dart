import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/auth_api.dart';
import 'package:twitter_clone/core/utils.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(authApI: ref.watch(authProvider));
});

class AuthController extends StateNotifier<bool> {
  final AuthApI _authAPI;

  AuthController({required AuthApI authApI})
      : _authAPI = authApI,
        super(false);

  void signUp(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final response = await _authAPI.signUp(email: email, password: password);
    state = false;
    response.fold((l) {
      showSnackBar(context, l.message);
      print(l.stackTrace);
    }, (r) {
      print(r.email);
    });
  }

  void logIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final response = await _authAPI.logIn(email: email, password: password);
    state = false;
    response.fold((l) {
      showSnackBar(context, l.message);
      print(l.stackTrace);
    }, (r) {
      print(r.clientName);
    });
  }
}
