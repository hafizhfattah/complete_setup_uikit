// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:opening_screen/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'home_page.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController();

  bool onLastPage = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5))
        .then((value) => {FlutterNativeSplash.remove()});
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          bottom: 80.0,
        ),
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: [
            buildPage(
                color: Colors.white,
                urlImage:
                    'https://cdn.dribbble.com/users/1350460/screenshots/9707394/studu1_4x.jpg',
                title: 'Work From Anywhere',
                desc:
                    'Ullamco eiusmod aute duis voluptate do enim nisi reprehenderit.'),
            buildPage(
                color: Colors.white,
                urlImage:
                    'https://cdn.dribbble.com/users/508588/screenshots/15599820/tdv_m236_04_4x.jpg',
                title: 'Enjoy & Simple To Use',
                desc:
                    'Ullamco eiusmod aute duis voluptate do enim nisi reprehenderit.'),
            buildPage(
                color: Colors.white,
                urlImage:
                    'https://cdni.iconscout.com/illustration/premium/thumb/boy-studying-at-home-5204466-4353658.png',
                title: 'Focus When Study',
                desc:
                    'Ullamco eiusmod aute duis voluptate do enim nisi reprehenderit.'),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
                onPressed: () {
                  _pageController.jumpToPage(2);
                },
                child: Text('Skip', textAlign: TextAlign.center, style: font)),
            SmoothPageIndicator(
              effect: const WormEffect(),
              onDotClicked: (index) => _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
              ),
              controller: _pageController,
              count: 3,
            ),
            onLastPage
                ? TextButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool('showHome', true);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    },
                    child:
                        Text('Done', textAlign: TextAlign.center, style: font))
                : TextButton(
                    onPressed: () {
                      _pageController.nextPage(
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeIn);
                    },
                    child:
                        Text('Next', textAlign: TextAlign.center, style: font),
                  )
          ],
        ),
      ),
    );
  }
}
