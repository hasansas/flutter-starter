import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/network/api_client_provider.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // Create Riverpod container manually
  final container = ProviderContainer();

  // Preload API client
  await container.read(apiClientProvider.future);

  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}
