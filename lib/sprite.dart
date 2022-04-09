import 'package:flutter/material.dart';
import 'package:flim/flim.dart';
import 'package:asset_cache/asset_cache.dart';

final imageAssetCache = ImageAssetCache(basePath: "assets/images/");
final jsonAssetCache = JsonAssetCache(basePath: "assets/");

class FlimSprite extends StatefulWidget {
  @override
  State<FlimSprite> createState() => _FlimSpriteState();
}

class _FlimSpriteState extends State<FlimSprite> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 100,
          right: 100,
          child: Container(
            alignment: Alignment.center,
            height: 100,
            width: 100,
            // color: Colors.white,
            child: FutureBuilder<AnimatedSprite>(
              future: AnimatedSprite.fromUniformSpriteSheet(
                imagePath: 'animation.png',
                spriteSize: IntSize(width: 170, height: 171),
                atlasBounds: IntRect(left: 0, top: 0, width: 8, height: 8),
                frameDuration: 0.04,
                color: Colors.transparent,
                transform: Transform2D(
                  translate: Offset(0, 0),
                ),
              ).loadImages(imageAssetCache),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GameWidget(
                    AnimatedSpriteGame(snapshot.data!),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        )
      ],
    );
  }
}
