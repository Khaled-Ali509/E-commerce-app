import 'package:shop_appl/models/favorite_model.dart';
import 'package:shop_appl/models/login_model.dart';
import '../../models/incart_model.dart';


//main state for the app

abstract class ShopAppStates{}
class ShopAppInitialState extends ShopAppStates{}

///***********************************************************************///
class ShopAppChangBottomNavState extends ShopAppStates{}


///*************** states for Home Data **********************************///
class ShopHomeDataLoadingState extends ShopAppStates{}
class ShopHomeDataSuccessState extends ShopAppStates{}
class ShopHomeDataErrorState extends ShopAppStates {}

///************************Logout State********************************///

class ShopHomeLogOutSuccessState extends ShopAppStates{}

///*************** states for User Data **********************************///
class ShopUserDataLoadingState extends ShopAppStates{}
class ShopUserDataSuccessState extends ShopAppStates{
 final LoginModel userModel;
  ShopUserDataSuccessState(this.userModel);
}
class ShopUserDataErrorState extends ShopAppStates {}


///*************** states for Categories Data *****************************///

class ShopAppCategoriesDataLoadingState extends ShopAppStates{}
class ShopAppCategoriesSuccessState extends ShopAppStates{}
class ShopAppCategoriesErrorState extends ShopAppStates{}

///*************** states for Favorite Data *****************************///

class ShopAppFavoriteDataLoadingState extends ShopAppStates{}
class ShopAppFavoriteSuccessState extends ShopAppStates{
 final FavoriteModel model;

  ShopAppFavoriteSuccessState(this.model);
}
class ShopAppFavoriteErrorState extends ShopAppStates{}

///*************** states for Chang Favorite  *************************///

class ShopAppChangFavoriteLoadingState extends ShopAppStates{}
class ShopAppChangFavoriteSuccessState extends ShopAppStates{}
class ShopAppChangFavoriteErrorState extends ShopAppStates{}


///*************** states for In Cart Data *****************************///

class ShopAppInCartDataLoadingState extends ShopAppStates{}
class ShopAppInCartSuccessState extends ShopAppStates{
 final InCartModel model;

 ShopAppInCartSuccessState(this.model);
}
class ShopAppInCartErrorState extends ShopAppStates{}

///*************** states for Chang Cart  *************************///

class ShopAppChangInCartLoadingState extends ShopAppStates{}
class ShopAppChangInCartSuccessState extends ShopAppStates{}
class ShopAppChangInCartErrorState extends ShopAppStates{}


///*************** states for UpDate Data *****************************///

class ShopAppUpDateUserDataLoadingState extends ShopAppStates{}
class ShopAppUpDateUserDataSuccessState extends ShopAppStates{
 final LoginModel updateData;

 ShopAppUpDateUserDataSuccessState(this.updateData);
}
class ShopAppUpDateUserDataErrorState extends ShopAppStates{
 final String error;
 ShopAppUpDateUserDataErrorState(this.error);
}

///*************** states for User Login Data *****************************///

abstract class ShopAppLoginStates{}
class ShopAppLoginInitialState extends ShopAppLoginStates{}

class ShopAppChangPasswordVisibilityState extends ShopAppLoginStates{}

class ShopAppLoginLoadingState extends ShopAppLoginStates{}
class ShopAppLoginSuccessState extends ShopAppLoginStates{
 final LoginModel loginModel;
 ShopAppLoginSuccessState(this.loginModel);
}
class ShopAppLoginErrorState extends ShopAppLoginStates{
 final String error;
  ShopAppLoginErrorState(this.error);
}




///*************** states for User Register Data ***************************///

abstract class ShopAppRegisterStates{}
class ShopAppRegisterInitialState extends ShopAppRegisterStates{}
class ShopAppRegisterLoadingState extends ShopAppRegisterStates{}
class ShopAppRegisterSuccessState extends ShopAppRegisterStates{
 final LoginModel registerModel;
 ShopAppRegisterSuccessState(this.registerModel);
}
class ShopAppRegisterErrorState extends ShopAppRegisterStates{
 final String error;
 ShopAppRegisterErrorState(this.error);
}

class RegisterChangPasswordVisibilityState extends ShopAppRegisterStates{}




///*************** states for Search Data ***************************///

abstract class ShopAppSearchStates{}
class ShopAppSearchInitialState extends ShopAppSearchStates{}
class ShopAppSearchLoadingState extends ShopAppSearchStates{}
class ShopAppSearchSuccessState extends ShopAppSearchStates{}
class ShopAppSearchErrorState extends ShopAppSearchStates{
}





