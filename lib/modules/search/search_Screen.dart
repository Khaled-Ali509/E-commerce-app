import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_appl/modules/cubit/states.dart';
import 'package:shop_appl/modules/shared/componants/componants.dart';

import '../../models/search_model.dart';
import '../cubit/search_cubit.dart';

class Search_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context)=>ShopAppSearchCubit(),
        child: BlocConsumer<ShopAppSearchCubit,ShopAppSearchStates>(
        listener: (context , state){},
          builder: ( context, state) {
            var cubit = ShopAppSearchCubit.get(context);
            return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    DefultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        label: 'search',
                        prefix: Icons.search,
                      onSupmit: (String text)
                      {
                        if(formKey.currentState!.validate()) {
                          cubit.searchProduct(text);
                        }
                      },
                      validate: (String value)
                      {
                        if(value.isEmpty ) {
                          return 'Enter text to search';
                        }
                      }
                    ),
                    const SizedBox(height: 10.0,),
                    if (state is ShopAppSearchLoadingState)
                      LinearProgressIndicator(),
                    if (state is ShopAppSearchSuccessState && cubit.searchModel.data !=null)
                      Expanded(
                        child: ListView.separated(
                        itemBuilder:(context,index)=>productItem(cubit.searchModel.data?.data[index], context),
                        separatorBuilder: (BuildContext context, int index)=>myDivider(),
                        itemCount:cubit.searchModel.data!.data.length ,
                    ),
                      ),
                  ],
                ),
              ),
            ),
          );
          },
        )
    );
  }
  Widget productItem( model , context)
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
                  image:NetworkImage('${model.image}'),
                  width: 200.0,
                  height: 200.0,
                ),
              ]
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
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
                      '${model.price}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        height: 1.3,
                        color: Colors.blue,
                      ),
                    ),
                    Spacer(),
                    Icon(
                          Icons.favorite_border,
                          size: 14.0,
                          color: model.inFavorites ? Colors.red : Colors.grey,
                        ),
                    Spacer(),
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 14.0,
                      color: model.inCart ? Colors.blue : Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),


    );
  }
  var formKey=GlobalKey<FormState>();
  var searchController = TextEditingController();
}
