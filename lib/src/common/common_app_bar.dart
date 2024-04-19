import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/common/common_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CommonAppBar({super.key, required this.title, this.isHome = false});

  final String title;
  final bool isHome;

  @override
  State<CommonAppBar> createState() => _CommonAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(44.0);
}

class _CommonAppBarState extends State<CommonAppBar> {
  @override
  Widget build(BuildContext context) {
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
          : const Padding(
              padding: EdgeInsets.fromLTRB(14, 14, 24, 14),
              child: CommonSvg(
                src: 'asset/svg/back.svg',
              ),
            ),
      actions: widget.isHome
          ? [
              const CommonSvg(src: 'asset/svg/user_info.svg'),
              const SizedBox(
                width: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: context.isLight
                    ? SvgPicture.asset('asset/svg/light_mode.svg')
                    : SvgPicture.asset('asset/svg/dark_mode.svg'),
              )
            ]
          : [
              const SizedBox(
                width: 72,
              )
            ],
    );
  }
}
