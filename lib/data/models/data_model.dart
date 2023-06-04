class DataModel {
  final String id;
  final String userId;
  final String title;
  final String description;
  final String date;

  DataModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.date,
  });

  factory DataModel.fromFirestore(Map<String, dynamic> data) {
    return DataModel(
      id: data['id'],
      userId: data['userId'],
      title: data['title'],
      description: data['description'],
      date: data['date'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'date': date,
    };
  }
}
