import 'package:flutter/material.dart';
import 'package:gps_plus/src/styles/text_styles.dart';
import 'package:gps_plus/src/widgets/login_button_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Image(
              image: const AssetImage(
                  'assets/launch_assets/launch_background.jpg'),
              height: size.height,
              fit: BoxFit.fitHeight,
            ),
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 60, horizontal: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Registrate',
                        style: TextStyles().primaryTextTheme.titleLarge),
                    Text('para continuar',
                        style: TextStyles().primaryTextTheme.titleMedium),
                    const SizedBox(
                      height: 60,
                    ),
                    const LoginButtonWidget(
                        icon: 'assets/social_media_icons/G.svg',
                        socialMedia: 'Google',
                        background: Colors.white70),
                    const SizedBox(
                      height: 40,
                    ),
                    const LoginButtonWidget(
                      icon: 'assets/social_media_icons/F.svg',
                      socialMedia: 'Facebook',
                      background: Colors.blueAccent,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const LoginButtonWidget(
                      icon: 'assets/social_media_icons/T.svg',
                      socialMedia: 'Tiktok',
                      background: Colors.black,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
