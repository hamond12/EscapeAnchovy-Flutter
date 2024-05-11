import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/common/common_app_bar.dart';
import 'package:escape_anchovy/src/screen/note/note_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  static const routeName = '/note';

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final _controller = NoteController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.initDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: '전체 일지 확인'),
      body: AnimatedBuilder(
          animation: _controller,
          builder: (context, snapshot) {
            return _buildPage(context);
          }),
    );
  }

  Widget _buildPage(BuildContext context) {
    return NestedScrollView(
      physics: const NeverScrollableScrollPhysics(),
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [];
      },
      body: _controller.dataList.isEmpty
          ? Center(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.24),
                  SvgPicture.asset(
                    'asset/svg/no_data.svg',
                    height: 150,
                    colorFilter: ColorFilter.mode(
                      context.isLight
                          ? LightModeColors.dark3
                          : DarkModeColors.dark3,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    '운동기록이 없습니다',
                    style: TextStyles.h3Medium.copyWith(
                        color: context.isLight
                            ? LightModeColors.dark3
                            : DarkModeColors.dark3),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    '운동시작을 눌러 일지를 작성해보세요',
                    style: TextStyles.b2Regular.copyWith(
                        color: context.isLight
                            ? const Color(0XFFADA8B0)
                            : const Color(0XFF8A848D)),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Text('7일 이상 운동을 하지 않으면 일지가 초기화됩니다.',
                        style: TextStyles.caption1.copyWith(
                            color: context.isLight
                                ? LightModeColors.red
                                : DarkModeColors.red)),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 38.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: ListView.separated(
                              padding: EdgeInsets.zero,
                              controller: _scrollController,
                              itemBuilder: (context, index) {
                                final data = _controller.dataList[index];

                                int sum(List list) {
                                  return list.reduce(
                                      (value, element) => value + element);
                                }

                                List exList(data, ex) {
                                  return [
                                    data[ex][0],
                                    data[ex][1],
                                    data[ex][2]
                                  ];
                                }

                                List pullUpSumList = [];
                                List chinUpSumList = [];
                                List pushUpSumList = [];
                                List nucklePushUpSumList = [];

                                List pullUpList = [];
                                List chinUpList = [];
                                List pushUpList = [];
                                List nucklePushUpList = [];

                                for (int i = 0; i <= index; i++) {
                                  Map<String, dynamic> data =
                                      _controller.dataList[i];

                                  if (data['ex1_name'] == '풀업') {
                                    pullUpSumList.add(sum(data['ex1']));
                                    pullUpList.add(exList(data, 'ex1'));
                                  }
                                  if (data['ex1_name'] == '친업') {
                                    chinUpSumList.add(sum(data['ex1']));
                                    chinUpList.add(exList(data, 'ex1'));
                                  }
                                  if (data['ex2_name'] == '푸쉬업') {
                                    pushUpSumList.add(sum(data['ex2']));
                                    pushUpList.add(exList(data, 'ex2'));
                                  }
                                  if (data['ex2_name'] == '너클 푸쉬업') {
                                    nucklePushUpSumList.add(sum(data['ex2']));
                                    nucklePushUpList.add(exList(data, 'ex2'));
                                  }
                                }

                                bool isSameList(List list1, List list2) {
                                  for (int i = 0; i < list1.length; i++) {
                                    if (list1[i] != list2[i]) {
                                      return false;
                                    }
                                  }
                                  return true;
                                }

                                bool checkNotFirstEx1() {
                                  if (data['ex1_name'] == '풀업') {
                                    return !isSameList(
                                        pullUpList[0], data['ex1']);
                                  }
                                  return !isSameList(
                                      chinUpList[0], data['ex1']);
                                }

                                bool checkNotFirstEx2() {
                                  if (data['ex2_name'] == '푸쉬업') {
                                    return !isSameList(
                                        pushUpList[0], data['ex2']);
                                  }
                                  return !isSameList(
                                      nucklePushUpList[0], data['ex2']);
                                }

                                int substarct(sumList) {
                                  if (sumList.length > 1) {
                                    return sumList[sumList.length - 1] -
                                        sumList[sumList.length - 2];
                                  }
                                  return 0;
                                }

                                int returnSubtract1() {
                                  if (data['ex1_name'] == '풀업') {
                                    return substarct(pullUpSumList);
                                  }
                                  if (data['ex1_name'] == '친업') {
                                    return substarct(chinUpSumList);
                                  } else {
                                    return 0;
                                  }
                                }

                                int returnSubtract2() {
                                  if (data['ex2_name'] == '푸쉬업') {
                                    return substarct(pushUpSumList);
                                  }
                                  if (data['ex2_name'] == '너클 푸쉬업') {
                                    return substarct(nucklePushUpSumList);
                                  } else {
                                    return 0;
                                  }
                                }

                                Widget returnString1() {
                                  if (returnSubtract1() > 0) {
                                    return Text(
                                      '${returnSubtract1()}↑',
                                      style: TextStyles.b3Bold.copyWith(
                                          color: context.isLight
                                              ? LightModeColors.red
                                              : DarkModeColors.red),
                                    );
                                  } else if (returnSubtract1() < 0) {
                                    return Text(
                                      '${-1 * returnSubtract1()}↓',
                                      style: TextStyles.b3Bold.copyWith(
                                          color: context.isLight
                                              ? LightModeColors.blue
                                              : DarkModeColors.blue),
                                    );
                                  } else {
                                    return Text('0',
                                        style: TextStyles.b3Bold.copyWith(
                                            color: context.isLight
                                                ? LightModeColors.dark3
                                                : DarkModeColors.dark3));
                                  }
                                }

                                Widget returnString2() {
                                  if (returnSubtract2() > 0) {
                                    return Text(
                                      '${returnSubtract2()}↑',
                                      style: TextStyles.b3Bold.copyWith(
                                          color: context.isLight
                                              ? LightModeColors.red
                                              : DarkModeColors.red),
                                    );
                                  } else if (returnSubtract2() < 0) {
                                    return Text(
                                      '${-1 * returnSubtract2()}↓',
                                      style: TextStyles.b3Bold.copyWith(
                                          color: context.isLight
                                              ? LightModeColors.blue
                                              : DarkModeColors.blue),
                                    );
                                  } else {
                                    return Text('0',
                                        style: TextStyles.b3Bold.copyWith(
                                            color: context.isLight
                                                ? LightModeColors.dark3
                                                : DarkModeColors.dark3));
                                  }
                                }

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      contentPadding:
                                          const EdgeInsets.only(left: 2),
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${data['day']}일차',
                                            style: TextStyles.b2Medium,
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                        ],
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                '${data['ex1_name']}',
                                                style: TextStyles.b3Medium,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                '${data['ex1'].join('  ')}',
                                                style: TextStyles.b3Regular,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '(${sum(data['ex1'])}개)',
                                                style: TextStyles.b3Regular
                                                    .copyWith(
                                                        color: context.isLight
                                                            ? LightModeColors
                                                                .dark3
                                                            : DarkModeColors
                                                                .dark3),
                                              ),
                                              const SizedBox(
                                                width: 7,
                                              ),
                                              data['day'] != 1 &&
                                                      checkNotFirstEx1()
                                                  ? returnString1()
                                                  : const SizedBox.shrink()
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${data['ex2_name']}',
                                                style: TextStyles.b3Medium,
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                '${data['ex2'].join('  ')}',
                                                style: TextStyles.b3Regular,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '(${sum(data['ex2'])}개)',
                                                style: TextStyles.b3Regular
                                                    .copyWith(
                                                        color: context.isLight
                                                            ? LightModeColors
                                                                .dark3
                                                            : DarkModeColors
                                                                .dark3),
                                              ),
                                              const SizedBox(
                                                width: 7,
                                              ),
                                              data['day'] != 1 &&
                                                      checkNotFirstEx2()
                                                  ? returnString2()
                                                  : const SizedBox.shrink(),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Divider(
                                  color: Color(0xFFEAEAEA),
                                  height: 4,
                                );
                              },
                              itemCount: _controller.dataList.length),
                        )),
                  ],
                )),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _scrollController.jumpTo(0.0);
                          },
                          child: Text(
                            '↑ 맨 위로',
                            style: TextStyles.b1Regular.copyWith(
                                color: context.isLight
                                    ? LightModeColors.dark2
                                    : DarkModeColors.dark2),
                          ),
                        ),
                        const SizedBox(width: 50),
                        GestureDetector(
                          onTap: () {
                            _scrollController.jumpTo(
                                _scrollController.position.maxScrollExtent);
                          },
                          child: Text(
                            '↓ 맨 아래로',
                            style: TextStyles.b1Regular.copyWith(
                                color: context.isLight
                                    ? LightModeColors.dark2
                                    : DarkModeColors.dark2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

// Widget asdf() {
//   return 
// }
