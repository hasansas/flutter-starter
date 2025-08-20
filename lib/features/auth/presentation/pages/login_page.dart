import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../providers/auth_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late final TextEditingController emailCtrl;
  late final TextEditingController passCtrl;

  @override
  void initState() {
    super.initState();
    emailCtrl = TextEditingController();
    passCtrl = TextEditingController();
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AppTextField(
              controller: emailCtrl,
              label: "Email",
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: passCtrl,
              label: "Password",
              obscureText: true,
            ),
            const SizedBox(height: 20),
            AppButton(
              label: "Login",
              loading: auth.loading,
              expanded: true,
              onPressed: () {
                // capture current context
                final navigator = Navigator.of(context);

                authNotifier.login(emailCtrl.text, passCtrl.text).then((_) {
                  final user = ref.read(authProvider).user;
                  if (user != null) {
                    navigator.pushNamedAndRemoveUntil("/", (route) => false);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
