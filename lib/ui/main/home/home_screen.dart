import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shiritori/ui/main/home/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Expanded(
          flex: 2,
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: HomeHeader(),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: HomeMenu(),
        ),
      ],
    );
  }
}
