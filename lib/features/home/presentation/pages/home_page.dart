import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../../core/widgets/custom_button.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (auth.user == null) ...[
              const Text("Welcome Guest!"),
              const SizedBox(height: 16),
              CustomButton(
                label: "Login",
                onPressed: () {
                  Navigator.pushNamed(context, "/login");
                },
              ),
            ] else ...[
              Text("Welcome, ${auth.user!.name}"),
              const SizedBox(height: 16),
              CustomButton(
                label: "Profile",
                onPressed: () {
                  Navigator.pushNamed(context, "/profile");
                },
              ),
              const SizedBox(height: 8),
              CustomButton(
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
