import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';

class CustomCheckbox extends StatefulWidget {
  final String title;
  final bool initialValue;
  final CustomCheckboxController controller;

  const CustomCheckbox({
    super.key,
    required this.title,
    this.initialValue = false,
    required this.controller,
  });

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool _value = false;

  @override
  void initState() {
    _value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _value = !_value;
        });
        widget.controller.setValue(_value);
      },
      child: Row(
        children: [
          Theme(
            data: ThemeData(unselectedWidgetColor: ColorStyles.primaryBlue),
            child: Checkbox(
              value: _value,
              onChanged: (value) {
                setState(() {
                  _value = value ?? false;
                });
                widget.controller.setValue(value ?? false);
              },
              checkColor: Colors.white,
              activeColor: ColorStyles.primaryBlue,
            ),
          ),
          Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              color: ColorStyles.primaryBlue,
            ),
          )
        ],
      ),
    );
  }
}

class CustomCheckboxController extends ChangeNotifier {
  bool value = false;

  void setValue(bool value) {
    this.value = value;
    notifyListeners();
  }
}
