import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task/cubit/login/cubit.dart';
import 'package:task/cubit/login/states.dart';
import 'package:task/remote_network/cach_helper.dart';
import 'package:task/shared/constant.dart';
import 'package:task/view/home.dart';

import 'get_semster_death_chart.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  static const String loginId = "login";
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) async {
          if (state is LoginSuccessState) {


            if (state.loginModel.msg == 'success') {
              // ignore: avoid_print
               await CacheHelper.saveData(key: 'token', value: "${state.loginModel.token}")
                   .then((value) {

                 print(state.loginModel.token);
                 print(state.loginModel.msg);
                 print(CacheHelper.getData('token'));

                 navigateTo(context, const BarChartAPI());
               });


            } else {
              print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text(
                        'Login as a Rider',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: "Brand-Bold",
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 1.0,
                            ),
                            TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                  fontSize: 14.0,
                                ),
                                helperStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10.0,
                                ),
                              ),
                              style: TextStyle(fontSize: 14.0),
                            ),
                            const SizedBox(
                              height: 1.0,
                            ),
                            TextField(
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                  fontSize: 14.0,
                                ),
                                helperStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10.0,
                                ),
                              ),
                              style: const TextStyle(fontSize: 14.0),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            state is LoginLoadingState
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : ElevatedButton(
                                    onPressed: () {
                                      if (!emailController.text.contains('@')) {
                                        Fluttertoast.showToast(
                                            msg: "Email address is not valid. ",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      } else if (passwordController
                                          .text.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: "Password is not empty. ",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }

                                      LoginCubit.get(context).userLogin(

                                          email: emailController.text,
                                          password: passwordController.text);
                                      print(
                                          '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
                                    },
                                    child: Container(
                                      height: 50.0,
                                      child: const Center(
                                          child: Text(
                                        'Login',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: 'Brand-Bold',
                                        ),
                                      )),
                                    ),
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Do not have an Account?'),
                                TextButton(
                                    onPressed: () {
                                      // Navigator.pushNamed(context, RegisterScreen.registerId);
                                      // Navigator.pushNamedAndRemoveUntil(context, RegisterScreen.registerId,(route) =>false );
                                    },
                                    child: const Text('Register Here'))
                              ],
                            ),
                            // FlatButton(onPressed: () {
                            //   Navigator.pushNamed(context, RegisterScreen.registerId);
                            // }, child:const Text('Do not have an Account? Register Here.',),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget progressDialog(String massage) => Dialog(
        backgroundColor: Colors.yellow,
        child: Container(
          margin: const EdgeInsets.all(15.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                const SizedBox(
                  width: 6.0,
                ),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
                const SizedBox(
                  width: 26.0,
                ),
                Text(
                  massage,
                ),
              ],
            ),
          ),
        ),
      );
}
