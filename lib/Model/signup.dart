class UserModelOne {
  String uid;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? userName;

  UserModelOne(
      {
        required this.uid,
        this.firstName,
        this.lastName,
        this.email,
        this.phoneNumber,
        this.userName,      
      });
  // data from server
  factory UserModelOne.fromMap(map) {
    return UserModelOne(
      uid: map['uid'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      userName: map['userName'],
      phoneNumber: map['phoneNumber'],
    );
  }
// sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'userName': userName,
    };
  }
}