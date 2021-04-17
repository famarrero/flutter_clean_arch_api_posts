import 'package:flutter_app/src/domain/use_cases/get_remote_comments_usecase.dart';
import 'package:flutter_app/src/presentation/manager/remote_comment_bloc/remote_comment_bloc.dart';
import 'package:flutter_app/src/presentation/manager/remote_post_bloc/remote_post_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/src/domain/use_cases/get_remote_posts_usecase.dart';
import 'data/data_sources/remote_data/post_api_provider.dart';
import 'data/repositories/remote_repository_impl.dart';
import 'domain/repositories/remote_repository.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio client
  injector.registerSingleton<Dio>(Dio());

  // Dependencies
  injector.registerSingleton<PostApiProvider>(PostApiProvider(injector()));

  // Repositories
  injector.registerSingleton<RemoteRepository>(
    RemoteRepositoryImpl(injector()),
  );

  // UseCases
  injector.registerSingleton<GetRemotePostsUseCase>(
      GetRemotePostsUseCase(injector()));
  injector.registerSingleton<GetRemoteCommentsByPostIdUseCase>(
      GetRemoteCommentsByPostIdUseCase(injector())
  );

  // Blocs
  injector.registerFactory<RemotePostBloc>(() => RemotePostBloc(injector()));
  injector.registerFactory<RemoteCommentBloc>(() => RemoteCommentBloc(injector()));
}
