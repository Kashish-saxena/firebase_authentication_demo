import 'package:firebase_demo/core/services/firebase_services.dart';
import 'package:firebase_demo/core/view_models/Sign_in_view_model.dart';
import 'package:firebase_demo/core/view_models/sign_up_view_model.dart';
import 'package:firebase_demo/core/view_models/update_view_model.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => FirebaseServices());
  locator.registerLazySingleton(() => SignUpViewModel());
  locator.registerLazySingleton(() => SignInViewModel());
  locator.registerLazySingleton(() => UpdateViewModel());
}
