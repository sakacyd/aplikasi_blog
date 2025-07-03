import 'package:aplikasi_blog/core/error/failures.dart';
import 'package:aplikasi_blog/core/usecase/usecase.dart';
import 'package:aplikasi_blog/core/common/entities/user.dart';
import 'package:aplikasi_blog/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrenUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;

  CurrenUser(this.authRepository);
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}


