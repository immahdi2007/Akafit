import 'package:flutter/material.dart';

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
  String? _erorrText;
  final FocusNode _focusNode = FocusNode();
  bool _showError = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // obscure =

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        final error = validate(widget.controller.text);
        setState(() {
          _showError = true;
        });
      }
    });
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
    // else if (widget.validatorType == ValidatorType.verifyCode) {
    //   if (value == null || value.isEmpty) {
    //     return "لطفا کد را وارد کنید";
    //   }
    //   final RegExp verificationCodeRegex = RegExp(r'^\d{6}$');
    //   if (!verificationCodeRegex.hasMatch(value)) {
    //     return "کد تایید باید ۶ رقم باشد";
    //   }
    // }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
