import 'package:animated_background/animated_background.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:hackathon/screens/homepage.dart';

import '../../services/validator.dart';
import '../notification.dart';
import 'auth_button.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
  
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {
  late Widget username;
  late Widget password;

  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  //username text field
  late Widget usernameField;

  //password text field
  late Widget passwordField;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  Color signUpBackgroundColor = Colors.transparent;
  Color signUpTextColor = Colors.white;

  //animations
  late final AnimationController _titleSlideInController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<Offset> _titleSlideInOffset = Tween<Offset>(
    begin: const Offset(1.0, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _titleSlideInController,
    curve: Curves.elasticOut,
  ));

  late final AnimationController _titleSlideDownAnimationController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<Offset> _titleSlideDownOffsetController = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, 0.5),
  ).animate(CurvedAnimation(
    parent: _titleSlideDownAnimationController,
    curve: Curves.easeOutExpo,
  ));

  late final AnimationController _usernameAnimationController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<Offset> _usernameOffsetController = Tween<Offset>(
    begin: const Offset(-1.0, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _usernameAnimationController,
    curve: Curves.elasticOut,
  ));

  late final AnimationController _passwordAnimationController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<Offset> _passwordOffsetController = Tween<Offset>(
    begin: const Offset(1.0, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _passwordAnimationController,
    curve: Curves.elasticOut,
  ));

  late final AnimationController _signUpAnimationController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<Offset> _signUpOffsetController = Tween<Offset>(
    begin: const Offset(-1.0, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _signUpAnimationController,
    curve: Curves.elasticOut,
  ));

  bool visible = true;
  bool delayedVisible = true;

  changeUsernameButton() {
    setState(() {
      username = usernameField;
    });
    usernameFocusNode.requestFocus();

    usernameFocusNode.addListener(() {
      if (!usernameFocusNode.hasFocus) {
        setState(() {
          if (usernameController.text.isEmpty) {
            username = AuthButton(onPressed: changeUsernameButton, text: "Username");
          } else {
            username = AuthButton(onPressed: changeUsernameButton, text: usernameController.text);
          }
        });
      }
    });
  }

  changePasswordButton() {
    setState(() {
      password = passwordField;
    });
    passwordFocusNode.requestFocus();

    passwordFocusNode.addListener(() {
      if (!passwordFocusNode.hasFocus) {
        setState(() {
          if (passwordController.text.isEmpty) {
            password = AuthButton(onPressed: changePasswordButton, text: "Password");
          } else {
            password = AuthButton(onPressed: changePasswordButton, text: "*" * passwordController.text.length);
          }
        });
      }
    });
  }

  //animated gradient variables
  List<Color> colorList = [
    Colors.black,
    Colors.blue,
    Colors.cyan,
    Colors.green,
    Colors.black,
    Colors.red,
  ];
  int index = 0;
  late Color bottomColor;
  late Color topColor;
  Alignment begin = Alignment.bottomLeft;
  Alignment end = Alignment.topRight;

  @override
  void initState() {
    bottomColor = colorList[0];
    topColor = colorList[1];
    usernameField = TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => validateEmail(value),
      textAlign: TextAlign.center,
      controller: usernameController,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
          fillColor: Colors.grey.shade300,
          focusColor: Colors.grey.shade300,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(4.0),
          )),
      focusNode: usernameFocusNode,
    );
    username = AuthButton(onPressed: changeUsernameButton, text: "Username");
    passwordField = TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => validatePassword(value!),
      obscureText: true,
      textAlign: TextAlign.center,
      controller: passwordController,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
          fillColor: Colors.grey.shade300,
          focusColor: Colors.grey.shade300,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(4.0),
          )),
      focusNode: passwordFocusNode,
    );
    password = AuthButton(onPressed: changePasswordButton, text: 'Password');

    _titleSlideInController.forward();

    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      _usernameAnimationController.forward();
    });
    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      _passwordAnimationController.forward();
    });
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      _signUpAnimationController.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    _titleSlideInController.dispose();
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(gradient: LinearGradient(begin: begin, end: end, colors: [bottomColor, topColor])),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: GlassContainer(
                borderRadius: const BorderRadius.all(Radius.zero),
                blur: 7,
                shadowStrength: 0.0,
                border: Border.all(style: BorderStyle.none),
                child: AnimatedBackground(
                  vsync: this,
                  behaviour: RandomParticleBehaviour(options: particles),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SlideTransition(
                        position: _titleSlideDownOffsetController,
                        child: SlideTransition(
                          position: _titleSlideInOffset,
                          child: Align(
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                "Welcome",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline1,
                                maxLines: 1,
                              )),
                        ),
                      ),
                      ExcludeFocus(
                        excluding: !visible,
                        child: IgnorePointer(
                          ignoring: !visible,
                          child: AnimatedOpacity(
                            opacity: visible ? 1.0 : 0.0,
                            duration: const Duration(seconds: 1),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                SlideTransition(
                                  position: _usernameOffsetController,
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width / 2,
                                      child: AnimatedSwitcher(
                                          transitionBuilder: (Widget child, Animation<double> animation) {
                                            return SizeTransition(sizeFactor: animation, axis: Axis.horizontal, child: child);
                                          },
                                          duration: const Duration(milliseconds: 400),
                                          child: username)),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                SlideTransition(
                                  position: _passwordOffsetController,
                                  child: SizedBox(
                                      width: MediaQuery.of(context).size.width / 2,
                                      child: AnimatedSwitcher(
                                          transitionBuilder: (Widget child, Animation<double> animation) {
                                            return SizeTransition(
                                              sizeFactor: animation,
                                              axis: Axis.horizontal,
                                              child: child,
                                            );
                                          },
                                          duration: const Duration(milliseconds: 400),
                                          child: password)),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                SlideTransition(
                                  position: _signUpOffsetController,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width / 2,
                                        child: TextButton(
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(signUpBackgroundColor),
                                              fixedSize: MaterialStateProperty.all(const Size(300, 50)),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(4.0), side: const BorderSide(color: Colors.white)))),
                                          onPressed: () {
                                            if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
                                              ScaffoldMessenger.of(context).showSnackBar(notification("Please fill in all the fields", context));
                                            } else {
                                              FirebaseAuth.instance.createUserWithEmailAndPassword(email: usernameController.text, password: passwordController.text).then((value) {
                                                setState(() {
                                                  visible = !visible;
                                                });
                                                _titleSlideDownAnimationController.forward();
                                                Future.delayed(const Duration(seconds: 2)).then((value) {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    PageRouteBuilder(
                                                      pageBuilder: (context, a1, a2) => const HomePage(),
                                                      transitionsBuilder: (context, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                                      transitionDuration: const Duration(milliseconds: 2000),
                                                    ),
                                                  );
                                                });
                                              }).catchError((error) {
                                                ScaffoldMessenger.of(context).showSnackBar(notification("Authentication Failed", context));
                                              });

                                              
                                            }
                                          },
                                          onHover: (value) {
                                            setState(() {
                                              if (value) {
                                                signUpBackgroundColor = Colors.white;
                                                signUpTextColor = Colors.blue;
                                              } else {
                                                signUpBackgroundColor = Colors.transparent;
                                                signUpTextColor = Colors.white;
                                              }
                                            });
                                          },
                                          child: Text(
                                            "Sign Up",
                                            style: TextStyle(color: signUpTextColor),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Text("Have an account? ", style: TextStyle(color: Colors.white)),
                                          InkWell(
                                              onTap: () {
                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                                              },
                                              child: const Text(
                                                "Login",
                                                style: TextStyle(decoration: TextDecoration.underline, color: Colors.white),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ],
    ));
  }
}
