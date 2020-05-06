import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TutorialPageChild();
  }
}

class TutorialPageChild extends StatefulWidget {
  @override
  _TutorialPageChildState createState() => _TutorialPageChildState();
}

class _TutorialPageChildState extends State<TutorialPageChild> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pop();
  }

  Widget _buildImage(String assetName) {
    try {
      return Align(
        child: Image.asset('assets/images/$assetName.png', width: 400.0),
        alignment: Alignment.bottomCenter,
      );
    } catch (error) {
      print(assetName);
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Advanced Technology",
          body:
              "You will be using face recognition system to use KMITL Fitness Center.",
          image: _buildImage('face_id'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "News and Articles",
          body: "Keep up with our promotion,\ntips and tricks, and many more!",
          image: _buildImage('home'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Daily Exercise Classes",
          body:
              "Variety of exercise classes.\nLead by KMITL Fitness Center's professional trainers.",
          image: _buildImage('class'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Reserve Your Spot!",
          body:
              "Now you can reserve exercise class in advance. No more rush for spots.",
          image: _buildImage('class_reserve'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Smart Locker System",
          body: "Keep your valuables safe without having to worry.",
          image: _buildImage('locker'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Next Level Security",
          body:
              "Type in PIN code generated by locker. Ensure that you are using locker from the gym.",
          image: _buildImage('locker_pin'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Easy To Use",
          body: "Lock or unlock it with your phone.",
          image: _buildImage('locker_lock'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Limited Treadmills? No Problem!",
          body:
              "With our Treadmill queueing system. You can just queue up and chill. No more staring at Treadmill!",
          image: _buildImage('treadmill'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Face Recognition Treadmill!",
          body:"length is too long that make crash",
              //"When it's time for your queue, go up to the specified Treadmill in 30 seconds and scan your face. This ensure that nobody else could take your queue!",
          image: _buildImage('treadmill_timer'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Manage Your Profile",
          body:
              "Manage your membership, edit your information, redeem your points, change your password, and so on.",
          image: _buildImage('profile'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Redeem Your Points!",
          body: "You can go and reedeem you points for stuff or discount.",
          image: _buildImage('reward'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Membership Options!",
          body: "Choose what suites you and your wallet.",
          image: _buildImage('membership'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "We Take Credit/Debit Card",
          body:
              "Purchase membership and pay it with credit or debit card through our trusted payment service.",
          image: _buildImage('payment'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Ready To Roll?\nLet's Get Started!",
          body: "",
          image: _buildImage('white'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipFlex: 0,
      nextFlex: 0,
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        activeColor: Color(0xFFE65100),
        size: Size(5, 5),
        color: Color(0xFFBDBDBD),
        activeSize: Size(10, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }
}
