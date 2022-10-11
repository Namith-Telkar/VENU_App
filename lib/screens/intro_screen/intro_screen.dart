import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:rive/rive.dart';
import 'package:venu/screens/sign_in/sign_in.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key? key}) : super(key: key);
  static const routeName = '/intro_screen';

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: '',
              body: '',
              image: Container(
                margin: const EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        width: 75.0,
                        height: 25.0,
                        child:
                            RiveAnimation.asset('assets/images/venu-logo.riv'),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 50.0),
                        child: const Text(
                          'Find the best venues to meetup at!',
                          style: TextStyle(
                              fontFamily: "Google-Sans",
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        width: 255,
                        height: 300,
                        child: RiveAnimation.asset('assets/images/intro-1.riv'),
                      )
                      //Image.asset('assets/images/intro1.png'),
                    ],
                  ),
                ),
              ),
              decoration: const PageDecoration(
                imageFlex: 5,
                bodyFlex: 1,
              ),
            ),
            PageViewModel(
              title: '',
              body: '',
              image: Container(
                margin: const EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        width: 75.0,
                        height: 25.0,
                        child:
                            RiveAnimation.asset('assets/images/venu-logo.riv'),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 50.0),
                        child: const Text(
                          'We make finding the nearest and most suited venue easy!',
                          style: TextStyle(
                            fontFamily: "Google-Sans",
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        width: 255,
                        height: 300,
                        child: RiveAnimation.asset('assets/images/intro-2.riv'),
                      ),
                    ],
                  ),
                ),
              ),
              decoration: const PageDecoration(
                imageFlex: 5,
                bodyFlex: 1,
              ),
            ),
            PageViewModel(
              title: '',
              body: '',
              image: Container(
                margin: const EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        width: 75.0,
                        height: 25.0,
                        child:
                            RiveAnimation.asset('assets/images/venu-logo.riv'),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 50.0),
                        child: const Text(
                          'We consider distance and real-time traffic before suggesting you any venue!',
                          style: TextStyle(
                            fontFamily: "Google-Sans",
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        width: 350,
                        height: 300,
                        child: RiveAnimation.asset('assets/images/intro-3.riv'),
                      )
                    ],
                  ),
                ),
              ),
              decoration: const PageDecoration(
                imageFlex: 5,
                bodyFlex: 1,
              ),
            ),
            PageViewModel(
              title: '',
              body: '',
              image: Container(
                margin: const EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        width: 75.0,
                        height: 25.0,
                        child:
                            RiveAnimation.asset('assets/images/venu-logo.riv'),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 40.0),
                        child: const Text(
                          'We consider your preferences too!',
                          style: TextStyle(
                            fontFamily: "Google-Sans",
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        width: 275,
                        height: 250,
                        child: RiveAnimation.asset('assets/images/intro-4.riv'),
                      ),
                    ],
                  ),
                ),
              ),
              footer: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 40.0),
                      child: const Text(
                        'Ready to find your perfect venue?',
                        style: TextStyle(
                          fontFamily: "Google-Sans",
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, SignIn.routeName);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        minimumSize: const Size(double.infinity, 56),
                        primary: const Color(0xffA7D1D7),
                      ),
                      child: const Text(
                        'Start',
                        style: TextStyle(
                          fontFamily: "Google-Sans",
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              decoration: const PageDecoration(
                imageFlex: 3,
                bodyFlex: 2,
                imagePadding:
                    EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                footerPadding:
                    EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
              ),
            ),
          ],
          ///////////////////////////////////////////////////////////////
          onDone: () {
            // When done button is press
          },
          onSkip: () {
            // You can also override onSkip callback
          },
          showBackButton: true,
          showSkipButton: false,
          back: const Icon(
            Icons.navigate_before,
            color: Color(0xffA7D1D7),
          ),
          skip: const Icon(Icons.skip_next),
          next: const Icon(Icons.navigate_next, color: Color(0xffA7D1D7)),
          done: const Text(""),
          dotsDecorator: DotsDecorator(
              size: const Size.square(10.0),
              activeSize: const Size(20.0, 10.0),
              activeColor: const Color(0xffA7D1D7),
              color: Colors.black26,
              spacing: const EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0))),
        ),
      ),
    );
  }
}
