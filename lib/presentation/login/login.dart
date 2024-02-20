import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_project/core/stores/form/form_store.dart';
import 'package:flutter_boilerplate_project/core/widgets/rounded_button_widget.dart';
import 'package:flutter_boilerplate_project/core/widgets/textfield_widget.dart';
import 'package:flutter_boilerplate_project/di/service_locator.dart';
import 'package:flutter_boilerplate_project/utils/device/device_utils.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      primary: true,
      body: BodyLoginScreen(),
    );
  }
}

class BodyLoginScreen extends StatelessWidget {
  const BodyLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _userEmailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    FocusNode _passwordFocusNode = FocusNode();

    final FormStore _formStore = getIt<FormStore>();

    _showErrorMessage(String message) {
      if (message.isNotEmpty) {
        Future.delayed(const Duration(milliseconds: 0), () {
          if (message.isNotEmpty) {
            FlushbarHelper.createError(
              message: message,
              title: 'error', // AppLocalizations.of(context).translate('home_tv_error'),
              duration: const Duration(seconds: 3),
            ).show(context);
          }
        });
      }

      return const SizedBox.shrink();
    }

    return Material(
      child: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // AppIconWidget(image: 'assets/icons/ic_appicon.png'),
                    const SizedBox(height: 24.0),
                    Observer(
                      builder: (context) {
                        return TextFieldWidget(
                          // AppLocalizations.of(context).translate('login_et_user_email'),
                          hint: 'email',
                          inputType: TextInputType.emailAddress,
                          icon: Icons.person,
                          iconColor: Colors.black54,
                          // _themeStore.darkMode ? Colors.white70 : Colors.black54,
                          textController: _userEmailController,
                          inputAction: TextInputAction.next,
                          autoFocus: false,
                          onChanged: (value) {
                            _formStore.setUserId(_userEmailController.text);
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(_passwordFocusNode);
                          },
                          errorText: _formStore.formErrorStore.userEmail,
                        );
                      },
                    ),
                    Observer(
                      builder: (context) {
                        return TextFieldWidget(
                          hint: 'password',
                          // AppLocalizations.of(context).translate('login_et_user_password'),
                          isObscure: true,
                          padding: const EdgeInsets.only(top: 16.0),
                          icon: Icons.lock,
                          iconColor: Colors.black54,
                          // _themeStore.darkMode ? Colors.white70 : Colors.black54,
                          textController: _passwordController,
                          focusNode: _passwordFocusNode,
                          errorText: _formStore.formErrorStore.password,
                          onChanged: (value) {
                            _formStore.setPassword(_passwordController.text);
                          },
                        );
                      },
                    ),
                    RoundedButtonWidget(
                      buttonText: 'Login',
                      buttonColor: Colors.orangeAccent,
                      textColor: Colors.white,
                      onPressed: () async {
                        if (_formStore.canLogin) {
                          DeviceUtils.hideKeyboard(context);
                          // _userStore.login(_userEmailController.text, _passwordController.text);
                        } else {
                          _showErrorMessage('Please fill in all fields');
                        }
                      },
                    ),
                    // _buildPasswordField(),
                    // _buildForgotPasswordButton(),
                    // _buildSignInButton()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
