import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pas_app/GetStarted/OnBoardingFinal.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => OnBoardingFinal()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w700,
          color: Color.fromARGB(255, 0, 123, 245)),
      bodyTextStyle: TextStyle(fontSize: 18, color: Colors.black),
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
          title: "Find Your Job Now!",
          body:
              "It's easier to find work without leaving the house, just chat with the company you choose and send your CV and data about you to the company you choose!",
          image: Image.asset(
            'Asset/Image/OnBoarding/LogoOB2.png',
            height: 230,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Find a Job According to Your Interests!",
          body:
              "Find a job that interests you, so you feel comfortable with your job",
          image: Image.asset('Asset/Image/OnBoarding/LogoOB1.png', height: 300),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Find a job free of charge",
          body:
              "It's easier to find work without leaving the house, just chat with the company you choose and send your CV and data about you to the company you choose!",
          image: Image.asset('Asset/Image/OnBoarding/LogoOB3.png', height: 300),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Color.fromARGB(255, 0, 123, 245))),
      next: const Icon(
        Icons.arrow_forward_rounded,
        color: Color.fromARGB(255, 0, 123, 245),
        size: 30,
      ),
      done: const Icon(
        Icons.arrow_forward_rounded,
        color: Color.fromARGB(255, 0, 123, 245),
        size: 30,
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color.fromARGB(255, 110, 181, 253),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
