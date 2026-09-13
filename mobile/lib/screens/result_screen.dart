import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/pitch_result.dart';

class ResultScreen extends StatelessWidget {
  final PitchResult result;

  const ResultScreen({super.key, required this.result});

  void _copyToClipboard(BuildContext context) {
    final text =
        "HOOK\n${result.hook}\n\n30-SECOND PITCH\n${result.pitch}\n\nCALL-TO-ACTION\n${result.cta}";
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Copied to clipboard")));
  }

  Widget _section(String title, String body) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurpleAccent,
          ),
        ),
        const SizedBox(height: 6),
        Text(body, style: const TextStyle(fontSize: 15, height: 1.4)),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Pitch")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _section("HOOK", result.hook),
                      _section("30-SECOND PITCH", result.pitch),
                      _section("CALL-TO-ACTION", result.cta),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _copyToClipboard(context),
                      child: const Text("Copy to Clipboard"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () =>
                          Navigator.of(context).popUntil((r) => r.isFirst),
                      child: const Text("Try Another"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
