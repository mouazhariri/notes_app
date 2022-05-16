class noteModel {
  int? id;
  // String? title;
  String? Text;
  String? date;

  // noteModel(dynamic obj) {
  //   id = obj['id'];
  //   // date = obj['date'];
  //   Text = obj['Text'];
  // }
  noteModel({
    this.id,
    this.Text,
    // this.title,
    this.date,
  });
  noteModel.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    Text = data['Text'];
    // title = data['title'];
    date = data['date'];
  }

  Map<String, dynamic> toMap() {
    return ({
      'id': this.id,
      // "title": title,
      'Text': this.Text,
      "date": this.date,
    });
  }

  // int? get iid => id;
  // String? get text => Text;
}
