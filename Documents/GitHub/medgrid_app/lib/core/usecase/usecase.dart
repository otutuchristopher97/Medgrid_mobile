import 'package:medgrid_app/core/utils/typedef.dart';

abstract class UsecaseWithParaams<Type, Params> {
  const UsecaseWithParaams();
  ResultFuture<Type> call(Params params);
}

abstract class UsecaseWithoutParams<Type> {
  const UsecaseWithoutParams();

  ResultFuture<Type> call();
}
