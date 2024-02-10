import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twitter_clone/common/loading_page.dart';
import 'package:twitter_clone/common/rounded_small_button.dart';
import 'package:twitter_clone/constants/ui_constants.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/auth/view/signup_view.dart';
import 'package:twitter_clone/features/auth/widgets/auth_field.dart';
import 'package:twitter_clone/theme/theme.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const LoginView(),
      );

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
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

  void onLogin() {
    ref.read(authControllerProvider.notifier).logIn(
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
                          onTap: () {},
                          label: 'Done',
                        ),
                      ),
                      SizedBox(
                        height: 36.h,
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'Don\'t have an account ?',
                            style: TextStyle(fontSize: 14.sp),
                            children: [
                              TextSpan(
                                  text: ' Sign up',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        SignUpView.route(),
                                      );
                                    },
                                  style: TextStyle(
                                      color: Pallete.blueColor,
                                      fontSize: 14.sp)),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
