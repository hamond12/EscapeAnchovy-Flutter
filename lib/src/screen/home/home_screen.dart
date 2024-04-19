import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/screen/home/home_controller.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AnimatedBuilder(
          animation: _controller,
          builder: (context, snapshot) {
            return _buildPage(context);
          }),
    );
  }

  Widget _buildPage(BuildContext context) {
    return const Column(
      children: [
        Center(
          child: Text(
            'ㅎㅇ',
            style: TextStyles.h1Bold,
          ),
        )
      ],
    );
  }
}
