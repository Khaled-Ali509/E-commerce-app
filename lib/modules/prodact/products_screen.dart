import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_appl/modules/shared/constants/costants.dart';
import '../../models/categories_model.dart';
import '../../models/home_model.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context, state){},
      builder: (context,state){
        var home= ShopAppCubit.get(context).homeModel;
        var categories=ShopAppCubit.get(context).categoriesModel;
        return ConditionalBuilder(
          condition:home!=null && categories!=null,
          builder:(context)=>productsBuilder(home!,categories!, context),
          fallback:(context)=>const Center(child: CircularProgressIndicator()),
        );
      } ,
    );
  }

  Widget productsBuilder(HomeModel model,CategoriesModel categoriesModel,context )=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: model.data!.banners.map((e) => Image(
            image: NetworkImage('${e.image}'),
            width: double.infinity,
            fit: BoxFit.fill,
          ),).toList(),
          options: CarouselOptions(
            height: 200.0,
            initialPage: 0,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayAnimationDuration:const Duration(seconds: 1),
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection:Axis.horizontal ,
          ),
        ),
        const SizedBox(height: 10.0,),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black
                ),
              ),
              const SizedBox(height: 10.0,),
              Container(
                height: .2,
                width: double.infinity,
                color: Colors.grey,
              ),
              Container(
                //color: Colors.,
                height: 125,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context , index)=>buildCategoryItem(categoriesModel,index,context ),
                  separatorBuilder:(context , index)=>const SizedBox(width: 5.0,),
                  itemCount: categoriesModel.data!.data.length,
                ),
              ),
              const SizedBox(height: 5.0,),
              const Text(
                'Products',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5.0,),
        Container(

          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount:2,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.9,
            childAspectRatio: 1/1.54,
            children:
            List.generate(
              model.data!.products.length,
                  (index)=>buildGridProducts( model.data!.products[index] , index,context),
            ),
          ),
        ),
        Container(
          height: .2,
          width: double.infinity,
          color: Colors.grey,
        ),

      ],
    ),
  );
  Widget buildCategoryItem(CategoriesModel categoriesModel,index,context )=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children:  [

      Image(
        image:NetworkImage(categoriesModel.data!.data[index].image),
        height: 125,
        width: 125,
        fit: BoxFit.fill,
      ),
      Container(
        color: Colors.black.withOpacity(.8,),
        width:125,
        child:  Text(
          categoriesModel.data!.data[index].name,
          textAlign:TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.white
          ),
        ),
      ),
    ],
  );
  Widget buildGridProducts(ProductModel model , index, context)=>Container(
    color:Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
            alignment: AlignmentDirectional.bottomStart,
            children:[
              Image(
                image:NetworkImage('${model.image}'),
                width: double.infinity,
                height: 200,
              ),
              if (model.discount!=0)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0,),
                  child:const Text(
                    'DISCOUNT',
                    style:TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,
                    ) ,
                  ),
                ),
            ]
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
              ),
              Row(
                children: [
                  Column(
                    children: [
                      if(model.discount!=0)
                        Text(
                          '${model.oldPrice}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough
                          ),
                        ),
                      Text(
                        '${model.price}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          height: 1.3,
                          color: Colors.blue,
                        ),
                      ),

                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed:(){
                      ShopAppCubit.get(context).changFavorite(model.id);
                    },
                    icon: CircleAvatar(
                      radius: 15.0,
                      backgroundColor:ShopAppCubit.get(context).favorite[model.id]==true?defultColore :Colors.grey,
                      child: const Icon(
                        Icons.favorite_border,
                        size: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed:(){
                      ShopAppCubit.get(context).changCart(model.id);
                    },
                    icon: CircleAvatar(
                      radius: 15.0,
                      backgroundColor:ShopAppCubit.get(context).inCart[model.id]==true?Colors.blue:Colors.grey,
                      child: const Icon(
                        Icons.shopping_cart_rounded,
                        size: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  )


                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );



}
