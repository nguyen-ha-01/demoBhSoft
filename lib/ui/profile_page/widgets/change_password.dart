import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/core/app_textstyle.dart';
import 'package:tiademo/ui/login_signup_page/signup_page/signup_page.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  _ChangePasswordState();
  final key = GlobalKey<FormState>();
  final TextEditingController oldPassword = TextEditingController(), newPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Form(
        key: key,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(color: AppColor.dialog_background, borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tr('profile.7'),
                style: AppTextStyle.type20.copyWith(fontWeight: FontWeight.w700),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Divider(
                  color: AppColor.border,
                  height: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: inputField(isPassword: true, oldPassword, tr('profile.16'), tr('profile.16'), (s) {
                  return null;
                }, () {}, type: TextInputType.visiblePassword),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: inputField(isPassword: true, newPassword, tr('profile.17'), tr('profile.17'), (s) {
                  final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
                  if (s != null) {
                    if (!passwordRegex.hasMatch(s)) {
                      return 'password must have at least one uppercase, one number, and special character';
                    }
                  }
                  return null;
                }, () {
                  key.currentState!.validate();
                }, type: TextInputType.visiblePassword),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, left: 14, right: 14),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: SizedBox(
                              height: 48,
                              child: Center(
                                  child: Text(
                                'commons.l2'.tr(),
                                style: AppTextStyle.type20,
                              )))),
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Map<String, dynamic> data = {};

                            Navigator.pop(context, data);
                          },
                          child: SizedBox(
                              height: 48,
                              child: Center(
                                  child: Text(
                                'detail.l10'.tr(),
                                style: AppTextStyle.type20,
                              )))),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
