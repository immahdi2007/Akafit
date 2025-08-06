import 'package:akafit/view/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

enum ValidatorType { none, phone, password }

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.text,
    required this.text_icon,
    required this.controller,
    required this.validatorType,
    this.onErrorChange,
  });

  final String text;
  final String text_icon;
  final TextEditingController controller;
  final ValidatorType validatorType;
  final Function(bool hasError)? onErrorChange;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool obscure = false;
  String? _errorText;
  final FocusNode _focusNode = FocusNode();
  bool _showError = false;
  String finalEnValeu = '';

  String ToFa(String input) {
    const en = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const fa = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    for (int i = 0; i < en.length; i++) {
      input = input.replaceAll(en[i], fa[i]);
    }
    return input;
  }

  String ToEn(String input) {
    const en = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const fa = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    for (int i = 0; i < fa.length; i++) {
      input = input.replaceAll(fa[i], en[i]);
    }
    return input;
  }

  @override
  void initState() {
    // TODO: implement initState  
    super.initState();
    obscure = isPassword;

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        final error = validate(finalEnValeu);
        setState(() {
          _showError = true;
          _errorText = error;
        });
      }
    });

    widget.controller.addListener(() {
      final error = validate(finalEnValeu);
      if (error != _errorText) {
        _errorText = error;
        widget.onErrorChange?.call(error != null);
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focusNode.dispose();
  }

  String? validate(String value) {
    if (widget.validatorType == ValidatorType.phone) {
      if (value == null || value.isEmpty) {
        return "لطفا این فیلد را پر کنید";
      }
      final ph_regex = RegExp(
        r'^((0?9)|(\+?989))((14)|(13)|(12)|(19)|(18)|(17)|(15)|(16)|(11)|(10)|(90)|(91)|(92)|(93)|(94)|(95)|(96)|(32)|(30)|(33)|(35)|(36)|(37)|(38)|(39)|(00)|(01)|(02)|(03)|(04)|(05)|(41)|(20)|(21)|(22)|(23)|(31)|(34)|(9910)|(9911)|(9913)|(9914)|(9999)|(999)|(990)|(9810)|(9811)|(9812)|(9813)|(9814)|(9815)|(9816)|(9817)|(998))\d{7}$',
      );
      if (!ph_regex.hasMatch(value)) {
        return "شماره همراه نامعتبر است";
      }
    } else if (widget.validatorType == ValidatorType.password) {
      if (value == null || value.isEmpty) {
        return "پسورد را وارد کنید";
      }
      if (value.length < 6) {
        return "پسورد باید حداقل 6 حرف داشته باشد";
      }
    }
    
    return null;
  }

  bool get isPhone => widget.validatorType == ValidatorType.phone;
  bool get isPassword => widget.validatorType == ValidatorType.password;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isPhone ? TextDirection.ltr : TextDirection.rtl,
      child: Column(
        children: [
          TextField(
            focusNode: _focusNode,
            controller: widget.controller,
            onChanged: (value) {
              finalEnValeu = ToEn(value);
              final newValue = ToFa(finalEnValeu);
              final cursorPos = widget.controller.selection;
              widget.controller.value = TextEditingValue(
                text: newValue,
                selection: cursorPos,
              );
            },
            style: TextStyle(fontSize: 20.sp.clamp(16, 24)),
            obscureText: obscure,
            keyboardType: isPhone ? TextInputType.numberWithOptions() : TextInputType.text,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              filled: true,
              fillColor: AppColors.grayBg,
              border: OutlineInputBorder(
                borderRadius: AppRadius.radius_5,
                borderSide: BorderSide(
                  color: (_showError && _errorText != null) ? AppColors.errorColor : AppColors.primary,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: AppRadius.radius_5,
                borderSide: BorderSide(
                  color: (_showError && _errorText != null) ? AppColors.errorColor : AppColors.primary,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: AppRadius.radius_5,
                borderSide: BorderSide(
                  color: (_showError && _errorText != null) ? AppColors.errorColor : AppColors.primary,
                  width: 1,
                ),
              ),

              hintText: widget.text,
              hintStyle: TextStyle(color: AppColors.hintColor, fontSize: 16.sp.clamp(12, 20), letterSpacing: -0.5),
              prefixIcon: Container(
                margin: EdgeInsets.only(
                  left: !isPhone ? 0 : 10,
                  right: isPhone ? 0 : 10,
                ),
                child: SvgPicture.network(
                  widget.text_icon,
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                  color: AppColors.hintColor,
                ),
              ),
              suffixIcon: isPassword
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          obscure = !obscure;
                        });
                      },
                      icon: obscure
                          ? Icon(Icons.visibility, size: 30.0)
                          : Icon(Icons.visibility_off, size: 30.0),
                    )
                  : null,
            ),
          ),
          if (_showError && _errorText != null)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(_errorText!, style: TextStyle(color: AppColors.errorColor)),
            ),
        ],
      ),
    );
  }
}
