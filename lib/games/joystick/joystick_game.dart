import 'package:flame/events.dart';
import 'package:flame_test/common/games_prefercenses.dart';
import 'package:flame_test/games/joystick/joystick_game_flame.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:dashbook/dashbook.dart';

class JoystickTestGame extends StatefulWidget {
  const JoystickTestGame({Key? key}) : super(key: key);

  @override
  State<JoystickTestGame> createState() => _JoystickTestGameState();
}

class _JoystickTestGameState extends State<JoystickTestGame> {
  late final JoyStickGame _game;

  Future<void> setDeviceSettings() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Flame.device.fullScreen();
    await Flame.device.setLandscapeLeftOnly();
  }

  @override
  void initState() {
    super.initState();
    setDeviceSettings();
    _game = JoyStickGame();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: _game, overlayBuilderMap: {'GameMenu': _gameMenuBuilder});
  }

  Widget _gameMenuBuilder(BuildContext buildContext, JoyStickGame game) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.125,
        // color: Colors.orange,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                    overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                ]);
                game.stopMusic();
                Navigator.of(context).pushReplacementNamed('/');
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.125,
                width: MediaQuery.of(context).size.height * 0.125,
                color: Theme.of(context).colorScheme.background.withOpacity(0.5),
                child: const Center(
                  child: Icon(
                    Icons.close,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                game.pauseMusic();
                setState(() {});
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.125,
                width: MediaQuery.of(context).size.height * 0.125,
                color: Theme.of(context).colorScheme.background.withOpacity(0.5),
                child: Center(
                  child: Icon(
                    game.isplayingMusic
                        ? GamingPrefercences.isPlayingIcon
                        : GamingPrefercences.isNotPlayingIcon,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget overlayBuilder(DashbookContext ctx) {
    return GameWidget<JoyStickGame>(
      game: JoyStickGame(),
      overlayBuilderMap: {
        'GameMenu': _gameMenuBuilder,
      },
    );
  }
}
