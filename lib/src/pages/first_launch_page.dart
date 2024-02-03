import 'package:flutter/material.dart';

class FirstLaunchPage extends StatelessWidget {
  const FirstLaunchPage({super.key});

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
                    const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage(
                              'assets/launch_assets/launch_logo.png'),
                          height: 90,
                          width: 90,
                        )
                      ],
                    ),
                    Expanded(child: Container()),
                    Text(
                      'Experiencia IA',
                      style: Theme.of(context).primaryTextTheme.titleSmall,
                    ),
                    Text(
                      'Descubre Galapagos',
                      style: Theme.of(context).primaryTextTheme.titleLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, 'login');
                              },
                              style:
                                  Theme.of(context).elevatedButtonTheme.style,
                              child: const Text('!Quiero mas!')),
                        ],
                      ),
                    )
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
