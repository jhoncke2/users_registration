import 'package:get_it/get_it.dart';
import 'package:registro_usuarios/features/registration/data/data_sources/registration_remote_data_source.dart';
import 'package:registro_usuarios/features/registration/data/repository/registration_repository.dart';
import 'package:registro_usuarios/features/registration/domain/use_cases/register.dart';
import 'package:registro_usuarios/features/registration/presentation/bloc/registration_bloc.dart';

import 'features/registration/domain/repository/registration_repository.dart';

final sl = GetIt.instance;

void init(){
  sl.registerLazySingleton<RegistrationRemoteDataSource>(() => RegistrationRemoteDataSourceImpl());
  sl.registerLazySingleton<RegistrationRepository>(() => RegistrationRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton(() => Register(repository: sl()));
  sl.registerFactory(() => RegistrationBloc(register: sl()));
}