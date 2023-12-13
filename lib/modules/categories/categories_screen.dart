import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/categories_model.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../shared/componants/componants.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit,ShopAppStates>(
        listener: (context, state){},
        builder: (context,state){
          var categories=ShopAppCubit.get(context).categoriesModel;
          return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context,index)=>buildCategoriesItem(categories!,index),
              separatorBuilder: (context,index)=>myDivider(),
              itemCount: categories!.data!.data.length);
        }
    );
  }
  Widget buildCategoriesItem(CategoriesModel model,index)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image:NetworkImage(model.data!.data[index].image),
          width: 100,
          height: 100,
          fit: BoxFit.fill,
        ),
        SizedBox(width: 20.0,),
        Text(
          model.data!.data[index].name,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(
          Icons.arrow_forward_ios,
        ),
      ],
    ),
  );
}
