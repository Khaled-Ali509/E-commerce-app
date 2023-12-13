import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_appl/models/search_model.dart';
import 'package:shop_appl/modules/cubit/states.dart';
import 'package:shop_appl/modules/network/local/dio_helper.dart';
import 'package:shop_appl/modules/shared/constants/costants.dart';

import '../network/remote/end_point.dart';

class ShopAppSearchCubit extends Cubit<ShopAppSearchStates> {
  ShopAppSearchCubit() : super(ShopAppSearchInitialState());

  static ShopAppSearchCubit get(context) => BlocProvider.of(context);



  void searchProduct(String text)
  {
    emit(ShopAppSearchLoadingState());
    DioHelper.postData(
        url: Search,
        data:
        {
          'text':text,
        },
      token: token,
    ).then((value){

      searchModel=SearchModel.fromJson(value.data);
      emit(ShopAppSearchSuccessState());
    }).catchError((error)
    {
      emit(ShopAppSearchErrorState());
      print(error.toString());
    });
  }

 late SearchModel searchModel;
}