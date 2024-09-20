import 'package:flutter/material.dart';
import 'package:shop/app/app.dart';
import 'package:shop/app/initials/initial_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitialBindings().initInitials();

  runApp(const App());
}
