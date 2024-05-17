import 'package:escape_anchovy/main.dart';
import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/common/common_dialog.dart';
import 'package:escape_anchovy/src/common/common_svg.dart';
import 'package:escape_anchovy/src/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CommonAppBar(
      {super.key,
      required this.title,
      this.isHome = false,
      this.isExercise = false,
      this.settingController});

  final String title;
  final bool isHome;
  final bool isExercise;
  final SettingController? settingController;

  @override
  State<CommonAppBar> createState() => _CommonAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(44.0);
}

class _CommonAppBarState extends State<CommonAppBar> {
  @override
  Widget build(BuildContext context) {
    if (widget.isHome) {
      widget.settingController!.theme =
          context.isLight ? 'light_mode' : 'dark_mode';
    }

    return AppBar(
      backgroundColor: Colors.transparent,
      title: Center(
        child: Text(widget.title, style: TextStyles.h3Bold),
      ),
      leadingWidth: 72,
      leading: widget.isHome
          ? Padding(
              padding: const EdgeInsets.only(right: 8),
              child: SvgPicture.asset(
                context.isLight
                    ? 'asset/svg/app_logo.svg'
                    : 'asset/svg/dark_app_logo.svg',
                fit: BoxFit.scaleDown,
              ),
            )
          : widget.isExercise
              ? GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return homeDialog();
                        });
                  },
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(18, 12, 24, 12),
                    child: CommonSvg(
                      src: 'asset/svg/home.svg',
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(14, 14, 24, 14),
                    child: CommonSvg(
                      src: 'asset/svg/back.svg',
                    ),
                  ),
                ),
      actions: widget.isHome
          ? [
              const CommonSvg(src: 'asset/svg/user_info.svg'),
              const SizedBox(
                width: 12,
              ),
              GestureDetector(
                onTap: () {
                  if (widget.settingController!.theme == 'light_mode') {
                    widget.settingController!
                        .updateThemeMode(ThemeMode.dark, 'dark_mode');
                  } else {
                    widget.settingController!
                        .updateThemeMode(ThemeMode.light, 'light_mode');
                  }
                },
                child: SvgPicture.asset(
                  'asset/svg/${widget.settingController!.theme}.svg',
                ),
              ),
              const SizedBox(
                width: 16,
              ),
            ]
          : [
              const SizedBox(
                width: 72,
              )
            ],
    );
  }

  Widget homeDialog() {
    return CommonDialog(
        dialogHeight: 140,
        dialogPadding: 60,
        title: '홈화면으로 이동',
        titleSpacing: 18,
        explain: '작성한 운동기록이 초기화됩니다.\n홈 화면으로 이동하시겠습니까?',
        body: const SizedBox.shrink(),
        buttonText: '이동',
        buttonHeight: 38,
        onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false));
  }
}
