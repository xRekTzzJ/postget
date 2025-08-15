import 'package:go_router/go_router.dart';
import 'package:mobile/screens/login/login.dart';

final router = GoRouter(
  initialLocation: '/login',
  routes: [GoRoute(path: '/login', builder: (context, state) => Login())],
);
