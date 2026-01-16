import 'package:flutter/material.dart';

class MyError extends StatelessWidget {
  final String error;
  final VoidCallback onPressed;

  // We don't strictly need 'context' here if we aren't using Theme/Navigator inside
  const MyError(
    BuildContext context, {
    super.key,
    required this.error,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 60),
              const SizedBox(height: 20),
              const Text(
                "Something went wrong",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                error,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: onPressed,
                icon: const Icon(Icons.refresh),
                label: const Text("Try Again"),
              )
            ],
          ),
        ),
      ),
    );
  }
}