import 'package:dars_3_9_uy_ishi/services/auth_http_service.dart';
import 'package:dars_3_9_uy_ishi/views/screens/login_screen.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  AuthHttpServices authHttpServices = AuthHttpServices();
  String? email;
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
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
            SizedBox(
              height: 15,
            ),
            FilledButton(
              onPressed: () async {
                await authHttpServices.sendPasswordEmail(emailController.text);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text(
                "Submit",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
