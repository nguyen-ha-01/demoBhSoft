import 'package:flutter/material.dart';
import 'package:tiademo/core/app_color.dart';
import 'package:tiademo/core/app_textstyle.dart';

typedef TextMapper = String Function(String numberText);

class PmAmPicker extends StatefulWidget {
  /// Min value user can pick
  final String p1;

  /// Max value user can pick
  final String p2;

  /// Currently selected value
  final String value;

  /// Called when selected value changes
  final ValueChanged<String> onChanged;
  final double width, height;

  const PmAmPicker(
      {super.key,
      required this.p1,
      required this.p2,
      required this.value,
      required this.onChanged,
      required this.width,
      required this.height});

  @override
  State<PmAmPicker> createState() {
    // TODO: implement createState
    return _paState();
  }
}

class _paState extends State<PmAmPicker> with SingleTickerProviderStateMixin {
  _paState();
  bool selectedPost = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPost = !selectedPost;
        });
        widget.onChanged(selectedPost ? widget.p1 : widget.p2);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              width: widget.width,
              height: (selectedPost) ? widget.height * 0.7 : widget.height * 0.3,
              child: Text(
                widget.p1,
                style: (selectedPost)
                    ? AppTextStyle.type24
                    : AppTextStyle.type14.copyWith(color: AppColor.white.withOpacity(0.1)),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              width: widget.width,
              height: (selectedPost == false) ? widget.height * 0.7 : widget.height * 0.3,
              child: Text(
                widget.p2,
                style: (selectedPost == false)
                    ? AppTextStyle.type24
                    : AppTextStyle.type14.copyWith(color: AppColor.white.withOpacity(0.1)),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
