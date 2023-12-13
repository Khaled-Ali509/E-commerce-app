
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_appl/modules/cubit/states.dart';
import 'package:shop_appl/modules/network/local/dio_helper.dart';
import '../../models/login_model.dart';
import '../network/remote/end_point.dart';



class ShopAppLoginCubit extends Cubit<ShopAppLoginStates> {
  ShopAppLoginCubit() : super(ShopAppLoginInitialState());
  static ShopAppLoginCubit get(context) => BlocProvider.of(context);

  late LoginModel userModel;
  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(ShopAppLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password,
        })
        .then((value){
      userModel= LoginModel.fromJson(value.data);
      emit(ShopAppLoginSuccessState(userModel));
    }).catchError((error){
      emit(ShopAppLoginErrorState(error.toString()));

      print(error.toString());
    });
  }

  void changPasswordVisibility()
  {
    isPassword =!isPassword;
    suffix = isPassword ? Icons.visibility_off :Icons.visibility_outlined;
    emit(ShopAppChangPasswordVisibilityState());
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

}
