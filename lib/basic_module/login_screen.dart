import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // 1. Fixed: Moved variable here and removed '@override'
  final logo = "https://i.pinimg.com/736x/8c/5f/af/8c5fafccd3a05d0432e4a2d9a2009785.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogo(),
                const SizedBox(height: 30),
                
                _buildEmailTextField(),
                const SizedBox(height: 20),
                _buildPasswordTextField(),
                const SizedBox(height: 40),
                _buildLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 2. Updated to use your URL
  Widget _buildLogo() {
    return Column(
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: Image.network(
            logo,
            fit: BoxFit.contain, // Keeps the image aspect ratio
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email),
        hintText: "Enter Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (text) {
        if (text == null || text.isEmpty) {
          return "Please fill in the Email.";
        }
        return null;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.key),
        hintText: "Enter Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      keyboardType: TextInputType.text,
      validator: (text) {
        if (text == null || text.isEmpty) {
          return "Please fill in the Password.";
        }
        if (text.length < 6) {
          return "Password must be at least 6 characters.";
        }
        return null;
      },
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Processing Login...")),
            );
          }
        },
        child: const Text("LOGIN"),
      ),
    );
  }
}