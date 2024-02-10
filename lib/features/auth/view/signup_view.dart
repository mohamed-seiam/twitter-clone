import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twitter_clone/common/loading_page.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/auth/view/login_view.dart';

import '../../../common/rounded_small_button.dart';
import '../../../constants/ui_constants.dart';
import '../../../theme/pallet.dart';
import '../widgets/auth_field.dart';

class SignUpView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignUpView(),
      );

  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final appBar = UiConstants.appBar();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onSignUp() {
    final res = ref.read(authControllerProvider.notifier).signUp(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: appBar,
      body: isLoading
          ? const Loader()
          : Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Column(
                    children: [
                      AuthField(
                        controller: emailController,
                        hintText: 'Email Address',
                      ),
                      SizedBox(
                        height: 22.h,
                      ),
                      AuthField(
                        controller: passwordController,
                        hintText: 'Password',
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: RoundedSmallButton(
                          onTap: onSignUp,
                          label: 'Done',
                        ),
                      ),
                      SizedBox(
                        height: 36.h,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Already have an account ?',
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
                          children: [
                            TextSpan(
                              text: ' Log in',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    LoginView.route(),
                                  );
                                },
                              style: TextStyle(
                                color: Pallete.blueColor,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
