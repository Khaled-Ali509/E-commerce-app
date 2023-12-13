import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constants/costants.dart';

Widget defultButton({
  double width= double.infinity ,
  Color background = defultColore,
  required Function function,
  required String text,

}) =>Container(
  width: width ,
  color: background,
  height: 50.0,
  child: MaterialButton(onPressed:()=> function(),
    child: Text(text.toUpperCase(),
      style: const TextStyle(
        color: Colors.white,
      ),

    ),

  ),
);


Widget DefultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSupmit,
  bool isPassword = false,
  Function? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
}) =>
    TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,

        /* validator:(String? value){
                         if (value==null || value.trim().isEmpty){
                           return 'Password can\'t be empty';
                         }
                         return null;
                       },*/
        onFieldSubmitted: (s) {
          onSupmit!(s);
        },
        validator: (value) {
          return validate!(value);
        },
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: suffix != null ? IconButton(onPressed: () {suffixPressed!();}, icon: Icon(suffix,),) : null,
          prefixIcon: Icon(prefix),
          border: OutlineInputBorder(),
        ));
Widget defultTextButton({
  required Function function,
  required String text,
})=>TextButton(
    onPressed:(){
      function();
      } ,
    child: Text(text.toUpperCase()) ,
);

 void navigateTo(context , widget)=>Navigator.push(context, MaterialPageRoute(
  builder: (context)=>widget,),);


void navigateFinish(context , widget)=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context)=>widget,
    ),
      (route) => false);


void showToast({
  required String msg,
  required ToastState state,
})=>Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);



enum ToastState{ success , error , warning}
Color chooseColor(ToastState state){
  Color color;
  switch(state)
  {
    case ToastState.success:
      color= Colors.green;
      break;
    case ToastState.error:
      color= Colors.red;
      break;
    case ToastState.warning:
      color= Colors.amber;
      break;
  }
  return color;
}

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 10.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);
