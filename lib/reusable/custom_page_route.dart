import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  CustomPageRoute({required this.child})
      : super(
            transitionDuration: const Duration(milliseconds: 300),
            reverseTransitionDuration: const Duration(milliseconds: 300),
            pageBuilder: (context, animation, secondaryAnimation) => child);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1,0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );

  // Offset? getBeginOffset(){
  //   switch(direction) {
  //     case AxisDirection.up:
  //       return Offset(0, 1);
  //     case AxisDirection.down:
  //       return Offset(0, -1);
  //     case AxisDirection.right:
  //       return Offset(-1, 0);
  //     case AxisDirection.left:
  //       return Offset(1, 0);
  //   }
  // }
}
