import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/core/utils/firebase_option.dart';
import 'package:firebase_demo/core/view_models/signup_view_model.dart';
import 'package:firebase_demo/ui/views/sign_up_screen.dart';
import 'package:firebase_demo/ui/views/update_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_)=> SignUpViewModel())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SignUpScreen(),
      ),
    );
  }
}
