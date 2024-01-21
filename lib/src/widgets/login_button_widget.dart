import 'package:flutter/material.dart';
import 'package:gps_plus/src/styles/text_styles.dart';

class LoginButtonWidget extends StatelessWidget {
  final String icon;
  final String socialMedia;
  final Color background;
  const LoginButtonWidget({super.key, required this.icon, required this.socialMedia, required this.background});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: (){},
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          elevation: 5,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(socialMedia, style: TextStyles().primaryTextTheme.titleSmall,),
              Image(image: AssetImage(icon), height: 35,)
            ],
          ),
        )
    );
  }
}
