class LoginEntity {
  int id;
  String phone;
  String password;
  String registerTime;
  
  LoginEntity({this.id, this.phone, this.password});

  LoginEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    password = json['password'];
    registerTime = json['registerTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['phone'] = phone;
    data['password'] = password;
    data['registerTime'] = registerTime;

    return data;
  }
}
