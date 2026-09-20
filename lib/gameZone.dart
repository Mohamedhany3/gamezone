import 'package:flutter/material.dart';
import 'package:gamezone/core/routes/app_router.dart';
import 'package:gamezone/core/routes/app_routes.dart';

class Gamezone extends StatelessWidget {
  const Gamezone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.register,
      onGenerateRoute: AppRouter.onGenerateRoutes,
    );
  }
}
