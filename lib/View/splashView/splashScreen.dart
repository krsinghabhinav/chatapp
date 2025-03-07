import 'dart:math';
import 'package:chatapp/config/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/contColors.dart';
import '../../controller/splashController.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _bounceAnimation;
  Splashcontroller splashController = Get.put(Splashcontroller());

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true); // Loops forward & backward

    // Bounce animation for scaling effect
    _bounceAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.bounceOut),
    );

    // Ensure navigation after splash
    WidgetsBinding.instance.addPostFrameCallback((_) {
      splashController.splashHendler();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _animationController.value *
                      2.0 *
                      pi, // Continuous rotation
                  child: Transform.scale(
                    scale: _bounceAnimation.value, // Bouncing effect
                    child: child,
                  ),
                );
              },
              child: Image.asset(
                AssetsImages.appiconPng,
                width: 150,
                height: 150,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Sampark',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Contcolors.textColorOrange,
                  ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Connect, Communicate, Celebrate!',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
