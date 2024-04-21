import 'package:escape_anchovy/res/text/colors.dart';
import 'package:escape_anchovy/res/text/styles.dart';
import 'package:escape_anchovy/src/common/common_button.dart';
import 'package:escape_anchovy/src/common/common_text_field.dart';
import 'package:escape_anchovy/src/common/common_validation_message.dart';
import 'package:escape_anchovy/src/screen/user_name/user_name_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserNameScreen extends StatefulWidget {
  const UserNameScreen({super.key});

  static const routeName = '/name';

  @override
  State<UserNameScreen> createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  final _controller = UserNameController();

  @override
  void initState() {
    super.initState();
    _controller.nameFocus.addListener(() {
      _controller.isNameInputting = _controller.nameFocus.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, snapshot) {
          return Scaffold(
            body: _buildPage(context),
          );
        });
  }

  Widget _buildPage(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('안녕하세요', style: TextStyles.h1Bold),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: '이름',
                            style: TextStyles.h1Bold.copyWith(
                                color: context.isLight
                                    ? LightModeColors.blue
                                    : DarkModeColors.blue),
                          ),
                          const TextSpan(
                              text: '을 입력해주세요', style: TextStyles.h1Bold)
                        ])),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                        child: SvgPicture.asset(context.isLight
                            ? 'asset/svg/user_icon.svg'
                            : 'asset/svg/dark_user_icon.svg')),
                    const SizedBox(
                      height: 50,
                    ),
                    CommonTextField(
                      maxLength: 8,
                      controller: _controller.nameController,
                      focusNode: _controller.nameFocus,
                      hintText: '이름 입력',
                      onChanged: (value) {
                        _controller.checkNameValidation(value);
                      },
                    ),
                    CommonValidationMessage(
                      isInputting: _controller.isNameInputting,
                      isValidation: _controller.isNameValid,
                      errorText: '이름을 8자 이하로 입력해주세요',
                      passText: '입력이 완료되었습니다',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 40, 30, 25),
            child: SizedBox(
                width: double.maxFinite,
                height: 50,
                child: CommonButton(
                    text: '완료',
                    onPressed: _controller.isNameValid
                        ? () => _controller.savedName(context)
                        : null)),
          ),
        )
      ],
    );
  }
}
