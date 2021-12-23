import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:task/remote_network/cach_helper.dart';
import 'package:task/remote_network/dio_helper.dart';
import 'package:task/shared/bloc_observer.dart';
import 'package:task/view/login.dart';

import 'shared/constant.dart';

Future<void> main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  token=CacheHelper.getData('token');

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(

      ),
       home: LoginScreen(),
    );
  }
}

