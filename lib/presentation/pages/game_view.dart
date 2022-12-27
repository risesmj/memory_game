import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:memory_game/core/constants.dart';
import 'package:memory_game/presentation/controller/game_controller.dart';
import 'package:memory_game/presentation/modal/end_game_modal.dart';
import 'package:memory_game/presentation/modal/menu_modal.dart';
import 'package:memory_game/presentation/widgets/figure_tile.dart';

class GameView extends StatefulWidget {
  final GameController controller = GameController();

  GameView({
    super.key,
  });

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: const [
                    Icon(
                      CommunityMaterialIcons.brain,
                      size: 60,
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Jogo da Memória",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "press start2p regular",
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  constraints:
                      const BoxConstraints(minWidth: 300, maxWidth: 400),
                  height: 380,
                  child: GridView.builder(
                    itemCount: GameConstants.iconsFigure.length * 2,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 115,
                            childAspectRatio: 1,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 10),
                    itemBuilder: (context, index) => FigureTile(
                        figure: widget.controller.figures.isEmpty
                            ? null
                            : widget.controller.figures[index],
                        onTap: () async {
                          await widget.controller
                              .checkHasSelect(widget.controller.figures[index]);
                          setState(() {});
                          await widget.controller.checkSelecteds();
                          setState(() {});
                          await widget.controller.checkEndGame();
                          setState(() {});
                        }),
                  ),
                ),
              ],
            ),
          ),
          if (widget.controller.menuInitialActive)
            MenuModal(
              onStart: () {
                setState(() {
                  widget.controller.startGame();
                });
              },
            ),
          if (widget.controller.endGame && !widget.controller.menuInitialActive)
            EndGameModal(
              onRetry: () {
                setState(() {
                  widget.controller.startGame();
                });
              },
            ),
        ],
      )),
    );
  }
}
