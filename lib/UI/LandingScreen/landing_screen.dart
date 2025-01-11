import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winify/Constants/constants.dart';
import 'package:winify/UI/LandingScreen/LandingPageComponents/LandingPageViewModels/lpvm1.dart';
import 'package:winify/UI/LandingScreen/LandingPageComponents/LandingPageViewModels/lpvm2.dart';
import 'package:winify/UI/LandingScreen/LandingPageComponents/LandingPageViewModels/lpvm3.dart';
import 'package:winify/UI/LandingScreen/LandingPageComponents/LandingWidgets/skip_text.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final landingKey = GlobalKey<IntroductionScreenState>();
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: primaryBackground,
      key: landingKey,
      pages: [
        PageViewModel(
          title: "",
          decoration: PageDecoration(bodyAlignment: Alignment.center),
          bodyWidget: firstPage()
        ),
        PageViewModel(
          title: "",
          decoration: PageDecoration(bodyAlignment: Alignment.center),
          bodyWidget: secondPage()
        ),
        PageViewModel(
          title: "",
          decoration: PageDecoration(bodyAlignment: Alignment.center),
          bodyWidget:thirdPage(context, onLandingEnd, extra: getStartedButton())
        )
      ],
      skip: skipText(),
      done: Text(''),
      showSkipButton: true,
      showNextButton: true,
      next: Icon(
        Icons.arrow_forward_ios_rounded,
        color: primaryColor,
      ),
      dotsDecorator: DotsDecorator(
        activeColor: primaryColor,
        size: Size(8.0, 8.0),
        color: Colors.white10,
      ),
      onDone: () => onLandingEnd(context),          
    );
  }
  Widget getStartedButton(){
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 32, 10, 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 0),
        onPressed: () => onLandingEnd(context),
        child: Ink(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: primaryGradient,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(4)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Get Started",
                  style: GoogleFonts.sarpanch(
                    color: primaryWhite,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Icon(
                  Icons.arrow_forward,
                  color: primaryWhite,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void onLandingEnd(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('firstTime', false);
  Navigator.of(context).pop();
}