import 'package:common/utils/navigation/navigation.dart';
import 'package:dependencies/show_up_animation/show_up_animation.dart';
import 'package:flutter/material.dart';
import 'package:resources/constant/named_routes.dart';

class SplashScreen extends StatelessWidget {
  final duration = const Duration(seconds: 3);

  SplashScreen({super.key}) {
    _handleOnInitialize();
  }

  void _handleOnInitialize() async {
    Future.delayed(duration).then(
      (_) => Navigator.pushNamedAndRemoveUntil(
        Navigation.getContext(),
        NamedRoutes.onBoardScreen,
        (route) => false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ShowUpAnimation(
            //       animationDuration: const Duration(seconds: 1),
            //       curve: Curves.easeIn,
            //       direction: Direction.horizontal,
            //       offset: -0.5,
            //       child: Image.asset(
            //         'assets/icon_quran_white.png',
            //         width: 40,
            //       ),
            //     ),
            //     const SizedBox(width: 5.0),
            //     ShowUpAnimation(
            //       animationDuration: const Duration(seconds: 1),
            //       curve: Curves.easeIn,
            //       direction: Direction.horizontal,
            //       offset: -1,
            //       delayStart: const Duration(seconds: 1),
            //       child: Text(
            //         'Quran App',
            //         style: kHeading6.copyWith(
            //           color: Colors.white,
            //           fontWeight: FontWeight.bold,
            //           fontSize: 24.0,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 15.0),
            ShowUpAnimation(
              animationDuration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              direction: Direction.horizontal,
              offset: -1,
              delayStart: const Duration(seconds: 1),
              child: Image.asset(
                'assets/logo_splash_image.png',
                scale: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
