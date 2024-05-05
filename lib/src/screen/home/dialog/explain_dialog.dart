import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:flutter/material.dart';

class ExplainDialog {
  static void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              height: 300,
              decoration: BoxDecoration(
                color: context.isLight
                    ? LightModeColors.background
                    : DarkModeColors.dark4,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(children: [
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 40, // svgSize(24) + svgPadding(12)
                    ),
                    const Text(
                      '운동설명',
                      style: TextStyles.h2Bold,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                          )),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '운동방식',
                        style: TextStyles.b1Medium,
                      ),
                      SizedBox(height: 4),
                      Text(
                        '운동시작을 누르면 2개의 종목을 번갈아가며 6세트를 진행합니다. 한 세마다 자신이 수행할 수 있는 최대의 개수를 수행해주세요. 오늘의 기록을 전날의 기록과 비교해서 볼 수 있습니다. 전날보다 1개씩 더하는 걸 목표로 삼아보세요!',
                        style: TextStyles.b4Regular,
                      ),
                      SizedBox(height: 20),
                      Text(
                        '설정',
                        style: TextStyles.b1Medium,
                      ),
                      SizedBox(height: 4),
                      Text(
                        '운동항목 아이콘을 눌러 2개의 항목을 선택해주세요. 항목당 하나의 운동만 선택할 수 있습니다. 휴식시간은 2분으로 설정되어 있습니다.',
                        style: TextStyles.b4Regular,
                      ),
                    ],
                  ),
                )
              ]),
            ));
  }
}
