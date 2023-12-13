import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_appl/modules/cubit/states.dart';

import '../../models/login_model.dart';
import '../network/local/dio_helper.dart';
import '../network/remote/end_point.dart';

class ShopAppRegisterCubit extends Cubit<ShopAppRegisterStates> {
  ShopAppRegisterCubit() : super(ShopAppRegisterInitialState());

  static ShopAppRegisterCubit get(context) => BlocProvider.of(context);

  late LoginModel loginModel;
  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,

  })
  {
    emit(ShopAppRegisterLoadingState());
    DioHelper.postData(
        url: Register,
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
        })
        .then((value){
      loginModel= LoginModel.fromJson(value.data);
      emit(ShopAppRegisterSuccessState(loginModel));
    }).catchError((error){
      emit(ShopAppRegisterErrorState(error.toString()));

      print(error.toString());
    });
  }


  void changPasswordVisibility()
  {
    isPassword =!isPassword;
    suffix = isPassword ? Icons.visibility_off :Icons.visibility_outlined;
    emit(RegisterChangPasswordVisibilityState());
  }
  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;
}

