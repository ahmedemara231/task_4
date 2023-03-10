class Users
{
  int? id;
  String userName;
  String email;
  Users({
     this.id,
    required this.userName,
    required this.email
  });

  Map<String ,dynamic> toMap()
  {
    return
      {
        'id' : id,
        'userName' : userName,
        'email' : email
      };
  }
  factory Users.fromMap(Map<String,dynamic >map)
  {
    return Users
      (
        id: map['id'],
        userName: map['userName'],
      email: map['email'],
    );
  }
}