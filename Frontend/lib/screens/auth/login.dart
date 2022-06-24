import 'package:animated_background/animated_background.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:hackathon/screens/auth/sign_up.dart';

import '../../services/validator.dart';
import '../homepage.dart';
import '../../widgets/notification.dart';
import 'auth_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
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

  Color loginBackgroundColor = Colors.transparent;
  Color loginTextColor = Colors.white;

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

  late final AnimationController _loginAnimationController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<Offset> _loginOffsetController = Tween<Offset>(
    begin: const Offset(-1.0, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _loginAnimationController,
    curve: Curves.elasticOut,
  ));

  bool visible = true;
  bool delayedVisible = true;

  final auth = FirebaseAuth.instance;

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


  Color bottomColor = Colors.black;
  Color topColor = Colors.blue;
  Alignment begin = Alignment.bottomLeft;
  Alignment end = Alignment.topRight;

  @override
  void initState() {
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
      _loginAnimationController.forward();
    });

    super.initState();
  }

  @override
  void dispose() {
    _titleSlideInController.dispose();
    _titleSlideDownAnimationController.dispose();
    _usernameAnimationController.dispose();
    _passwordAnimationController.dispose();
    _loginAnimationController.dispose();

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
                                "Welcome\nBack",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline1,
                                maxLines: 2,
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
                                  position: _loginOffsetController,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width / 2,
                                        child: TextButton(
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(loginBackgroundColor),
                                              fixedSize: MaterialStateProperty.all(const Size(300, 50)),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(4.0), side: const BorderSide(color: Colors.white)))),
                                          onPressed: () {
                                            if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
                                              ScaffoldMessenger.of(context).showSnackBar(notification("Please fill in all the fields", context));
                                            } else {
                                              FirebaseAuth.instance
                                                  .signInWithEmailAndPassword(email: usernameController.text, password: passwordController.text)
                                                  .then((value) {
                                                setState(() {
                                                  visible = !visible;
                                                });
                                                _titleSlideDownAnimationController.forward();
                                                Future.delayed(const Duration(seconds: 2)).then((value) {
                                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
                                                });
                                              }).catchError((error) {
                                                ScaffoldMessenger.of(context).showSnackBar(notification("Authentication Failed", context));
                                              });
                                            }
                                          },
                                          onHover: (value) {
                                            setState(() {
                                              if (value) {
                                                loginBackgroundColor = Colors.white;
                                                loginTextColor = Colors.blue;
                                              } else {
                                                loginBackgroundColor = Colors.transparent;
                                                loginTextColor = Colors.white;
                                              }
                                            });
                                          },
                                          child: Text(
                                            "Login",
                                            style: TextStyle(color: loginTextColor),
                                          ),
                                        ),
                                      ),
                                      
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 15),
                                          const Text("Don't have an account? ", style: TextStyle(color: Colors.white)),
                                          InkWell(
                                              onTap: () {
                                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUpPage()));
                                              },
                                              child: const Text(
                                                "Sign up",
                                                style: TextStyle(decoration: TextDecoration.underline, color: Colors.white),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
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
