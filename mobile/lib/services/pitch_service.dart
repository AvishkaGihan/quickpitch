import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config.dart';
import '../models/pitch_result.dart';

class PitchException implements Exception {
  final String message;
  PitchException(this.message);
  @override
  String toString() => message;
}

class PitchService {
  static Future<PitchResult> generatePitch({
    required String idea,
    required String targetAudience,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse(ApiConfig.pitchEndpoint),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"idea": idea, "target_audience": targetAudience}),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return PitchResult.fromJson(data);
      } else {
        throw PitchException(
          "Server error (${response.statusCode}). Please try again.",
        );
      }
    } on http.ClientException {
      throw PitchException(
        "Network error. Check your connection and try again.",
      );
    } catch (e) {
      if (e is PitchException) rethrow;
      throw PitchException("Something went wrong. Please try again.");
    }
  }
}
