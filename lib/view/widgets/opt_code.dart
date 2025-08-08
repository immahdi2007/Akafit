import 'package:akafit/view/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class OptCodeWidget extends StatelessWidget {
  const OptCodeWidget({
    super.key,
    required this.focusNode,
    required this.controller,
    this.hasError,
    required this.onCompleted,
  });

  final FocusNode focusNode;
  final TextEditingController controller;
  final String? hasError;
  final void Function(String) onCompleted;

  @override
  Widget build(BuildContext context) {
    final pinPutTheme = PinTheme(
      width: 45.r,
      height: 55.r,
      decoration: BoxDecoration(
        color: AppColors.grayBg,
        borderRadius: AppRadius.radius_8,
      ),
    );
    return Column(
      children: [
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
                                        focusNode: focusNode,
                                        controller: controller,
                                        autofocus: true,
                                        enabled: true,
                                        readOnly: false,
                                        onCompleted: (value) {
                                          Future.delayed(
                                            Duration(milliseconds: 100),
                                            () {
                                              focusNode.requestFocus();
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

                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: sizedBox.small.h,
                                        ),
                                        child: AnimatedVisibility(
                                          duration: AppDuration.errorText,
                                          child: _pinHasError != null
                                              ? Text(
                                                  "لطفا کد را صحیح وارد کنید",
                                                  key: ValueKey(_pinHasError),
                                                  style:
                                                      AppTextStyle.errorStyle,
                                                )
                                              : SizedBox(
                                                  key: ValueKey('empty'),
                                                ),
                                        ),
                                      ),
      ],
    );
  }
}
