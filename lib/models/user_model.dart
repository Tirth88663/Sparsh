class UserModel {
  String? uid;
  String? name;
  String? email;
  int? mobile;

  UserModel({this.uid, this.email, this.name, this.mobile});

  //receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        name: map['name'],
        email: map['email'],
        mobile: map['mobile']);
  }
  //sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'mobile': mobile,
    };
  }
}
