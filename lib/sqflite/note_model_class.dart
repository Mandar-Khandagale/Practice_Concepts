class Note{

  int _id;
  String _title;
  String _description;
  String _date;

  Note(this._title,this._description,this._date);
  Note.withId(this._id,this._title,this._description,this._date);

  ///getters
  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get date => _date;

  ///setters
  set title (newTitle){
    this._title = newTitle;
  }
  set description (newDescription){
    this._description = newDescription;
  }
  set date (newDate){
    this._date = newDate;
  }

  ///Convert Note Object into Map Object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if(id != null){
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['date'] = _date;

    return map;
  }

  ///Extract Note Object from Map object
  Note.fromMapObject(Map<String, dynamic> map){
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._date = map['date'];
  }

}