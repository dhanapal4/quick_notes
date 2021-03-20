class NoteModel {
  String body;
  int id;
  String name;
  String timestamp;
  String title;
  int userId;

  NoteModel(
      {this.body, this.id, this.name, this.timestamp, this.title, this.userId});

  NoteModel.fromJson(Map<String, dynamic> json) {
    body = json['body'];
    id = json['id'];
    name = json['name'];
    timestamp = json['timestamp'];
    title = json['title'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['body'] = this.body;
    data['id'] = this.id;
    data['name'] = this.name;
    data['timestamp'] = this.timestamp;
    data['title'] = this.title;
    data['user_id'] = this.userId;
    return data;
  }
}
