class FusionResult {
  final String id;
  final String conceptName;
  final String tagline;
  final String elevatorPitch;
  final String description;
  final String businessPlan;
  final String? logoUrl;
  final String? bannerUrl;
  final String uniquenessScore;
  final List<String> similarConcepts;
  final String inputConceptA;
  final String inputConceptB;
  final DateTime createdAt;
  final DateTime updatedAt;

  FusionResult({
    required this.id,
    required this.conceptName,
    required this.tagline,
    required this.elevatorPitch,
    required this.description,
    required this.businessPlan,
    this.logoUrl,
    this.bannerUrl,
    required this.uniquenessScore,
    this.similarConcepts = const [],
    required this.inputConceptA,
    required this.inputConceptB,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'conceptName': conceptName,
    'tagline': tagline,
    'elevatorPitch': elevatorPitch,
    'description': description,
    'businessPlan': businessPlan,
    'logoUrl': logoUrl,
    'bannerUrl': bannerUrl,
    'uniquenessScore': uniquenessScore,
    'similarConcepts': similarConcepts,
    'inputConceptA': inputConceptA,
    'inputConceptB': inputConceptB,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory FusionResult.fromJson(Map<String, dynamic> json) => FusionResult(
    id: json['id'] as String,
    conceptName: json['conceptName'] as String,
    tagline: json['tagline'] as String,
    elevatorPitch: json['elevatorPitch'] as String,
    description: json['description'] as String,
    businessPlan: json['businessPlan'] as String,
    logoUrl: json['logoUrl'] as String?,
    bannerUrl: json['bannerUrl'] as String?,
    uniquenessScore: json['uniquenessScore'] as String,
    similarConcepts: (json['similarConcepts'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
    inputConceptA: json['inputConceptA'] as String,
    inputConceptB: json['inputConceptB'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );

  FusionResult copyWith({
    String? id,
    String? conceptName,
    String? tagline,
    String? elevatorPitch,
    String? description,
    String? businessPlan,
    String? logoUrl,
    String? bannerUrl,
    String? uniquenessScore,
    List<String>? similarConcepts,
    String? inputConceptA,
    String? inputConceptB,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FusionResult(
    id: id ?? this.id,
    conceptName: conceptName ?? this.conceptName,
    tagline: tagline ?? this.tagline,
    elevatorPitch: elevatorPitch ?? this.elevatorPitch,
    description: description ?? this.description,
    businessPlan: businessPlan ?? this.businessPlan,
    logoUrl: logoUrl ?? this.logoUrl,
    bannerUrl: bannerUrl ?? this.bannerUrl,
    uniquenessScore: uniquenessScore ?? this.uniquenessScore,
    similarConcepts: similarConcepts ?? this.similarConcepts,
    inputConceptA: inputConceptA ?? this.inputConceptA,
    inputConceptB: inputConceptB ?? this.inputConceptB,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
