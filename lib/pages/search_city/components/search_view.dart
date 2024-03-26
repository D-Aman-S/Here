import 'package:hereAssignment/common_components/search_bar.dart';
import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const SearchView({Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 30 * (1.0 - animation!.value), 0.0),
              child: const CustomSearchBar()),
        );
      },
    );
  }
}
