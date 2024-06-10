import 'package:dars_3_9_uy_ishi/services/auth_http_service.dart';
import 'package:dars_3_9_uy_ishi/views/screens/reset_password_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final _authHttpServices = AuthHttpServices();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool isLoading = false;
  String? email;
  String? password;

  void submit() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      setState(() {
        isLoading = true;
      });
      try {
        await _authHttpServices.login(email!, password!);

        Navigator.pushReplacementNamed(context, "/main");
      } on Exception catch (e) {
        String message = e.toString();
        if (e.toString().contains("EMAIL_EXISTS")) {
          message = "Email mavjud";
        }
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Xatolik"),
              content: Text(message),
            );
          },
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "enter email",
                  suffixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Iltimos elektron pochtangizni kiriting";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  email = newValue;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                // controller: passwordController,
                decoration: const InputDecoration(
                  hintText: "enter passsword",
                  suffixIcon: Icon(Icons.password),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Iltimos parolingizni kiriting";
                  }

                  return null;
                },
                onSaved: (newValue) {
                  password = newValue;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Dont't have an account?"),
                  const SizedBox(
                    width: 5,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "/signUp");
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.deepPurple,
                      ),
                      onPressed: submit,
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResetPasswordScreen(),
                    ),
                  );
                },
                child: Text("Forgot Password?"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
