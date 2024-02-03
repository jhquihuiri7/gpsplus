import 'package:flutter/material.dart';
import 'package:gps_plus/src/styles/text_styles.dart';
import 'package:lottie/lottie.dart';

class RegistrationCompletePage extends StatefulWidget {
  const RegistrationCompletePage({super.key});

  @override
  State<RegistrationCompletePage> createState() =>
      _RegistrationCompletePageState();
}

class _RegistrationCompletePageState extends State<RegistrationCompletePage>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  bool _animationComplete = false;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    _controller.addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        _animationComplete = true;
        setState(() {
          print(_animationComplete);
          //print(object)
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              'assets/animations/login_ok.json',
              width: size.width * 0.7,
              fit: BoxFit.cover,
              controller: _controller,
              onLoaded: (composition) {
                _controller
                  ..duration = composition.duration
                  ..forward();
              },
            ),
            const SizedBox(
              height: 50,
            ),
            (_animationComplete)
                ? Text(
                    "Registro completo",
                    style: TextStyles().changeColor(
                        TextStyles().primaryTextTheme.labelSmall,
                        Colors.black38),
                  )
                : Container(
                    height: 20,
                  ),
            const SizedBox(
              height: 20,
            ),
            (_animationComplete)
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent),
                    onPressed: () {},
                    child: const Text("Continuar"))
                : Container(
                    height: 40,
                  ),
          ],
        )),
      ),
    );
  }
}
