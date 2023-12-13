import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_appl/modules/network/local/cach_helper.dart';
import '../cubit/login_cubit.dart';
import '../cubit/states.dart';
import '../home/home_screen.dart';
import '../register/register_screen.dart';
import '../shared/componants/componants.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
    create: (BuildContext context)=>ShopAppLoginCubit(),
      child: BlocConsumer<ShopAppLoginCubit,ShopAppLoginStates>(
        listener: (context , state){
          if(state is ShopAppLoginSuccessState) {
            if (state.loginModel.status==true) {
              showToast(
                  msg: state.loginModel.message,
                  state: ToastState.success
              );
               CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel.data?.token,
              ).then((value){

                  navigateFinish(context, HomeScreen());
              });
            }
            else {
              showToast(msg: state.loginModel.message,
                  state: ToastState.error);
            }
          }
        },
        builder: (context , state){
          var cubit = ShopAppLoginCubit.get(context);
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
                          'LOGIN',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith( color:Colors.black,),
                        ),
                        const SizedBox(height: 20.0,),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith( color:Colors.grey,),
                        ),
                        const SizedBox(height: 30.0,),
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
                              cubit.userLogin(
                                email: emailController.text,
                                password: passwordController.text,
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
                          condition: state is! ShopAppLoginLoadingState,
                          builder:(context)=>defultButton(
                              function: (){
                                if(formKey.currentState!.validate()){
                                  cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                  );
                                }
                              },
                              text: 'login'),
                          fallback: (context)=>const Center(child: CircularProgressIndicator()),
                        ) ,
                        const SizedBox(height: 20.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text('Don\'t have an account?'),

                            defultTextButton(
                                function: (){
                                  navigateTo(
                                    context,
                                    RegisterScreen(),
                                  );
                                },
                                text: 'Register Now'
                            ),
                          ],
                        ),
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



}