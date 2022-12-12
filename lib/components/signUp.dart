import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _verifyPasswordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _isSignedUp = false;

  void _signUp() async {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Signing Up...")));
    final userAttributes = <CognitoUserAttributeKey, String>{
      CognitoUserAttributeKey.email: _emailController.text
    };

    try {
      await Amplify.Auth.signUp(
          username: _usernameController.text.trim(),
          password: _passwordController.text.trim(),
          options: CognitoSignUpOptions(userAttributes: userAttributes));
      setState(() {
        _isSignedUp = true;
      });
    } on AuthException catch (error) {
      setState(() {
        _isSignedUp = false;
      });
      print(error.message);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Sign up failed, do you already have an account?")));
    } on Exception catch (error) {
      print(error);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("An unknown error occurred")));
    }
  }

  void _confirm() async {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Confirming...')));
    try {
      await Amplify.Auth.confirmSignUp(
          username: _usernameController.text.trim(),
          confirmationCode: _confirmController.text.trim());
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Confirmed, you can now login.')));
      setState(() {
        _isSignedUp = false;
      });
    } on AuthException catch (error) {
      print(error.message);
      setState(() {
        _isSignedUp = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Visibility(
                    visible: _isSignedUp,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(5),
                          child: Text('Enter Confirmation Code',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24)),
                        ),
                        TextFormField(
                          controller: _confirmController,
                          decoration: const InputDecoration(
                              hintText: "Enter confirmation code"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter confirmation code';
                            }
                            return null;
                          },
                        ),
                        ConstrainedBox(
                            constraints:
                                const BoxConstraints(minWidth: double.infinity),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _confirm();
                                  }
                                },
                                child: const Text('CONFIRM ACCOUNT'),
                              ),
                            )),
                        ConstrainedBox(
                            constraints:
                                const BoxConstraints(minWidth: double.infinity),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isSignedUp = false;
                                  });
                                },
                                child: const Text('CANCEL'),
                              ),
                            )),
                      ],
                    )),
                Visibility(
                  visible: !_isSignedUp,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(5),
                        child: Text('Create a New Account',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 24)),
                      ),
                      TextFormField(
                        controller: _usernameController,
                        decoration:
                            const InputDecoration(hintText: "Enter a Username"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a Username';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration:
                            const InputDecoration(hintText: "Enter your Email"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter an Email Address';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration:
                            const InputDecoration(hintText: "Enter a Password"),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a Password';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _verifyPasswordController,
                        decoration:
                            const InputDecoration(hintText: "Verify Password"),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please verify password';
                          }
                          if (value.contains(_passwordController.text.trim())) {
                            return null;
                          } else {
                            return 'Passwords do not match';
                          }
                        },
                      ),
                      ConstrainedBox(
                          constraints:
                              const BoxConstraints(minWidth: double.infinity),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _signUp();
                                }
                              },
                              child: const Text('SIGN UP'),
                            ),
                          )),
                      ConstrainedBox(
                          constraints:
                              const BoxConstraints(minWidth: double.infinity),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _isSignedUp = true;
                                });
                              },
                              child: const Text('CONFIRM ACCOUNT'),
                            ),
                          )),
                    ],
                  ),
                )
              ],
            )));
  }
}
