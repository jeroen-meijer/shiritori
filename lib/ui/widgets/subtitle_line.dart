import 'package:flutter/material.dart';

class SubtitleLine extends StatelessWidget {
  const SubtitleLine({
    Key key,
    this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36.0,
      child: Divider(
        color: color,
      ),
    );
  }
}
