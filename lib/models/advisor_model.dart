
class AdvisorModel {
  String? firstName;
  String? lastName;
  String? title;
  String? profileImage;
  String? id;
  String? username;

  AdvisorModel({
    this.firstName,
    this.lastName,
    this.title,
    this.profileImage,
    this.id,
    this.username,
  });

  AdvisorModel.fromJson(
    Map<String, dynamic> json,
  )   : firstName = json['firstName'],
        lastName = json['lastName'],
        title = json['title'],
        profileImage = json['profileImage'] ,
        id = json['id'],
        username = json['username'];

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'title': title,
        'profileImage': profileImage,
        'id': id,
        'username': username,
      };
}
