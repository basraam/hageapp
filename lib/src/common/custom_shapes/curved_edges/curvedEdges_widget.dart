import 'package:flutter/material.dart';

import 'curved_edges.dart';
class curvedEdges_widget extends StatelessWidget {
  const curvedEdges_widget({
    super.key, this.child,
  });

  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BCustomCurvedEdges(),
      child:child,
    );
  }
}
