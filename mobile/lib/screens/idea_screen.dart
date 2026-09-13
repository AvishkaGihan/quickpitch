import 'package:flutter/material.dart';

import 'loading_screen.dart';

class IdeaScreen extends StatefulWidget {
  const IdeaScreen({super.key});

  @override
  State<IdeaScreen> createState() => _IdeaScreenState();
}

class _IdeaScreenState extends State<IdeaScreen> {
  final TextEditingController _ideaController = TextEditingController();
  final List<String> _audiences = ["Investors", "Customers", "Tech Partners"];
  String _selectedAudience = "Investors";

  @override
  void dispose() {
    _ideaController.dispose();
    super.dispose();
  }

  void _onGenerate() {
    final idea = _ideaController.text.trim();
    if (idea.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please describe your app idea first.")),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LoadingScreen(idea: idea, audience: _selectedAudience),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                "QuickPitch AI",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Turn your idea into a 30-second pitch.",
                style: TextStyle(color: Colors.white60),
              ),
              const SizedBox(height: 32),
              const Text("Describe your app idea in 1–2 sentences"),
              const SizedBox(height: 8),
              TextField(
                controller: _ideaController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "e.g. Uber for lawnmowing",
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text("Who is this pitch for?"),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _audiences.map((a) {
                  final selected = a == _selectedAudience;
                  return ChoiceChip(
                    label: Text(a),
                    selected: selected,
                    onSelected: (_) => setState(() => _selectedAudience = a),
                  );
                }).toList(),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onGenerate,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text("Generate Elevator Pitch 🚀"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
