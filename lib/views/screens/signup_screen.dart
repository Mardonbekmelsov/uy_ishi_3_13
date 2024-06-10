import 'package:dars_3_9_uy_ishi/services/auth_http_service.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  final _authHttpServices = AuthHttpServices();

  final passwordController = TextEditingController();

  final passwordVerifyController = TextEditingController();

  bool isLoading = false;
  String? email;
  String? password;
  String? verifiedPassword;

  void submit() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      //? Register
      setState(() {
        isLoading = true;
      });
      try {
        await _authHttpServices.register(email!, password!);

        Navigator.pushReplacementNamed(context, "/main");
      } catch (e) {
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
        appBar: AppBar(
          centerTitle: true,
          title: Text("Sign Up"),
        ),
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
                    //? save email
                    email = newValue;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: passwordController,
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
                    //? save password
                    password = newValue;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: passwordVerifyController,
                  decoration: const InputDecoration(
                    hintText: "verify passsword",
                    suffixIcon: Icon(
                      Icons.verified,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Iltimos parolingizni tasdiqlang";
                    }

                    if (passwordController.text !=
                        passwordVerifyController.text) {
                      return "Parollar bir xil emas";
                    }

                    return null;
                  },
                  onSaved: (newValue) {
                    //? save password confirm
                    verifiedPassword = newValue;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    const SizedBox(
                      width: 5,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/login");
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.deepPurple,
                  ),
                  onPressed: submit,
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
