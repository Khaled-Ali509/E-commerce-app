import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_appl/modules/login/login_screen.dart';
import '../cubit/rigester_cubit.dart';
import '../cubit/states.dart';
import '../shared/componants/componants.dart';

class RegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopAppRegisterCubit(),
      child: BlocConsumer<ShopAppRegisterCubit,ShopAppRegisterStates>(
        listener: (context , state){
          if(state is ShopAppRegisterSuccessState) {
            if (state.registerModel.status ==true) {
              showToast(
                  msg: state.registerModel.message,
                  state: ToastState.success
              );
                navigateFinish(context, LoginScreen());
            }
            else if (state.registerModel.status ==false)  {
              showToast(
                  msg: state.registerModel.message,
                  state: ToastState.error);
            }
          }
        },
        builder: (context , state){
          var cubit = ShopAppRegisterCubit.get(context);
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

                        Text(
                          'Register',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith( color:Colors.black,),
                        ),
                        const SizedBox(height: 20.0,),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith( color:Colors.grey,),
                        ),
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
                        DefultFormField(
                          controller: passwordController,
                          label: 'Password',
                          prefix: Icons.lock,
                          suffix: cubit.suffix,

                          isPassword:cubit.isPassword,
                          suffixPressed: (){
                            cubit.changPasswordVisibility();
                          },
                          type: TextInputType.visiblePassword,
                          onSupmit: (value)
                          {
                            if(formKey.currentState!.validate()){
                              cubit.userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          validate:(String? value){
                            if (value==null || value.trim().isEmpty){
                              return 'Password can\'t be empty';
                            }
                            return null;
                          },

                        ) ,
                        const SizedBox(height: 20.0,),
                        ConditionalBuilder(
                          condition: state is! ShopAppRegisterLoadingState,
                          builder:(context)=>defultButton(
                              function: (){
                                if(formKey.currentState!.validate()){
                                  cubit.userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              text: 'Register'),
                          fallback: (context)=>const Center(child: CircularProgressIndicator()),
                        ) ,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }

  final formKey =GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();

}
