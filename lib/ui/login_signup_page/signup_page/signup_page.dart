import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:tiademo/common/widget/loading.dart';
import 'package:tiademo/common/widget/outline_button.dart';
import 'package:tiademo/common/widget/text_input_item.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/core/app_textstyle.dart';
import 'package:tiademo/gen/assets.gen.dart';
import 'package:tiademo/routes/named_route.dart';
import 'package:tiademo/states/state/base_state.dart';
import 'package:tiademo/states/user_provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  _SignupPageState();

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<UserProvider>(
        builder: (BuildContext context, UserProvider p, Widget? child) {
          if (p.authState.status == Status.LOADING) {
            return loading();
          }
          if (p.authState.status == Status.COMPLETED) Future.microtask(() => Get.offNamed(NamedRoutes.home_page));
          return SafeArea(child: Form(key: _formKey, child: initWidget(p)));
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _username.dispose();
    _password.dispose();
    _confirmPass.dispose();

    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  Widget initWidget(UserProvider p) => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: SvgPicture.asset(
                  Assets.icon.icRegisterArrBack,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
                onTap: () {
                  Get.back();
                },
              ),
              const SizedBox(
                height: 13,
              ),
              const Spacer(
                flex: 1,
              ),
              Text(
                tr('register.l1'),
                style: AppTextStyle.type24.copyWith(fontSize: 32, fontWeight: FontWeight.w700, color: AppColor.white),
              ),
              const Spacer(
                flex: 1,
              ),
              inputField(
                _username,
                tr('register.l2'),
                tr('register.h1'),
                (s) {
                  return null;
                },
                () {},
              ),
              const SizedBox(
                height: 25,
              ),
              inputField(isPassword: true, _password, tr('register.l3'), tr('register.h2'), (s) {
                final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
                if (s != null) {
                  if (!passwordRegex.hasMatch(s)) {
                    return 'password must have at least one uppercase, one number, and special character';
                  }
                }
                return null;
              }, () {
                _formKey.currentState!.validate();
              }, type: TextInputType.visiblePassword),
              const SizedBox(
                height: 25,
              ),
              inputField(
                action: TextInputAction.done,
                isPassword: true,
                _confirmPass,
                tr('register.l4'),
                tr('register.h2'),
                (s) {
                  if (_confirmPass.text.isNotEmpty) {
                    if (_confirmPass.text != _password.text) return 'type a wrong password';
                  }
                  return null;
                },
                () {
                  if (_password.text == _confirmPass.text) {
                    Future.microtask(() => p.register(_username.text, _password.text));
                  }
                },
                type: TextInputType.visiblePassword,
              ),
              const Spacer(
                flex: 2,
              ),
              GestureDetector(
                onTap: () async {
                  p.register(_username.text, _password.text);
                  // if (_formKey.currentState!.validate()) {
                  //   showModalBottomSheet(
                  //       context: context,
                  //       builder: (c) {
                  //         return Column(
                  //           children: [
                  //             Text(_username.text),
                  //             Text(_confirmPass.text),
                  //             Text(_password.text),
                  //           ],
                  //         );
                  //       });
                  // }
                },
                child: Container(
                  height: 48,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: (_formKey.currentState?.validate() ?? false)
                          ? AppColor.primary
                          : AppColor.primary.withAlpha(125),
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                      child: Text(tr('register.l1'), style: AppTextStyle.type20.copyWith(color: AppColor.white))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(child: Divider(color: AppColor.border)),
                  Text(
                    tr('register.l5'),
                    style: AppTextStyle.type14.copyWith(color: AppColor.border),
                  ),
                  const Expanded(child: Divider(color: AppColor.border)),
                ],
              ),
              const SizedBox(
                height: 17,
              ),
              OutlineBtn(
                onTap: () {
                  p.registerGoogle();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Assets.icon.icCommonGoogle,
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      'register.l6'.tr(),
                      style: AppTextStyle.type16,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 17,
              ),
              OutlineBtn(
                onTap: () {
                  Future.microtask(() => p.registerAppple());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Assets.icon.icCommonApple,
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      'register.l7'.tr(),
                      style: AppTextStyle.type16,
                    )
                  ],
                ),
              ),
              const Spacer(),
              //have account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'register.l8'.tr(),
                    style: AppTextStyle.type14,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(NamedRoutes.login_page);
                    },
                    child: Text(
                      'register.l9'.tr(),
                      style: AppTextStyle.type16.copyWith(color: AppColor.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );

  Widget inputField(TextEditingController editingController, String title, String hint,
      String? Function(String?)? validate, Function() onchange,
      {TextInputType? type, bool? isPassword, TextInputAction? action}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.type16,
        ),
        const SizedBox(
          height: 8,
        ),
        TextInputItem(
          action: action ?? TextInputAction.next,
          keyboard: type,
          validate: validate,
          hint: hint,
          onChange: (v) {
            onchange();
            if (kDebugMode) {
              print("do on change");
            }
          },
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColor.border),
          ),
          controller: editingController,
          isObscured: isPassword,
        )
      ],
    );
  }
}
