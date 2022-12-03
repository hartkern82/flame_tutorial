import 'package:flame_test/common/buttons.dart';
import 'package:flame_test/common/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FlameTest());
}

class FlameTest extends StatelessWidget {
  const FlameTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      initialRoute: '/',
      routes: appRoutes,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget flameGamesEntries(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PrimaryButton(
            title: 'Flame Joystick Test',
            onTap: () {
              Navigator.pushNamed(context, '/joysticktest');
            },
          ),
          // PrimaryButton(
          //   title: 'Flame TiledMap Test',
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: flameGamesEntries(context),
    );
  }
}
