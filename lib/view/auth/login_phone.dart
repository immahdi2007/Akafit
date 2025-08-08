import 'dart:ui';

import 'package:akafit/view/theme.dart';
import 'package:akafit/view/widgets/app_text_field.dart';
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

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _verifyCodeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String? _pinHaseError;
  bool _hasError = true;

  late final PinTheme pinPutTheme;
  late final PinTheme errorPinTheme;
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

    pinPutTheme = PinTheme(
      width: 45.r,
      height: 55.r,
      decoration: BoxDecoration(
        color: AppColors.grayBg,
        borderRadius: AppRadius.radius_8,
      ),
    );

    errorPinTheme = pinPutTheme.copyWith(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.errorColor),
        borderRadius: AppRadius.radius_8,
        color: AppColors.grayBg,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pinFocusNode.dispose();
    super.dispose();
  }

  void _nextStep() {
    setState(() {
      if (_step == loginStep.enterPhone) {
        _step = loginStep.enterCode;
      } else if (_step == loginStep.enterCode) {
        _step = loginStep.name;
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
                    delay: Duration(milliseconds: 200),
                    duration: Duration(milliseconds: 400),
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
                                      Pinput(
                                        length: 5,
                                        pinputAutovalidateMode:
                                            PinputAutovalidateMode.disabled,
                                        defaultPinTheme: pinPutTheme,
                                        focusedPinTheme: pinPutTheme.copyWith(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: AppColors.secondary,
                                            ),
                                            borderRadius: AppRadius.radius_8,
                                            color: AppColors.grayBg,
                                          ),
                                        ),
                                        showCursor: false,
                                        focusNode: _pinFocusNode,
                                        controller: _verifyCodeController,
                                        autofocus: true,
                                        enabled: true,
                                        readOnly: false,
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
                                              _pinHaseError =
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
                                              _pinHaseError = null;
                                              _nextStep();
                                            });
                                          }
                                        },
                                      ),
                                      if (_pinHaseError != null)
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: sizedBox.small.h,
                                          ),
                                          child: FadeInDown(
                                            delay: Duration(milliseconds: 0),
                                            duration: Duration(
                                              milliseconds: 100,
                                            ),
                                            child: Text(
                                              "لطفا کد را صحیح وارد کنید",
                                              style: AppTextStyle.errorStyle,
                                            ),
                                          ),
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
                            onPressed: _hasError
                                ? null
                                : () {
                                    _nextStep();
                                    _hasError = true;
                                    _phone_number = _phoneController.text
                                        .trim();
                                  },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
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
