class UserModel {
  late String id;
  late String fulName;
  late String email;

  //default Constructor
  UserModel({required this.id, required this.fulName, required this.email});

  //flutter me ham aur bhi named constructor bana sakate h alag alag name vale ak to default constructor hota h jo uper defined kiya gaya h
  //basicaly this constructor take one map
  //yah constructor isliye map lega kyoki deSerialization ham JSON ko map me convert karate h phir map ko object me  to hame ak constructor chahiye jo ye hmara kam kar sake
  //map to object
  UserModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    fulName = map["fullName"];
    email = map["email"];
  }

  //hame serialization me object to map covert karane ke liye ak constructor chahiye
  //Object to Map  phir age json me convert hoga
  //yah function ak map return karega
  //json me bhi jo data hota h vo bhi map ke formate me hi  hota h
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "fullName": fulName,
      "email": email,
    };
  }
}
