import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:medgrid_app/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:medgrid_app/src/authentication/data/repositories/authentication_repository_implementatio.dart';
import 'package:medgrid_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:medgrid_app/src/authentication/domain/usecases/get_drug_detail.dart';
import 'package:medgrid_app/src/authentication/domain/usecases/drug_info.dart';
import 'package:medgrid_app/src/authentication/domain/usecases/manufacturer_usecase.dart';
import 'package:medgrid_app/src/authentication/presentation/cubit/authentication_cubit.dart';

final sl = GetIt.instance;


Future<void> init() async {
  // loose coupling
  // Service Locator
  sl
  // App Logic 
  // Bloc/Cubit/Getx
    ..registerFactory(
        () => AuthenticaationCubit(getDrugDetail: sl(), getDrugDetailInfo: sl(), getManufacturerDetail: sl()))

    // Use cases
    ..registerLazySingleton(() => GetDrugDetail(sl()))
    ..registerLazySingleton(() => GetDrugDetailInfo(sl()))
    ..registerLazySingleton(() => GetManufacturerDetail(sl()))

    // Repositories 
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImplementation(sl()))

    // Data source
    ..registerLazySingleton<AuthenticationRemoteDatasource>(
        () => AuthRemoteDataSrcImpl(sl()))
      
    // Dependencies
    ..registerLazySingleton(http.Client.new);
}
