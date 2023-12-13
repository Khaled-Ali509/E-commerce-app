import 'dart:io';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_appl/modules/cubit/cubit.dart';
import 'package:shop_appl/modules/home/home_screen.dart';
import 'package:shop_appl/modules/network/local/cach_helper.dart';
import 'package:shop_appl/modules/network/local/dio_helper.dart';
import 'package:shop_appl/modules/shared/constants/costants.dart';
import 'modules/boarding/on_boarding_screen.dart';
import 'modules/cubit/states.dart';
import 'modules/login/login_screen.dart';
import 'modules/network/local/bloc_0bserver.dart';
import 'modules/styles/theme_Style.dart';

Future<void> main()  async{
  WidgetsFlutterBinding.ensureInitialized();

  if(Platform.isMacOS ||Platform.isWindows) {
    await DesktopWindow.setMinWindowSize(
        const Size(
            400.0,
            650.0
        )
    );
  }
  Bloc.observer = MyBlocObserver();
   DioHelper.init();
   await CacheHelper.init();
   Widget widget;
   bool onBoarding;
   token = CacheHelper.getData(key: 'token');
   print(token);
  CacheHelper.getData(key: 'onBoarding') == null?
  onBoarding= false : onBoarding = CacheHelper.getData(key: 'onBoarding');

  if (onBoarding)
    {
      if (token !=null)
      {
        widget = HomeScreen();
      }else
        widget = LoginScreen();
    }else
      widget= OnBoardingScreen();

  runApp( MyApp(widget));
}




class MyApp extends StatelessWidget {
    final Widget startWidget;
     MyApp(this.startWidget);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(BuildContext context)=>ShopAppCubit()
        ..getHomeData()..getCategoriesData()
        ..getFavoriteData()..getUserData()..getCartData(),

      child: BlocConsumer<ShopAppCubit,ShopAppStates>(
        listener: ( context, state) {  },
        builder: (context, state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            home: startWidget,
          );
        }
      ),
    );
  }
}