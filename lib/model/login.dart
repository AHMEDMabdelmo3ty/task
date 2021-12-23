class LoginModel {

  String? msg;
  String? token;
  String? expiresOn;

  LoginModel.fromJson(Map<String,dynamic>json){
    token=json['token'];
    msg=json['msg'];
    expiresOn=json['expiresOn'];

  }
}

// class Data {
//   int? id;
//   String? name;
//   String? email;
//   String? phone;
//   String? image;
//   int? points;
//   int? credit;
//   String? token;
//   Data.fromJson(Map<String,dynamic>json){
//     id=json['id'];
//     name=json['name'];
//     email=json['email'];
//     phone=json['phone'];
//     image=json['image'];
//     points=json['points'];
//     credit=json['credit'];
//     token=json['token'];
//   }
// }
