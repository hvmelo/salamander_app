import 'package:flutter/material.dart';

class BottomUpPageRoute<T> extends MaterialPageRoute<T> {
  BottomUpPageRoute({required WidgetBuilder builder, RouteSettings? settings})
      : super(builder: builder, settings: settings, fullscreenDialog: true);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.name == '/') return child;
    // Fades between routes. (If you don't want any animation,
    // just return child.)
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    final tween = Tween(begin: begin, end: end);
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: curve,
    );
    return SlideTransition(
      position: tween.animate(curvedAnimation),
      child: child,
    );
  }
}
