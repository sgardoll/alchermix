class User {
  final String id;
  final String name;
  final String email;
  final String? openaiApiKey;
  final String? replicateApiKey;
  final String? perplexityApiKey;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.openaiApiKey,
    this.replicateApiKey,
    this.perplexityApiKey,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'openaiApiKey': openaiApiKey,
    'replicateApiKey': replicateApiKey,
    'perplexityApiKey': perplexityApiKey,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    openaiApiKey: json['openaiApiKey'] as String?,
    replicateApiKey: json['replicateApiKey'] as String?,
    perplexityApiKey: json['perplexityApiKey'] as String?,
    createdAt: DateTime.parse(json['createdAt'] as String),
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? openaiApiKey,
    String? replicateApiKey,
    String? perplexityApiKey,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    openaiApiKey: openaiApiKey ?? this.openaiApiKey,
    replicateApiKey: replicateApiKey ?? this.replicateApiKey,
    perplexityApiKey: perplexityApiKey ?? this.perplexityApiKey,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  bool get hasAllApiKeys => openaiApiKey != null && openaiApiKey!.isNotEmpty &&
    replicateApiKey != null && replicateApiKey!.isNotEmpty &&
    perplexityApiKey != null && perplexityApiKey!.isNotEmpty;
}
