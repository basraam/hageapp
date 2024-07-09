import 'package:flutter/material.dart';
import '../../../utils/constants/Colors.dart';
import '../curved_edges/curvedEdges_widget.dart';
import 'circular_container.dart';
class HomePageHeader extends StatelessWidget {
  const HomePageHeader({
    super.key, required this.child,
  });

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return curvedEdges_widget(
      child:  Container(
          padding: const EdgeInsets.all(0),
          color: BColors.primaryColor,
          child: SizedBox(
            height: 280,
            child: Stack(
              children: [
                Positioned(top:-150, right: -100, child:  BCircularContainer(backgroundColor: BColors.white.withOpacity(0.1))),
                Positioned(top:30, right: -200, child:  BCircularContainer(backgroundColor: BColors.white.withOpacity(0.1))),
                child,
              ],
            ),
          )),
    );
  }
}

