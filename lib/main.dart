import 'package:flutter/material.dart';
import 'package:gamezone/gameZone.dart';

import 'core/di/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupGetIt();

  runApp(Gamezone());
}
