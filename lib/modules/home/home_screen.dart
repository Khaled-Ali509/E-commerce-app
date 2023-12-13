import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_appl/modules/cart/cart_screen.dart';
import 'package:shop_appl/modules/search/search_Screen.dart';
import 'package:shop_appl/modules/shared/componants/componants.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var home = ShopAppCubit.get(context);
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context, state){},
      builder: (context,state)
      {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'My Shopping',
            ),
            actions: [
              IconButton(
                  onPressed:()
                  {
                    navigateTo(context, Search_Screen());
                  }, icon:const Icon(Icons.search)
              ),
              IconButton(
                  onPressed:()
                  {
                    navigateTo(context, const Cart_Screen());
                  }, icon:const Icon(Icons.shopping_cart_outlined)
              )
            ],
          ),
          body:home.screens[home.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: home.currentIndex,
            onTap: (index){
              home.changeBottom(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon:Icon( Icons.home_outlined),
                label: 'Home',
              ),

              BottomNavigationBarItem(
                icon:Icon( Icons.category),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon:Icon( Icons.favorite_border),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon:Icon( Icons.settings),
                label: 'Settings',
              ),

            ],
          ),
        );
      },
    );
  }
}
