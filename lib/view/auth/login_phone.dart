import 'dart:ui';

import 'package:akafit/view/animations/animated_visibility.dart';
import 'package:akafit/view/theme.dart';
import 'package:akafit/view/widgets/app_text_field.dart';
import 'package:akafit/view/widgets/opt_code.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

enum loginStep { enterPhone, enterCode, name }

class LoginPhone extends StatefulWidget {
  LoginPhone({super.key});

  @override
  State<LoginPhone> createState() => _LoginPhoneState();
}

class _LoginPhoneState extends State<LoginPhone> {
  loginStep _step = loginStep.enterPhone;
  late FocusNode _pinFocusNode;
  String _phone_number = '';
  bool _isLoading = false;

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _verifyCodeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String? _pinHasError;
  bool _hasError = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pinFocusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _pinFocusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pinFocusNode.dispose();
    super.dispose();
    _phoneController.dispose();
    _verifyCodeController.dispose();
    _nameController.dispose();
  }

  void _nextStep() {
    setState(() {
      switch (_step) {
        case loginStep.enterPhone:
          _step = loginStep.enterCode;
          break;
        case loginStep.enterCode:
          _step = loginStep.name;
          break;
        case loginStep.name:
          break;
      }
    });
  }

  bool get enterPhone => _step == loginStep.enterPhone;
  bool get enterCode => _step == loginStep.enterCode;
  bool get enterName => _step == loginStep.name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(190, 0, 0, 0),
      body: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: const Color.fromARGB(28, 0, 0, 0)),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Spacer(flex: 1),
                  FadeInUp(
                    key: ValueKey(_step),
                    curve: Curves.easeOutBack,
                    delay: AppDelay.textFeild,
                    duration: AppDuration.textFeild,
                    child: Column(
                      children: [
                        Text(
                          enterPhone
                              ? "شماره تلفن خود را وارد کنید"
                              : enterCode
                              ? "کد تأیید را وارد کنید"
                              : "نام خود را وارد کنید",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(height: sizedBox.large.h),
                        SizedBox(
                          width: 1.sw.clamp(1.0, 500.0),
                          child: enterPhone || enterName
                              ? AppTextField(
                                  text: enterPhone
                                      ? "شماره تلفن"
                                      : enterName
                                      ? "نام و نام خانوادگی"
                                      : null!,
                                  text_icon: enterPhone
                                      ? 'assets/icons/num_code.svg'
                                      : "",
                                  controller: enterPhone
                                      ? _phoneController
                                      : _nameController,
                                  validatorType: enterPhone
                                      ? ValidatorType.phone
                                      : ValidatorType.name,
                                  onErrorChange: (hasError) {
                                    setState(() {
                                      _hasError = hasError;
                                    });
                                  },
                                )
                              : enterCode
                              ? Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Column(
                                    children: [
                                      Text(
                                        "کد تأیید برای شماره $_phone_number ارسال شد",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w100,
                                        ),
                                      ),
                                      SizedBox(height: sizedBox.medium.h),

                                      OptCodeWidget(
                                        hasError: _pinHasError,
                                        focusNode: _pinFocusNode,
                                        controller: _verifyCodeController,
                                        onCompleted: (value) {
                                          Future.delayed(
                                            Duration(milliseconds: 100),
                                            () {
                                              _pinFocusNode.requestFocus();
                                            },
                                          );
                                          bool isValid = value == '00000';
                                          if (!isValid) {
                                            setState(() {
                                              _verifyCodeController.clear();
                                              _pinHasError =
                                                  "کد وارد شده ناصحیح میباشد";
                                            });
                                            Future.delayed(
                                              Duration(milliseconds: 100),
                                              () {
                                                _pinFocusNode.requestFocus();
                                              },
                                            );
                                          } else {
                                            setState(() {
                                              _pinHasError = null;
                                              _nextStep();
                                            });
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                  Spacer(flex: 3),
                  SizedBox(
                    width: 1.sw.clamp(1.0, 500.0),
                    child: enterPhone || enterName
                        ? ElevatedButton(
                            onPressed: (_hasError)
                                ? null
                                : () async {

                                    if (_isLoading) return;

                                    setState(() {
                                      _isLoading = true;
                                    });

                                    await Future.delayed(Duration(seconds: 1));
                                    _phone_number = _phoneController.text
                                        .trim();
                                    _nextStep();

                                    setState(() {
                                      _hasError = true;
                                      _isLoading = false;
                                    });
                                  },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: _isLoading
                                ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: AppColors.background,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    enterPhone
                                        ? 'ارسال کد'
                                        : enterName
                                        ? 'تأیید'
                                        : '',
                                  ),
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
