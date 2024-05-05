import 'package:escape_anchovy/main.dart';
import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/common/common_app_bar.dart';
import 'package:escape_anchovy/src/common/common_outline_button.dart';
import 'package:escape_anchovy/src/screen/home/dialog/explain_dialog.dart';
import 'package:escape_anchovy/src/screen/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.settingController});

  static const routeName = '/home';

  final SettingController settingController;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: '메인화면',
        isHome: true,
        settingController: widget.settingController,
      ),
      body: AnimatedBuilder(
          animation: _controller,
          builder: (context, snapshot) {
            return _buildPage(context);
          }),
    );
  }

  Widget _buildPage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(context.isLight
                            ? 'asset/svg/heart.svg'
                            : 'asset/svg/dark_heart.svg'),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '운동하기',
                          style: TextStyles.b1Medium.copyWith(
                              color: context.isLight
                                  ? DarkModeColors.background
                                  : LightModeColors.background),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: () {
                            ExplainDialog.showBottomSheet(context);
                          },
                          child: Text(
                            '(자세한 설명 보기)',
                            style: TextStyles.b3Regular.copyWith(
                                color: context.isLight
                                    ? LightModeColors.dark2
                                    : DarkModeColors.dark2),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(context.isLight
                            ? 'asset/svg/exercise_category.svg'
                            : 'asset/svg/dark_exercise_category.svg'),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          '운동항목',
                          style: TextStyles.b1Regular.copyWith(
                              color: context.isLight
                                  ? DarkModeColors.background
                                  : LightModeColors.background),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                CommonOutlineButton(
                  width: 180,
                  height: 40,
                  onPressed: () {},
                  text: '운동시작',
                  textStyle: TextStyles.b1Medium,
                  borderRadius: 8,
                ),
              ],
            ),
          ),
          divideSection(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          SvgPicture.asset(context.isLight
                              ? 'asset/svg/note.svg'
                              : 'asset/svg/dark_note.svg'),
                          const SizedBox(
                            width: 9,
                          ),
                          Text(
                            '최근 일지 확인',
                            style: TextStyles.b1Medium.copyWith(
                                color: context.isLight
                                    ? DarkModeColors.background
                                    : LightModeColors.background),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            '(3일)',
                            style: TextStyles.b3Regular.copyWith(
                                color: context.isLight
                                    ? LightModeColors.dark2
                                    : DarkModeColors.dark2),
                          )
                        ],
                      ),
                    ),
                    CommonOutlineButton(
                      width: 65,
                      height: 18,
                      onPressed: () {},
                      text: '전체 일지 확인',
                      textStyle: TextStyles.caption2.copyWith(height: 0.01),
                    )
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '당신의 성장과정을 살펴보세요.',
                      style: TextStyles.b3Regular.copyWith(
                          color: context.isLight
                              ? LightModeColors.dark2
                              : DarkModeColors.dark2),
                    ),
                  ],
                ),
                Center(
                    child: Column(
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    SvgPicture.asset(
                      'asset/svg/no_data.svg',
                      colorFilter: ColorFilter.mode(
                          context.isLight
                              ? LightModeColors.dark3
                              : DarkModeColors.dark3,
                          BlendMode.srcIn),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      '운동기록이 없습니다',
                      style: TextStyles.b2Medium.copyWith(
                          color: context.isLight
                              ? LightModeColors.dark3
                              : DarkModeColors.dark3),
                    ),
                    Text(
                      '운동시작을 눌러 일지를 작성해보세요',
                      style: TextStyles.b4Regular.copyWith(
                          color: context.isLight
                              ? const Color(0XFFADA8B0)
                              : const Color(0XFF8A848D)),
                    ),
                  ],
                ))
              ],
            ),
          ),
          divideSection(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          SvgPicture.asset(context.isLight
                              ? 'asset/svg/challenges.svg'
                              : 'asset/svg/dark_challenges.svg'),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            '도전과제',
                            style: TextStyles.b1Medium.copyWith(
                                color: context.isLight
                                    ? DarkModeColors.background
                                    : LightModeColors.background),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          CommonOutlineButton(
                            width: 65,
                            height: 18,
                            onPressed: () {},
                            text: '전체 업적 확인',
                            textStyle:
                                TextStyles.caption2.copyWith(height: 0.01),
                            textColor: context.isLight
                                ? LightModeColors.yellow
                                : DarkModeColors.yellow,
                            borderColor: context.isLight
                                ? LightModeColors.yellow
                                : DarkModeColors.yellow,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  '운동을 완료하고 도전과제를 달성해보세요.',
                  style: TextStyles.b3Regular.copyWith(
                      color: context.isLight
                          ? LightModeColors.dark2
                          : DarkModeColors.dark2),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: '고등어 ',
                    style: TextStyles.b3Regular.copyWith(
                        color: context.isLight
                            ? LightModeColors.blue
                            : DarkModeColors.blue),
                  ),
                  TextSpan(
                    text: '도전과제를 달성하면 무언가 바뀔수도?',
                    style: TextStyles.b3Regular.copyWith(
                        color: context.isLight
                            ? LightModeColors.dark2
                            : DarkModeColors.dark2),
                  )
                ])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget divideSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Container(
            height: 8,
            color:
                context.isLight ? LightModeColors.dark4 : DarkModeColors.dark4,
          ),
        ),
      ],
    );
  }
}
