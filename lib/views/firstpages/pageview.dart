import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/Models/OnBoardingModel.dart';
import 'package:flutter_application_test/views/firstpages/welcome.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import '../../core/constants/colors.dart';

class OnBoarding extends StatefulWidget {
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late int selectedPage;
  final PageController _pageController = PageController(initialPage: 0);
  int currentIn = 0;
  final pageindexnotifire = ValueNotifier<int>(0);
  List<OnBoardingModel> myData = [
    OnBoardingModel(
        bg: "asset/images/bg1.png",
        image: "asset/images/pic1.png",
        description: "World of best books and articles"),
    OnBoardingModel(
        bg: "asset/images/bg1.png",
        image: "asset/images/pic2.png",
        description: "Download and enjoy \nonline reading."),
    OnBoardingModel(
        bg: "asset/images/bg1.png",
        image: "asset/images/pic3.png",
        description:
            "Share your favourite quotes \nand exchange the benefits \nwith others")
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: const Alignment(0, 0.7),
          children: [
            Builder(
              builder: (ctx) => PageView.builder(
                controller: _pageController,
                itemBuilder: (context, int i) => Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: ExactAssetImage(myData[i].bg),
                          fit: BoxFit.cover)),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 220),
                        child: Center(
                          child: Image.asset(
                            myData[i].image,
                            scale: 1.8,
                          ),
                        ),
                      ),
                      currentIn < 2
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  top: 120, left: 20, right: 20),
                              child: Center(
                                child: Text(
                                  myData[i].description,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: 25,
                                    color: dark_Brown,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 120),
                              child: Center(
                                child: Text(
                                  myData[i].description,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: 25,
                                    color: dark_Brown,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            )
                    ],
                  ),
                ),
                onPageChanged: (val) {
                  pageindexnotifire.value = val;
                  setState(() {
                    currentIn = val;
                  });
                },
              ),
            ),
            PageViewDotIndicator(
              size: const Size(25, 6),
              currentItem: pageindexnotifire.value,
              count: myData.length,
              unselectedColor: black,
              selectedColor: medium_Brown,
              duration: const Duration(milliseconds: 100),
              boxShape: BoxShape.rectangle,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 650, left: 300),
              child: TextButton(
                onPressed: () {
                  if (currentIn < 2)
                    currentIn++;
                  else {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => welcome()),
                    );
                  }
                  if (_pageController.hasClients) {
                    _pageController.animateToPage(currentIn,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeInOutCubicEmphasized);
                  }
                },
                style: TextButton.styleFrom(
                  foregroundColor: medium_Brown,
                  backgroundColor: no_color,
                ),
                child: const Icon(
                  Icons.arrow_forward_outlined,
                  size: 45,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 780, left: 300),
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => welcome()),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: dark_Brown,
                    backgroundColor: no_color,
                  ),
                  child: currentIn == 0
                      ? const Text(
                          "Skip",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w400),
                        )
                      : Container()),
            )
          ],
        ),
      ),
    );
  }
}
