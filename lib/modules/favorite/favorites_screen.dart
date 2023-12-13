
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_appl/models/favorite_model.dart';
import 'package:shop_appl/modules/shared/componants/componants.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../shared/constants/costants.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
      listener: (context, state){

      },
      builder: (context,state){
        var favorite=ShopAppCubit.get(context).favoriteModel?.data;
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: ConditionalBuilder(
            condition:favorite !=null && state is! ShopAppFavoriteDataLoadingState,
            builder: (BuildContext context)=>ListView.separated(
              itemBuilder:(context,index)=>productItem(favorite.data[index], context),
              separatorBuilder: (BuildContext context, int index)=>myDivider(),
              itemCount:favorite!.data.length,
            ),
            fallback: (context)=>const Center(child: CircularProgressIndicator()),
          ),
        );
      } ,
    );
  }



  Widget productItem(FavoriteData model , context)
  {
    return Container(
        padding: EdgeInsets.all(5.0),
        height: 200.0,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                Stack(
                alignment: AlignmentDirectional.bottomStart,
                children:[
                  Image(
                    image:NetworkImage('${model.product?.image}'),
                    width: 200.0,
                    height: 200.0,
                  ),
                  if (model.product?.discount!=0)
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
             Expanded(
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.product?.name}',
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        height: 1.0,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.product?.price}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            height: 1.3,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(width: 5.0,),
                        if(model.product?.discount!=0)
                          Text(
                            '${model.product?.oldPrice}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough
                            ),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed:(){
                            ShopAppCubit.get(context).changFavorite(model.product?.id);
                          },
                          icon: CircleAvatar(
                            radius: 15.0,
                            backgroundColor:ShopAppCubit.get(context).favorite[model.product?.id]==true?defultColore :Colors.grey,
                            child: const Icon(
                              Icons.favorite_border,
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
}
