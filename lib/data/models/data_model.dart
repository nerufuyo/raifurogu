class DataModel {
  final String id;
  final String title;
  final String description;
  final String date;

  DataModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  factory DataModel.fromFirestore(Map<String, dynamic> data) {
    return DataModel(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      date: data['date'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
    };
  }
}
