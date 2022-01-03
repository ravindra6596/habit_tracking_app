import 'package:flutter/material.dart';

class SelectableTile extends StatefulWidget {
  const SelectableTile({Key? key, required this.builder, this.onPressed})
      : super(key: key);
  final Widget Function(BuildContext, bool) builder;
  final VoidCallback? onPressed;

  @override
  _SelectableTileState createState() => _SelectableTileState();
}

class _SelectableTileState extends State<SelectableTile> {
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTapDown: (_) => setState(() => _isPressed = true),
      onTap: widget.onPressed,
      child: widget.builder(context, _isPressed),
    );
  }
}
