import 'package:flutter/material.dart';

class BottomUpTransition extends StatelessWidget {
  const BottomUpTransition({
    Key? key,
    required Animation<double> animation,
    required Widget child,
  })  : _animation = animation,
        _child = child,
        super(key: key);

  final Animation<double> _animation;
  final Widget _child;

  @override
  Widget build(BuildContext context) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    final tween = Tween(begin: begin, end: end);
    final curvedAnimation = CurvedAnimation(
      parent: _animation,
      curve: curve,
    );
    return SlideTransition(
      position: tween.animate(curvedAnimation),
      child: _child,
    );
  }
}
