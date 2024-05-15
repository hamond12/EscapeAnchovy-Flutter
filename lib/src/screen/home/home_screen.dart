import 'dart:async';

import 'package:escape_anchovy/main.dart';
import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/common/common_app_bar.dart';
import 'package:escape_anchovy/src/common/common_button.dart';
import 'package:escape_anchovy/src/common/common_outline_button.dart';
import 'package:escape_anchovy/src/screen/home/dialog/ex_category_dialog.dart';
import 'package:escape_anchovy/src/screen/home/dialog/explain_dialog.dart';
import 'package:escape_anchovy/src/screen/home/home_controller.dart';
import 'package:escape_anchovy/src/screen/note/note_screen.dart';
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
  void initState() {
    super.initState();
    _controller.initDataList();

    _controller.timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _controller.checkTimeDifference(context);
    });
    
    _controller.initCategory();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.timer.cancel();
  }

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
                    onTap: () {
                      showDialog(context: context, builder: (BuildContext context) => ExCategoryDialog(homeController: _controller,));
                    },
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
                      onPressed: () {
                        Navigator.pushNamed(context, NoteScreen.routeName);
                      },
                      text: '전체 일지 확인',
                      textStyle: TextStyles.caption2.copyWith(height: 0.01)
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
                     _controller.dataList.isEmpty
                          ? const SizedBox.shrink()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '일지 초기화까지',
                                  style: TextStyles.caption1.copyWith(
                                      color: context.isLight
                                          ? LightModeColors.red
                                          : DarkModeColors.red),
                                ),
                                Text(
                                  _controller.formatDuration(_controller.noteInitTime().difference(DateTime.now())),
                                  style: TextStyles.caption1.copyWith(
                                      color: context.isLight
                                          ? LightModeColors.red
                                          : DarkModeColors.red),
                                ),
                              ],
                            )
                  ],
                ),
                Center(
                  child: _controller.dataList.isEmpty
                      ? Column(
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
                        )
                      : SizedBox(
                          height: _controller.returnListViewHeight(),
                          child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final data = _controller.dataList.length > 3
                                    ? _controller.dataList[
                                        index + _controller.dataList.length - 3]
                                    : _controller.dataList[index];

                                int sum1 = (data['ex1'][0] +
                                    data['ex1'][1] +
                                    data['ex1'][2]);

                                int sum2 = data['ex2'][0] +
                                    data['ex2'][1] +
                                    data['ex2'][2];

                                return ListTile(
                                  contentPadding:
                                      const EdgeInsets.only(left: 2),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '${data['day']}일차',
                                            style: TextStyles.b3Medium,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '${data['ex1_name']}',
                                            style: TextStyles.b4Medium,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            '${data['ex1'].join('  ')}',
                                            style: TextStyles.b4Regular,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '($sum1개)',
                                            style: TextStyles.b4Regular
                                                .copyWith(
                                                    color: context.isLight
                                                        ? LightModeColors.dark3
                                                        : DarkModeColors.dark3),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${data['ex2_name']}',
                                            style: TextStyles.b4Medium,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            '${data['ex2'].join('  ')}',
                                            style: TextStyles.b4Regular,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '($sum2개)',
                                            style: TextStyles.b4Regular
                                                .copyWith(
                                                    color: context.isLight
                                                        ? LightModeColors.dark3
                                                        : DarkModeColors.dark3),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Column(
                                  children: [
                                    Divider(
                                      color: Color(0xFFEAEAEA),
                                      height: 4,
                                    )
                                  ],
                                );
                              },
                              itemCount: _controller.dataList.length > 3
                                  ? 3
                                  : _controller.dataList.length),
                        ),
                )
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonButton(
                      width: 140,
                      text: '데이터 추가',
                      onPressed: () {
                        _controller.addData({
                          'time': DateTime.now().toString(),
                          'day': _controller.dataList.length + 1,
                          'ex1_name': '풀업',
                          'ex2_name': '푸쉬업',
                          'ex1': [11, 8, 5],
                          'ex2': [30, 22, 12]
                        });
                      },
                    ),
                    CommonButton(
                      width: 140,
                      text: '데이터 삭제',
                      onPressed: () {
                        _controller.deleteData();
                      },
                    )
                  ],
                )
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
