import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/network/api_client_provider.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories_impl/auth_repository_impl.dart';
import 'features/auth/domain/usecases/login_user.dart';
import 'features/auth/domain/usecases/logout_user.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'routes.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ✅ Read the global ApiClient instance (already preloaded in main.dart)
    final apiClientAsync = ref.watch(apiClientProvider);

    return apiClientAsync.when(
      data: (apiClient) {
        // Create dependencies using the preloaded ApiClient
        final remote = AuthRemoteDataSource(apiClient);
        final repo = AuthRepositoryImpl(remote);

        // Provide AuthNotifier override
        return ProviderScope(
          overrides: [
            authProvider.overrideWith((ref) {
              return AuthNotifier(
                loginUser: LoginUser(repo),
                logoutUser: LogoutUser(repo),
              );
            }),
          ],
          child: MaterialApp(
            title: 'FDD Demo',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            initialRoute: Routes.home,
            routes: Routes.getRoutes(),
          ),
        );
      },
      loading: () => const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      error: (e, _) => MaterialApp(
        home: Scaffold(
          body: Center(child: Text('Failed to initialize API: $e')),
        ),
      ),
    );
  }
}
