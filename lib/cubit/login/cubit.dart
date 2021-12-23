import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/cubit/login/states.dart';
import 'package:task/model/login.dart';
import 'package:task/remote_network/cach_helper.dart';
import 'package:task/remote_network/dio_helper.dart';
import 'package:task/remote_network/end_point.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit( ) : super(LoginInitialState());

  static LoginCubit get(context)=>BlocProvider.of(context);
  LoginModel? loginModel;
  void userLogin({
    required String email,
    required String password,

  }){
    emit(LoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
      //  token: token,
        data:{
          'email':email,
          'password':password,
        }
        ,).then((value){
      loginModel =LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel!));
      print('^^^^^^^^^^^^^^^^^^^^^^^^^^ ');



    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState());
    });

  }

  bool showPassword = false;
  IconData suffixIcon = Icons.visibility;
  void changeSuffixIcon(context){
    showPassword =! showPassword;
    if(showPassword) {
      suffixIcon = Icons.visibility_off;
    } else {
      suffixIcon = Icons.visibility;
    }
    emit(ChangeSuffixIconState());
  }

}