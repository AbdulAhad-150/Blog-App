import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/features/auth/Data/DataSource/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/Data/repository/auth_repository_impl.dart';
import 'package:blog_app/features/auth/Domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/Domain/usecase/user_login.dart';
import 'package:blog_app/features/auth/Domain/usecase/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initdependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supaBaseUrl,
    publishableKey: AppSecrets.supaBaseAnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(serviceLocator()),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));
  serviceLocator.registerFactory(() => UserLogin(serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => AuthBloc(userSignUp: serviceLocator(), userLogin: serviceLocator()),
  );
}
