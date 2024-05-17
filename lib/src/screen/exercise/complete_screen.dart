import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/common/common_app_bar.dart';
import 'package:escape_anchovy/src/common/common_button.dart';
import 'package:escape_anchovy/src/screen/exercise/exercise_controller.dart';
import 'package:escape_anchovy/src/screen/home/home_controller.dart';
import 'package:escape_anchovy/src/screen/home/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompleteScreen extends StatefulWidget {
  const CompleteScreen(
      {super.key,
      required this.exerciseController,
      required this.homeController});

  final ExerciseController exerciseController;
  final HomeController homeController;

  static const routeName = '/complete';

  @override
  State<CompleteScreen> createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {
  final _controller = ExerciseController();

  @override
  void initState() {
    super.initState();
    _controller.initDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: '운동완료', isExercise: true),
      body: AnimatedBuilder(
          animation: _controller,
          builder: (context, snapshot) {
            return _buildPage(context);
          }),
    );
  }

  Widget _buildPage(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.14),
                  SvgPicture.asset('asset/svg/complete.svg'),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${_controller.dataList.length + 1}',
                        style: TextStyles.title.copyWith(
                            color: context.isLight
                                ? LightModeColors.blue
                                : DarkModeColors.blue),
                      ),
                      const Text(
                        '일차 완료!',
                        style: TextStyles.title,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    '수고하셨습니다',
                    style: TextStyles.h2Medium.copyWith(
                        color: context.isLight
                            ? LightModeColors.dark3
                            : DarkModeColors.dark3),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 40, 30, 25),
            child: CommonButton(
              text: '홈으로',
              onPressed: () {
                _controller.addData({
                  'time': DateTime.now().toString(),
                  'day': _controller.dataList.length + 1,
                  'ex1_name':
                      widget.homeController.isSelected1 == true ? '풀업' : '친업',
                  'ex2_name': widget.homeController.isSelected3 == true
                      ? '푸쉬업'
                      : '너클 푸쉬업',
                  'ex1': widget.exerciseController.ex1,
                  'ex2': widget.exerciseController.ex2,
                });
                Navigator.pushNamedAndRemoveUntil(
                    context, HomeScreen.routeName, (route) => false);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget asdf() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 40, 30, 25),
      child: CommonButton(
        text: '홈으로',
        onPressed: () {
          _controller.addData({
            'time': DateTime.now().toString(),
            'day': _controller.dataList.length + 1,
            'ex1_name': widget.homeController.isSelected1 == true ? '풀업' : '친업',
            'ex2_name':
                widget.homeController.isSelected3 == true ? '푸쉬업' : '너클 푸쉬업',
            'ex1': widget.exerciseController.ex1,
            'ex2': widget.exerciseController.ex2,
          });
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (route) => false);
        },
      ),
    );
  }
}
