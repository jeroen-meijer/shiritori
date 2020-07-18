import 'package:flutter/material.dart';
import 'package:shiritori/assets/assets.dart';
import 'package:shiritori/ui/home/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Images.backgroundMain(fit: BoxFit.cover),
          SafeArea(
            child: Column(
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
            ),
          ),
        ],
      ),
    );
  }
}
