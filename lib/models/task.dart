class Task {
  int? id;
  String title;
  String subject;
  String deadline;
  bool isCompleted;

  Task({
    this.id,
    required this.title,
    required this.subject,
    required this.deadline,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subject': subject,
      'deadline': deadline,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      subject: map['subject'],
      deadline: map['deadline'],
      isCompleted: map['isCompleted'] == 1,
    );
  }
}
