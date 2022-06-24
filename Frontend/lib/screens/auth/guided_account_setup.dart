import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class GuidedAccountSetup extends StatefulWidget {
  const GuidedAccountSetup({Key? key}) : super(key: key);

  @override
  State<GuidedAccountSetup> createState() => _GuidedAccountSetupState();
}

class _GuidedAccountSetupState extends State<GuidedAccountSetup> with SingleTickerProviderStateMixin{


  //background gradient variables
  Color bottomColor = Colors.black;
  Color topColor = Colors.blue;
  Alignment begin = Alignment.bottomLeft;
  Alignment end = Alignment.topRight;


  //Animated background particles
  ParticleOptions particles = const ParticleOptions(
    baseColor: Colors.cyan,
    spawnOpacity: 0.0,
    opacityChangeRate: 0.25,
    minOpacity: 0.1,
    maxOpacity: 0.4,
    particleCount: 50,
    spawnMaxRadius: 50.0,
    spawnMaxSpeed: 100.0,
    spawnMinSpeed: 60,
    spawnMinRadius: 15.0,
  );

  bool welcomeVisible = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(gradient: LinearGradient(begin: begin, end: end, colors: [bottomColor, topColor])),
        ),
        Positioned.fill(
          child: GlassContainer(
            borderRadius: const BorderRadius.all(Radius.zero),
            blur: 7,
            shadowStrength: 0.0,
            child: AnimatedBackground(
              vsync: this,
              behaviour: RandomParticleBehaviour(options: particles),
              child: Column(children: [
                AnimatedOpacity(opacity: welcomeVisible ? 1.0 : 0.0, duration: const Duration())
              ]),

            ),
          ),
        )
      ],
    );
  }
}