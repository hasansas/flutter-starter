import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../../core/widgets/app_button.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Icon(
                Iconsax.home_copy,
                size: 64,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            if (auth.user == null) ...[
              Text("Welcome Guest!", style: textTheme.bodyLarge),
              const SizedBox(height: 16),
              AppButton(
                label: "Login",
                onPressed: () {
                  Navigator.pushNamed(context, "/login");
                },
              ),
            ] else ...[
              Text("Welcome, ${auth.user!.name}"),
              const SizedBox(height: 16),
              AppButton(
                label: "Profile",
                onPressed: () {
                  Navigator.pushNamed(context, "/profile");
                },
              ),
              const SizedBox(height: 8),
              AppButton(
                label: "Logout",
                onPressed: () {
                  authNotifier.logout();
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
