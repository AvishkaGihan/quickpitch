class PitchResult {
  final String hook;
  final String pitch;
  final String cta;

  PitchResult({required this.hook, required this.pitch, required this.cta});

  factory PitchResult.fromJson(Map<String, dynamic> json) {
    return PitchResult(
      hook: json['hook'] ?? '',
      pitch: json['pitch'] ?? '',
      cta: json['cta'] ?? '',
    );
  }
}
