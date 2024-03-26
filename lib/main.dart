import 'package:admin_panel/firebase_options.dart';
import 'package:admin_panel/screens/home_screen.dart';
import 'package:admin_panel/screens/login.dart';
import 'package:admin_panel/screens/root_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(home:HomeScreen()));
}
