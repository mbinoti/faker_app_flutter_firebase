import 'package:faker_app_flutter_firebase/routing/go_router_refresh_stream.dart';
import 'package:faker_app_flutter_firebase/screens/custom_profile_screen.dart';
import 'package:faker_app_flutter_firebase/screens/custom_sign_in_screen.dart';
import 'package:faker_app_flutter_firebase/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  signIn,
  home,
  profile,
}

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final goRouterProvider = Provider<GoRouter>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return GoRouter(
    initialLocation: '/sign-in',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = FirebaseAuth.instance.currentUser != null;
      if (isLoggedIn) {
        if (state.location == '/sign-in') {
          return '/home';
        }
      } else {
        if (state.location == '/profile') {
          return '/sign-in';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(
      FirebaseAuth.instance.authStateChanges(),
    ),
    routes: [
      GoRoute(
        path: '/sign-in',
        name: AppRoute.signIn.name,
        builder: (context, state) => const CustomSignInScreen(),
      ),
      GoRoute(
        path: '/home',
        name: AppRoute.home.name,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'profile',
            name: AppRoute.profile.name,
            builder: (context, state) => const CustomProfileScreen(),
          ),
        ],
      ),
    ],
  );
});
