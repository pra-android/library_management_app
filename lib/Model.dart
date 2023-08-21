class Model {
  int? id;
  String studentname;
  int semester;
  String Bookid;

  Model({
    this.id,
    required this.studentname,
    required this.semester,
    required this.Bookid,
  });

  //converts map to Object form or class
  factory Model.tojson(Map<String, dynamic> map) {
    return Model(
      id: map['id'],
      studentname: map['studentname'],
      semester: map['semester'],
      Bookid: map['Bookid'],
    );
  }

  //converts model to map form
  Map<String, dynamic> tomap() {
    return {
      'id': id,
      'studentname': studentname,
      'semester': semester,
      'Bookid': Bookid,
    };
  }
}
