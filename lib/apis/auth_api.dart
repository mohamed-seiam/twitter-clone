import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/providers.dart';

import '../core/core.dart';

final authProvider = Provider((ref) {
  final account = ref.watch(appWriteAccountProvider);
  return AuthApI(account: account);
});

abstract class IAuthApI {
  FutureEither<model.User> signUp(
      {required String email, required String password});

  FutureEither<model.Session> logIn(
      {required String email, required String password});
}

class AuthApI implements IAuthApI {
  final Account _user;

  AuthApI({required Account account}) : _user = account;

  @override
  FutureEither<model.User> signUp(
      {required String email, required String password}) async {
    try {
      final user = await _user.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );
      return Right(user);
    } on AppwriteException catch (error, stackTrace) {
      return Left(
        Failure(
          error.message ?? 'Some unexpected error occurred',
          stackTrace,
        ),
      );
    } catch (error, stackTrace) {
      return Left(
        Failure(
          error.toString(),
          stackTrace,
        ),
      );
    }
  }

  @override
  FutureEither<model.Session> logIn(
      {required String email, required String password}) async {
    try {
      final session = await _user.createEmailSession(
        email: email,
        password: password,
      );
      return Right(session);
    } on AppwriteException catch (error, stackTrace) {
      return Left(
        Failure(
          error.message ?? 'Some unexpected error occurred',
          stackTrace,
        ),
      );
    } catch (error, stackTrace) {
      return Left(
        Failure(
          error.toString(),
          stackTrace,
        ),
      );
    }
  }
}
