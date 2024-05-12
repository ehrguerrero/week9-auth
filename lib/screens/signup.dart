import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week9_authentication/models/user_model.dart';
import '../providers/auth_provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();

    final email = TextFormField(
      controller: emailController,
      decoration: const InputDecoration(
        hintText: "Email",
      ),
      validator: (String? value) {
        // check if email is valid using regex matching (ref: https://stackoverflow.com/questions/16800540/how-should-i-check-if-the-input-is-an-email-address-in-flutter)
        final bool emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(emailController.text);
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        } else if (!emailValid) {
          return 'Please enter a valid email';
        }

        return null;
      },
    );

    final password = TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Password',
      ),
      validator: (String? value) {
        // add checker for password length
        num passLen = (passwordController.text).length;
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        } else if (passLen < 5) {
          return 'Password must be at least 6 characters long';
        }
        return null;
      },
    );

    // added first and last name text fields
    final firstName = TextFormField(
      controller: firstNameController,
      decoration: const InputDecoration(
        hintText: "First Name",
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your first name';
        }

        return null;
      },
    );

    final lastName = TextFormField(
      controller: lastNameController,
      decoration: const InputDecoration(
        hintText: "Last Name",
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your last name';
        }
        return null;
      },
    );

    final SignupButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            UserDeets user = UserDeets(
                email: emailController.text,
                firstName: firstNameController.text,
                lastName: lastNameController.text);

            await context.read<MyAuthProvider>().signUp(
                emailController.text, passwordController.text, user, context);
          }
        },
        child: const Text('Sign up', style: TextStyle(color: Colors.purple)),
      ),
    );

    final backButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Text('Back', style: TextStyle(color: Colors.purple)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      // form widget for input validation
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
            children: <Widget>[
              const Text(
                "Sign Up",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),
              email,
              password,
              firstName,
              lastName,
              SignupButton,
              backButton
            ],
          ),
        ),
      ),
    );
  }
}
