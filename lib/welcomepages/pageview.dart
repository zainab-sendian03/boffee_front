import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

class pageview extends StatefulWidget {
  const pageview({super.key});

  @override
  State<pageview> createState() => _pageviewState();
}

class _pageviewState extends State<pageview> {
  late int selectedPage;
  final PageController _pageController = PageController(initialPage: 0);
  int currentIn = 0;
  final pageindexnotifire = ValueNotifier<int>(0);
  final List<Data> myData = [
    Data("asset/images/pic1.png", "asset/images/bg1.png",
        description: "World of best books and articles"),
    Data("asset/images/pic2.png", "asset/images/bg1.png",
        description: "Download and enjoy \nonline reading."),
    Data("asset/images/pic3.png", "asset/images/bg1.png",
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
                builder: (ctx) => PageView(
                      controller: _pageController,
                      children: myData
                          .map((e) => Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: ExactAssetImage(e.bg),
                                        fit: BoxFit.cover)),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 220),
                                      child: Center(
                                        child: Image.asset(
                                          e.image,
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
                                                e.description,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontFamily: "OpenSans",
                                                  fontSize: 25,
                                                  color: Color(0xFF5D3F2E),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Padding(
                                            padding:
                                                const EdgeInsets.only(top: 120),
                                            child: Center(
                                              child: Text(
                                                e.description,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontFamily: "OpenSans",
                                                  fontSize: 25,
                                                  color: Color(0xFF5D3F2E),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          )
                                  ],
                                ),
                              ))
                          .toList(),
                      onPageChanged: (val) {
                        pageindexnotifire.value = val;
                        setState(() {
                          currentIn = val;
                        });
                      },
                    )),
            PageViewDotIndicator(
              size: const Size(25, 6),
              currentItem: pageindexnotifire.value,
              count: myData.length,
              unselectedColor: Colors.black26,
              selectedColor: const Color(0xFF94745B),
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
              padding: const EdgeInsets.only(top: 650, left: 330),
              child: TextButton(
                onPressed: () {
                  if (currentIn < 2)
                    currentIn++;
                  else {
                    Navigator.of(context).pushNamed("welcome");
                  }
                  if (_pageController.hasClients) {
                    _pageController.animateToPage(currentIn,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeInOutCubicEmphasized);
                  }
                },
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF94745B),
                  backgroundColor: Colors.transparent,
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
                    Navigator.of(context).pushNamed("welcome");
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF5D3F2E),
                    backgroundColor: Colors.transparent,
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

class Data {
  final String description;
  final String image;
  final String bg;

  Data(this.image, this.bg, {required this.description});
}
