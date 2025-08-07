import 'dart:ui';

import 'package:akafit/view/theme.dart';
import 'package:akafit/view/widgets/app_text_field.dart';
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
  // final FocusNode _focusNode = FocusNode();
  String _phone_number = '';

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _verifyCodeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String? _pinHaseError;

  late final PinTheme pinPutTheme;
  late final PinTheme errorPinTheme;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(color: Colors.transparent),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Spacer(flex: 1),
                  Column(
                    children: [
                      Text(
                        enterPhone
                            ? "شماره تلفن خود را وارد کنید"
                            : enterCode
                            ? "کد تأیید را وارد کنید"
                            : "نام خود را وارد کنید",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: sizedBox.medium.h),
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
                                    : ValidatorType.none,
                                onErrorChange: (hasError) {},
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
                                          PinputAutovalidateMode.onSubmit,
                                      defaultPinTheme: pinPutTheme,
                                      focusedPinTheme: pinPutTheme.copyWith(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColors.primary,
                                          ),
                                          borderRadius: AppRadius.radius_8,
                                          color: AppColors.grayBg,
                                        ),
                                      ),
                                      showCursor: false,
                                      controller: _verifyCodeController,
                                      autofocus: true,
                                      // focusNode: _focusNode,
                                      enabled: true,
                                      readOnly: false,
                                      onCompleted: (value) {
                                        bool isValid = value == '11111';
                                        if (!isValid) {
                                          setState(() {
                                            _pinHaseError =
                                                "کد وارد شده ناصحیح میباشد";
                                          });
                                        } else {
                                          setState(() {
                                            _pinHaseError = null;
                                          });
                                        }
                                      },
                                    ),
                                    if (_pinHaseError != null)
                                      Padding(
                                        padding: EdgeInsets.only(top: sizedBox.small.h),
                                        child: Text(
                                          "لطفا کد را صحیح وارد کنید",
                                          style: AppTextStyle.errorStyle,
                                        ),
                                      ),
                                  ],
                                ),
                              )
                            : null,
                      ),
                    ],
                  ),
                  Spacer(flex: 3),
                  SizedBox(
                    width: 1.sw.clamp(1.0, 500.0),
                    child: ElevatedButton(
                      // style: ,
                      onPressed: () {
                        _nextStep();
                        _phone_number = _phoneController.text.trim();
                      },
                      child: Text('ارسال کد'),
                    ),
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
