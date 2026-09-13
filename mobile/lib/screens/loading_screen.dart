import 'package:flutter/material.dart';

import '../services/pitch_service.dart';
import '../models/pitch_result.dart';
import 'result_screen.dart';

class LoadingScreen extends StatefulWidget {
  final String idea;
  final String audience;

  const LoadingScreen({super.key, required this.idea, required this.audience});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _generate();
  }

  Future<void> _generate() async {
    try {
      final PitchResult result = await PitchService.generatePitch(
        idea: widget.idea,
        targetAudience: widget.audience,
      );

      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => ResultScreen(result: result)),
      );
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop(); // back to idea screen on failure
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 24),
            Text(
              "Crafting your pitch...",
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
