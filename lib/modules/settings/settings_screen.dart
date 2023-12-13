import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../shared/componants/componants.dart';

class SettingsScreen extends StatelessWidget {
   SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener: (context, state) {
          if(state is ShopAppUpDateUserDataSuccessState)
            {
              ShopAppCubit.get(context).getUserData();
            }

        },
        builder: (context, state) {
          var cubit = ShopAppCubit.get(context);
          var model = cubit.userModel;

          nameController.text=model!.data!.name!;
          phoneController.text=model.data!.phone!;
          emailController.text=model.data!.email!;

          return Scaffold(
            appBar: AppBar(),
            body:  Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        if (state is ShopAppUpDateUserDataLoadingState)
                          LinearProgressIndicator(),
                          const SizedBox(height: 30.0,),
                        DefultFormField(
                            controller: nameController,
                            label: 'Name',
                            prefix: Icons.person,
                            type: TextInputType.name,
                            validate: (String? value){
                              if (value==null || value.trim().isEmpty){
                                return 'Name can\'t be empty';
                              }
                              return null;
                            }
                        ) ,
                        const SizedBox(height: 20.0,),
                        DefultFormField(
                            controller: emailController,
                            label: 'Email Address',
                            prefix: Icons.email,
                            type: TextInputType.emailAddress,
                            validate: (String? value){
                              if (value==null || value.trim().isEmpty){
                                return 'Email Address can\'t be empty';
                              }
                              return null;
                            }
                        ) ,
                        const SizedBox(height: 20.0,),
                        DefultFormField(
                            controller: phoneController,
                            label: 'Phone',
                            prefix: Icons.phone,
                            type: TextInputType.number,
                            validate: (String? value){
                              if (value==null || value.trim().isEmpty){
                                return 'Phone can\'t be empty';
                              }
                              return null;
                            }
                        ) ,
                        const SizedBox(height: 20.0,),
                        defultButton(
                              function: (){
                                if(formKey.currentState!.validate()){
                                  cubit.upDateUserData(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              text: 'update'
                        ),
                        const SizedBox(height: 20.0,),
                        defultButton(
                          function: ()
                          {
                            cubit.signOut(context);
                          },
                          text: 'Logout',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );

        }
    );
  }

  final formKey =GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
}