import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:gamezone/core/routes/app_routes.dart';
import 'package:gamezone/feature/register/presentation/cubit/register_cubit.dart';
import 'package:gamezone/feature/register/presentation/ui/register_screen.dart';

import '../di/service_locator.dart';

class AppRouter {
  static Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => RegisterCubit(getIt()),
            child: RegisterScreen(),
          ),
        );
    }
  }
}
