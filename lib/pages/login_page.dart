import 'package:flutter/material.dart';
import 'package:flutter_ecom_basic_app/constants/colors.dart';
import 'package:hugeicons/hugeicons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final String _requiredEmail = 'user@email.com';
  final String _requiredPassword = '123456789';

  String? _emailError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (_emailFocusNode.hasFocus) {
        setState(() {
          _emailError = null;
        });
      }
    });

    _passwordFocusNode.addListener(() {
      if (_passwordFocusNode.hasFocus) {
        setState(() {
          _passwordError = null;
        });
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _attemptLogin() {
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    if (_emailController.text != _requiredEmail) {
      setState(() {
        _emailError = 'Please enter a valid email.';
      });
    }

    if (_passwordController.text != _requiredPassword) {
      setState(() {
        _passwordError = 'Password is incorrect.';
      });
    }

    if (_emailController.text == _requiredEmail &&
        _passwordController.text == _requiredPassword) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                children: [
                  Text(
                    'Email: $_requiredEmail',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Password: $_requiredPassword',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            TextField(
              focusNode: _emailFocusNode,
              controller: _emailController,
              cursorColor: primaryColor,
              decoration: InputDecoration(
                prefixIcon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedUser,
                  color: primaryColor,
                  size: 21,
                ),
                labelText: 'Email',
                labelStyle: const TextStyle(color: primaryColor),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                errorText: _emailError,
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: deleteRed),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: deleteRed, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              focusNode: _passwordFocusNode,
              controller: _passwordController,
              obscureText: true,
              cursorColor: primaryColor,
              decoration: InputDecoration(
                prefixIcon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedLockPassword,
                  color: primaryColor,
                  size: 21,
                ),
                labelText: 'Password',
                labelStyle: const TextStyle(color: primaryColor),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                errorText: _passwordError,
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: deleteRed),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: deleteRed, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _attemptLogin,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
              ),
              child: Container(
                height: 50,
                width: 100,
                alignment: Alignment.center,
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
