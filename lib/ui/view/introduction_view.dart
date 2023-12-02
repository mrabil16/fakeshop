import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constant/app_color.dart';

import '../../ui/view/index_view.dart';
import '../widget/fade_route.dart';

class IntroductionView extends StatefulWidget {
  const IntroductionView({super.key});

  @override
  _IntroductionViewState createState() => _IntroductionViewState();
}

class _IntroductionViewState extends State<IntroductionView> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('intro', true);
    Navigator.of(context).push(
      FadeRoute(
        page: IndexView(),
      ),
    );
  }

  Widget _buildFullscrenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset(
      'assets/images/$assetName',
      width: width,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
      fontSize: 19.0,
    );

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
      ),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(
        16.0,
        0.0,
        16.0,
        16.0,
      ),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      pages: [
        PageViewModel(
          title: "Welcome to Our App!",
          body: "Your gateway to a seamless experience",
          image: _buildImage('onboarding-3.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Explore Exciting Features",
          body: "Discover what makes our app special.",
          image: _buildImage('onboarding-2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Let's Begin",
          body: "Dive in and start your journey with us",
          image: _buildImage('onboarding-1.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      skip: const Text(
        'Lewati',
        style: TextStyle(
          color: colorPrimary,
        ),
      ),
      next: const Icon(
        Icons.arrow_forward,
        color: colorPrimary,
      ),
      done: const Text(
        'Selesai',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: colorPrimary,
        ),
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: EdgeInsets.all(12.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeColor: colorPrimary,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
