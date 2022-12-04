import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:rive/rive.dart';
import 'package:venu/screens/self_analysis/traits_card.dart';

class SelfAnalysis extends StatefulWidget {
  static const routeName = '/self_analysis';
  const SelfAnalysis({Key? key}) : super(key: key);

  @override
  State<SelfAnalysis> createState() => _SelfAnalysisState();
}

class _SelfAnalysisState extends State<SelfAnalysis> {
  bool eSelected = true;
  bool sSelected = true;
  bool tSelected = true;
  bool jSelected = true;

  void toggleBool(bool selected) {
    setState(() {
      selected = !selected;
    });
  }

  String calculatePersonality(){
   String personalityType = '';
   eSelected?personalityType='${personalityType}E':personalityType='${personalityType}I';
   sSelected?personalityType='${personalityType}S':personalityType='${personalityType}N';
   tSelected?personalityType='${personalityType}T':personalityType='${personalityType}F';
   jSelected?personalityType='${personalityType}J':personalityType='${personalityType}P';
   return personalityType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: IntroductionScreen(
          rawPages: [
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.15,
                  horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 75.0,
                    height: 25.0,
                    child: RiveAnimation.asset('assets/images/venu-logo.riv'),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  const Text(
                    'For each of the questions in the upcoming screens, ask yourself: Which side best represents me most of the time?\n\nThink about which side comes more naturally and choose the letter next to it.',
                    style: TextStyle(
                      fontFamily: 'Google-Sans',
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.01,
                  horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    width: 75.0,
                    height: 25.0,
                    child: RiveAnimation.asset('assets/images/venu-logo.riv'),
                  ),
                  const Text(
                    'How do you get your energy?',
                    style: TextStyle(
                      fontFamily: 'Google-Sans',
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        eSelected = !eSelected;
                      });
                    },
                    child: TraitsCard(
                      traits: const [
                        'are generally sociable',
                        'are focused on the outer world',
                        'get energy by spending time with others',
                        'talk a lot & start conversations',
                        'speak first, then think',
                        'are quick to take action',
                        'have many friends & many interests',
                      ],
                      title: 'Extraverts - E',
                      selected: eSelected,
                    ),
                  ),
                  Row(
                    children: const [
                      Expanded(
                          child: Divider(
                        thickness: 3.0,
                        color: Color(0xff8A8A8E),
                        endIndent: 10.0,
                        indent: 10.0,
                      )),
                      Text(
                        'or',
                        style: TextStyle(
                          fontFamily: 'Google-Sans',
                          fontSize: 14.0,
                          color: Color(0xff8A8A8E),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 3.0,
                        color: Color(0xff8A8A8E),
                        endIndent: 10.0,
                        indent: 10.0,
                      )),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        eSelected = !eSelected;
                      });
                    },
                    child: TraitsCard(
                      traits: const [
                        'are generally quite',
                        'are focused on their inner world',
                        'get energy by spending time alone',
                        'mostly listen and wait for others to talk first',
                        'think first, then speak',
                        'are slow to take action',
                        'have a few deep friendships & refined interests',
                      ],
                      title: 'Introverts - I',
                      selected: !eSelected,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.01,
                  horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    width: 75.0,
                    height: 25.0,
                    child: RiveAnimation.asset('assets/images/venu-logo.riv'),
                  ),
                  const Text(
                    'How do you see the world & gather information?',
                    style: TextStyle(
                      fontFamily: 'Google-Sans',
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        sSelected = !sSelected;
                      });
                    },
                    child: TraitsCard(
                      traits: const [
                        'have finely-tuned five senses',
                        'pay attention to the details',
                        'focus on what is real(in the present)',
                        'think in concrete terms',
                        'like practical things',
                        'like to do(make)',
                        'are accurate and observant',
                        'prefer to do things the established way'
                      ],
                      title: 'Sensors - S',
                      selected: sSelected,
                    ),
                  ),
                  Row(
                    children: const [
                      Expanded(
                          child: Divider(
                        thickness: 3.0,
                        color: Color(0xff8A8A8E),
                        endIndent: 10.0,
                        indent: 10.0,
                      )),
                      Text(
                        'or',
                        style: TextStyle(
                          fontFamily: 'Google-Sans',
                          fontSize: 14.0,
                          color: Color(0xff8A8A8E),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 3.0,
                        color: Color(0xff8A8A8E),
                        endIndent: 10.0,
                        indent: 10.0,
                      )),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        sSelected = !sSelected;
                      });
                    },
                    child: TraitsCard(
                      traits: const [
                        'use their \'sixth sense\'',
                        'see \'big picture\'',
                        'focus on what is possible (in the future)',
                        'think in abstract terms',
                        'like theories',
                        'like to dream (design)',
                        'are creative and imaginative',
                        'prefer to try out new ideas',
                      ],
                      title: 'iNtuitives - N',
                      selected: !sSelected,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.01,
                  horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    width: 75.0,
                    height: 25.0,
                    child: RiveAnimation.asset('assets/images/venu-logo.riv'),
                  ),
                  const Text(
                    'How do you make your decisions?',
                    style: TextStyle(
                      fontFamily: 'Google-Sans',
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        tSelected = !tSelected;
                      });
                    },
                    child: TraitsCard(
                      traits: const [
                        'mostly use their head',
                        'make decisions based on logic',
                        'are more interested in things & ideas',
                        'treat everybody the same',
                        'are more scientific in describing the world',
                      ],
                      title: 'Thinkers - T',
                      selected: tSelected,
                    ),
                  ),
                  Row(
                    children: const [
                      Expanded(
                          child: Divider(
                        thickness: 3.0,
                        color: Color(0xff8A8A8E),
                        endIndent: 10.0,
                        indent: 10.0,
                      )),
                      Text(
                        'or',
                        style: TextStyle(
                          fontFamily: 'Google-Sans',
                          fontSize: 14.0,
                          color: Color(0xff8A8A8E),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 3.0,
                        color: Color(0xff8A8A8E),
                        endIndent: 10.0,
                        indent: 10.0,
                      )),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        tSelected = !tSelected;
                      });
                    },
                    child: TraitsCard(
                      traits: const [
                        'mostly use their heart',
                        'make decisions based on their values',
                        'are more interested in people & emotions',
                        'treat people according to their situation',
                        'are more poetic in describing the world',
                      ],
                      title: 'Feelers - F',
                      selected: !tSelected,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.01,
                  horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    width: 75.0,
                    height: 25.0,
                    child: RiveAnimation.asset('assets/images/venu-logo.riv'),
                  ),
                  const Text(
                    'How do you see the world & gather information?',
                    style: TextStyle(
                      fontFamily: 'Google-Sans',
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        jSelected = !jSelected;
                      });
                    },
                    child: TraitsCard(
                      traits: const [
                        'are organized and structured',
                        'make plans in advance',
                        'keep to the plan',
                        'like to be in control of their life',
                        'want to finalise decisions',
                      ],
                      title: 'Judgers - J',
                      selected: jSelected,
                    ),
                  ),
                  Row(
                    children: const [
                      Expanded(
                          child: Divider(
                        thickness: 3.0,
                        color: Color(0xff8A8A8E),
                        endIndent: 10.0,
                        indent: 10.0,
                      )),
                      Text(
                        'or',
                        style: TextStyle(
                          fontFamily: 'Google-Sans',
                          fontSize: 14.0,
                          color: Color(0xff8A8A8E),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 3.0,
                        color: Color(0xff8A8A8E),
                        endIndent: 10.0,
                        indent: 10.0,
                      )),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        jSelected = !jSelected;
                      });
                    },
                    child: TraitsCard(
                      traits: const [
                        'are casual and relaxed',
                        'prefer to \'go with the flow\'',
                        'are able to change and adapt quickly',
                        'like simply to let life happen',
                        'want to find more information',
                      ],
                      title: 'Perceivers - P',
                      selected: !jSelected,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.2,
                  horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 75.0,
                    height: 25.0,
                    child: RiveAnimation.asset('assets/images/venu-logo.riv'),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  const Text(
                    'Your personality from the self-analysis test is',
                    style: TextStyle(
                      fontFamily: 'Google-Sans',
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Text(
                    calculatePersonality(),
                    style: const TextStyle(
                      fontFamily: 'Google-Sans',
                      fontSize: 32.0,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70.0, vertical: 0.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          minimumSize: const Size(double.infinity, 56),
                          primary: const Color(0xffA7D1D7),
                        ),
                        child: const Text(
                          'Go Back!',
                          style: TextStyle(
                            fontFamily: "Google-Sans",
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
      ),
    );
  }
}
