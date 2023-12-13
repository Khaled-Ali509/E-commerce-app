import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../login/login_screen.dart';
import '../network/local/cach_helper.dart';
import '../shared/componants/componants.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shopping',
        ),
        actions: [
          TextButton(
              onPressed:() {
                submit();
              },

              child:  Text('SkiP',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),)
        ],
      ),
      body:Padding(
        padding:  EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(

                onPageChanged: (int index){
                  if (index ==boarding.length-1)
                    {
                      setState(() {
                        isLast =true;
                      });
                    }
                  else {
                    setState(() {
                      isLast=false;
                    });
                  }
                },
                physics: const BouncingScrollPhysics(),
                controller: boarderController,
                itemBuilder: (context, index)=>buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(height: 40.0,),
            Row(
              children: [
                  SmoothPageIndicator(

                   controller: boarderController,
                   count: boarding.length,
                   effect: const ExpandingDotsEffect(
                     activeDotColor: Colors.deepOrange,
                      dotColor: Colors.deepOrange,
                      dotHeight:10.0 ,
                     dotWidth:10.0 ,
                     expansionFactor: 3,
                     spacing: 5.0,
                   ),

                    ),
                const Spacer(),
                FloatingActionButton(
                    onPressed:(){
                      if (isLast){
                        submit();
                      }else if( isNotFirst)
                      {
                      }
                      else{
                        boarderController.nextPage(
                            duration:const Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);

                      }
                      },
                  child: const Icon(Icons.arrow_forward_ios),

                ),
              ],
            )
          ],
        ),
      ) ,
    );
  }

  Widget buildBoardingItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image:AssetImage(model.image),
          fit: BoxFit.contain,
        ),
      ),
      const SizedBox(height: 30.0,),
      Text(
        model.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
        ),
      ),
      const SizedBox(height: 15.0,),
      Text(
        model.body,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
        ),
      )

    ],
  );

  void submit(){
    CacheHelper.saveData(
        key: 'onBoarding',
        value: true
        ).then((value) {
          if (value)
            {
              navigateFinish(context,
                  LoginScreen()
              );
            }
    });
  }
 var boarderController = PageController();
 bool isLast = false;
 bool isNotFirst =false ;
  List <BoardingModel> boarding=[
    BoardingModel(
        image: 'assets/images/img.jpeg',
        title: 'Screen Title On Board0 ',
        body: 'Screen Body On Board0 '),
    BoardingModel(
        image: 'assets/images/1.jpeg',
        title: 'Screen Title On Board1 ',
        body: 'Screen Body On Board1'),
    BoardingModel(
        image: 'assets/images/2.jpeg',
        title: 'Screen Title On Board2 ',
        body: 'Screen Body On Board2'),
    BoardingModel(
        image: 'assets/images/3.jpeg',
        title: 'Screen Title On Board3 ',
        body: 'Screen Body On Board3'),
  ];
}
class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body
});
}