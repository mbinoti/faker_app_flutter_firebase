import 'package:faker_app_flutter_firebase/routing/app_router.dart';
import 'package:faker_app_flutter_firebase/screens/ui_auth_provider.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomSignInScreen extends ConsumerWidget {
  const CustomSignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProviders = ref.watch(authProvidersProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in')),
      body: SignInScreen(
        providers: authProviders,
      ),
    );
  }
}
