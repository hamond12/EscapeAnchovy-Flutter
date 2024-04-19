import 'package:escape_anchovy/src/common/common_app_bar.dart';
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
      appBar: const CommonAppBar(
        title: '메인화면',
        isHome: true,
      ),
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
            'ㅁㄴㅇㄹ',
          ),
        )
      ],
    );
  }
}
