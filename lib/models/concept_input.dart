class ConceptInput {
  final String conceptA;
  final String conceptADetails;
  final String conceptB;
  final String conceptBDetails;
  final DateTime createdAt;

  ConceptInput({
    required this.conceptA,
    this.conceptADetails = '',
    required this.conceptB,
    this.conceptBDetails = '',
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'conceptA': conceptA,
    'conceptADetails': conceptADetails,
    'conceptB': conceptB,
    'conceptBDetails': conceptBDetails,
    'createdAt': createdAt.toIso8601String(),
  };

  factory ConceptInput.fromJson(Map<String, dynamic> json) => ConceptInput(
    conceptA: json['conceptA'] as String,
    conceptADetails: json['conceptADetails'] as String? ?? '',
    conceptB: json['conceptB'] as String,
    conceptBDetails: json['conceptBDetails'] as String? ?? '',
    createdAt: DateTime.parse(json['createdAt'] as String),
  );

  ConceptInput copyWith({
    String? conceptA,
    String? conceptADetails,
    String? conceptB,
    String? conceptBDetails,
    DateTime? createdAt,
  }) => ConceptInput(
    conceptA: conceptA ?? this.conceptA,
    conceptADetails: conceptADetails ?? this.conceptADetails,
    conceptB: conceptB ?? this.conceptB,
    conceptBDetails: conceptBDetails ?? this.conceptBDetails,
    createdAt: createdAt ?? this.createdAt,
  );

  bool get isValid => conceptA.trim().isNotEmpty && conceptB.trim().isNotEmpty;
}
