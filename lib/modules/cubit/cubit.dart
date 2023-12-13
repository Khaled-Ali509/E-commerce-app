
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_appl/models/chang_favorite.dart';
import 'package:shop_appl/models/favorite_model.dart';
import 'package:shop_appl/models/home_model.dart';
import 'package:shop_appl/models/login_model.dart';
import 'package:shop_appl/modules/cubit/states.dart';
import 'package:shop_appl/modules/network/local/dio_helper.dart';
import '../../models/categories_model.dart';
import '../../models/chang_incart.dart';
import '../../models/incart_model.dart';
import '../categories/categories_screen.dart';
import '../favorite/favorites_screen.dart';
import '../login/login_screen.dart';
import '../network/local/cach_helper.dart';
import '../network/remote/end_point.dart';
import '../prodact/products_screen.dart';
import '../settings/settings_screen.dart';
import '../shared/componants/componants.dart';
import '../shared/constants/costants.dart';



class ShopAppCubit extends Cubit<ShopAppStates> {
  ShopAppCubit() : super(ShopAppInitialState());

  static ShopAppCubit get(context) => BlocProvider.of(context);


  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopAppChangBottomNavState());
  }
  List<Widget> screens =
  [
     ProductsScreen(),
     CategoriesScreen(),
     FavoritesScreen(),
     SettingsScreen(),
  ];

 void getHomeData()
{
  emit(ShopHomeDataLoadingState());
  DioHelper.getData(
      url: home,
    token: token,
  ).then((value) {
    homeModel= HomeModel.fromJson(value.data);
    homeModel?.data?.products.forEach((element) {
      if (homeModel?.data!=null) {
        favorite.addAll({
          element.id: element.inFavorite,
        });
        inCart.addAll({
            element.id: element.inCart,
          });
        }
    });
      emit(ShopHomeDataSuccessState());
  }
  ).catchError((error)
  {
    print(error.toString());
   emit(ShopHomeDataErrorState());
  });
}

  void getUserData()
  {
    emit(ShopUserDataLoadingState());
    DioHelper.getData(
      url: Profile,
      token: token,
    ).then((value) {
      userModel= LoginModel.fromJson(value.data);
      emit(ShopUserDataSuccessState(userModel!));
    }
    ).catchError((error)
    {
      print(error.toString());
      emit(ShopUserDataErrorState());
    });
  }

  void getCategoriesData()
  {
    emit(ShopAppCategoriesDataLoadingState());
    DioHelper.getData(
      url: categories,
    ).then((value)
    {
      categoriesModel= CategoriesModel.fromJason(value.data);
      emit(ShopAppCategoriesSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopAppCategoriesErrorState());
    });
  }

  void getFavoriteData()
  {
    emit(ShopAppFavoriteDataLoadingState());
    DioHelper.getData(
      url:Favorites,
      token: token,
    ).then((value)
    {
      favoriteModel= FavoriteModel.fromJson(value.data);
      emit(ShopAppFavoriteSuccessState(favoriteModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopAppFavoriteErrorState());
    });
  }

void changFavorite(int? productId)
{

  favorite[productId!] = !favorite[productId]!;
 emit(ShopAppChangFavoriteLoadingState());
  DioHelper.postData(
      url: Favorites,
      data: {
        'product_id': productId
      },
     token: token,
  ).then((value)
  {
    changFavorites = ChangFavoriteModel.fromJson(value.data);
    if (changFavorites!.status==false){
      favorite[productId] = !favorite[productId]!;
    }else{
      getFavoriteData();
    }
    emit(ShopAppChangFavoriteSuccessState());

  }).catchError((error) {
    favorite[productId] = !favorite[productId]!;
    emit(ShopAppChangFavoriteErrorState());

  });
}


  void getCartData()
  {
    emit(ShopAppInCartDataLoadingState());
    DioHelper.getData(
      url:INCart,
      token: token,
    ).then((value)
    {
      inCartModel= InCartModel.fromJson(value.data);
      emit(ShopAppInCartSuccessState(inCartModel!));
    }).catchError((error){
      emit(ShopAppInCartErrorState());
      print(error.toString());
    });
  }

  void changCart(int? productId)
  {

    inCart[productId!] = !inCart[productId]!;
    emit(ShopAppChangInCartLoadingState());
    DioHelper.postData(
      url: INCart,
      data: {
        'product_id': productId
      },
      token: token,
    ).then((value)
    {
      changInCart = ChangInCartModel.fromJson(value.data);
      if (changInCart!.status==false){
        inCart[productId] = !inCart[productId]!;
      }else{
        getCartData();
      }
      emit(ShopAppChangInCartSuccessState());

    }).catchError((error) {
      inCart[productId] = !inCart[productId]!;
      emit(ShopAppChangInCartErrorState());

    });
  }

  void signOut(context){
    CacheHelper.removeData(
        key: 'token',
    ).then((value)
    {
      if(value)
      {
        navigateFinish(context, LoginScreen());
        currentIndex=0;
        emit(ShopHomeLogOutSuccessState());
      }
    });
  }


  void upDateUserData({
    required String name,
    required String email,
    required String phone,

  })
  {
    emit(ShopAppUpDateUserDataLoadingState());
    DioHelper.putData(
        url: updateProfile,
        token: token,
        data: {
          'name':name,
          'email':email,
          'phone':phone,
        })
        .then((value){
      upDateData= LoginModel.fromJson(value.data);
      emit(ShopAppUpDateUserDataSuccessState(upDateData!));
    }).catchError((error){
      emit(ShopAppUpDateUserDataErrorState(error.toString()));

      print(error.toString());
    });
  }


  int currentIndex = 0;
  CategoriesModel? categoriesModel;
   HomeModel? homeModel;
  LoginModel? userModel;
  LoginModel? upDateData;
  ChangFavoriteModel? changFavorites;
  FavoriteModel? favoriteModel;
  Map<int, bool> favorite={};
  ChangInCartModel? changInCart;
  InCartModel? inCartModel;
  Map<int, bool> inCart={};
}
