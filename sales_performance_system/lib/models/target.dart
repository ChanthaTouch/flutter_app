class Target {
  final int? id;
  final int userId;
  final double targetAmount;
  final String period;
  final String? description;

  Target({
    this.id,
    required this.userId,
    required this.targetAmount,
    required this.period,
    this.description,
  });

  factory Target.fromJson(Map<String, dynamic> json) {
    return Target(
      id: json['id'],
      userId: json['user_id'],
      targetAmount: double.parse(json['target_amount'].toString()),
      period: json['period'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'target_amount': targetAmount,
      'period': period,
      if (description != null) 'description': description,
    };
  }
}
