import 'package:flame_test/common/gaming_ui_prefercenses.dart';
import 'package:flame_test/games/museum_exploration/museum_exploration_game_flame.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:dashbook/dashbook.dart';

class MuseumExplorationGame extends StatefulWidget {
  const MuseumExplorationGame({Key? key}) : super(key: key);

  @override
  State<MuseumExplorationGame> createState() => _MuseumExplorationGameState();
}

class _MuseumExplorationGameState extends State<MuseumExplorationGame> {
  late final MuseumTileGame _game;

  Future<void> setDeviceSettings() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Flame.device.fullScreen();
    await Flame.device.setLandscapeLeftOnly();
  }

  @override
  void initState() {
    super.initState();
    setDeviceSettings();
    _game = MuseumTileGame();
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: _game, overlayBuilderMap: {'GameMenu': _gameMenuBuilder});
  }

  Widget _gameMenuBuilder(BuildContext buildContext, MuseumTileGame game) {
    return Align(
      alignment: GamingUIPrefercences.gameMenuAlignment,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
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
                game.toggleMusic();
                setState(() {});
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.125,
                width: MediaQuery.of(context).size.height * 0.125,
                color: Theme.of(context).colorScheme.background.withOpacity(0.5),
                child: Center(
                  child: Icon(
                    game.isplayingMusic
                        ? GamingUIPrefercences.isPlayingIcon
                        : GamingUIPrefercences.isNotPlayingIcon,
                    size: GamingUIPrefercences.iconSize,
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
    return GameWidget<MuseumTileGame>(
      game: MuseumTileGame(),
      overlayBuilderMap: {
        'GameMenu': _gameMenuBuilder,
      },
    );
  }
}
