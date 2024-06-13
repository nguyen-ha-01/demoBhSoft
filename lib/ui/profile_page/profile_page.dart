import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:tiademo/common/extend/p1.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/core/app_textstyle.dart';
import 'package:tiademo/gen/assets.gen.dart';
import 'package:tiademo/models/category.dart';
import 'package:tiademo/models/task.dart';
import 'package:tiademo/routes/named_route.dart';
import 'package:tiademo/ui/profile_page/widgets/change_account_image.dart';
import 'package:tiademo/ui/profile_page/widgets/change_account_name.dart';
import 'package:tiademo/ui/profile_page/widgets/change_password.dart';
import 'package:tiademo/ui/profile_page/widgets/item_btn.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  _ProfilePageState();

  final Category category = getCategory();
  final Task task = getTask();
  bool selected = false;
  final TextEditingController text = TextEditingController();
  String st = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 24,
          ),
          ClipOval(
            child: CachedNetworkImage(
              imageUrl:
                  'https://imgs.search.brave.com/-jHWwHofclTL1XeOMoUohiY3ChOKDoxonXzBRcQqCcA/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9zbWFz/aC1pbWFnZXMucGhv/dG9ib3guY29tL29w/dGltaXNlZC9kODEz/OTkyOWE3NWRhYjJl/ZmIxYWQ1MmQ3Zjg1/ZmEzZmM2NWY1MDQ1/X2ZpbGVfZGVza3Rv/cF9VS19XMjJfTUVS/Q0hfQkxPQ0tfMl81/NzYweDQ1MTIuanBn',
              width: 85,
              height: 85,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          showTaskProcess(),
          const SizedBox(
            height: 32,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'profile.4'.tr(),
                style: const TextStyle(
                  color: Color(0xFFAFAFAF),
                  fontSize: 14,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                  height: 0.11,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ItemBtn(
              iconR: Assets.icon.icPSetting,
              title: tr('profile.5'),
              onTab: () async {
                Get.toNamed(NamedRoutes.setting_page);
              }),
          const SizedBox(
            height: 26,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'profile.6'.tr(),
                style: const TextStyle(
                  color: Color(0xFFAFAFAF),
                  fontSize: 14,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                  height: 0.11,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ItemBtn(
              iconR: Assets.icon.icHomeNav4,
              title: tr('profile.7'),
              onTab: () async {
                Map<String, dynamic>? data =
                    await showDialog(context: context, builder: (context) => ChangeAccountName(name: "name"));
                if (data != null) {
                  var name = data['name'];
                  // todo:change use name with name
                }
              }),
          const SizedBox(
            height: 32,
          ),
          ItemBtn(
              iconR: Assets.icon.icPKey,
              title: tr('profile.8'),
              onTab: () async {
                showDialog(context: context, builder: (context) => const ChangePassword());
              }),
          const SizedBox(
            height: 32,
          ),
          ItemBtn(
              iconR: Assets.icon.icPChangeImage,
              title: tr('profile.9'),
              onTab: () async {
                showModalBottomSheet(
                    context: context,
                    builder: (c) {
                      return changeAccountImage();
                    });
              }),
          const SizedBox(
            height: 28,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'profile.10'.tr(),
                style: const TextStyle(
                  color: Color(0xFFAFAFAF),
                  fontSize: 14,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                  height: 0.11,
                ),
              ),
            ),
          ),
          ItemBtn(iconR: Assets.icon.icPAbout, title: tr('profile.11'), onTab: () {}),
          const SizedBox(
            height: 32,
          ),
          ItemBtn(iconR: Assets.icon.icPFag, title: tr('profile.12'), onTab: () {}),
          const SizedBox(
            height: 32,
          ),
          ItemBtn(iconR: Assets.icon.icPHelp, title: tr('profile.13'), onTab: () {}),
          const SizedBox(
            height: 32,
          ),
          ItemBtn(iconR: Assets.icon.icPSupport, title: tr('profile.14'), onTab: () {}),
          const SizedBox(
            height: 32,
          ),
          ItemBtn(iconR: Assets.icon.icPLogout, title: tr('profile.15'), onTab: () {}),
          const SizedBox(
            height: 32,
          )
        ],
      ),
    );
  }

  showTaskProcess() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 58,
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 17),
            decoration: ShapeDecoration(
              color: AppColor.dialog_background,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '10 Task left',
                  style: AppTextStyle.type16,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            height: 58,
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 17),
            decoration: ShapeDecoration(
              color: AppColor.dialog_background,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '5 Task done',
                  style: AppTextStyle.type16,
                ),
              ],
            ),
          )
        ],
      );
}
