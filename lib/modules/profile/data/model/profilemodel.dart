class ProfileModel {
  final String name;
  final String username;
  final String email;
  final String phone;
  final String location;
  final String points;
  final String profileImage;
  final String bannerImage;

  ProfileModel({
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.location,
    required this.points,
    required this.profileImage,
    required this.bannerImage,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      name: map['name'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      location: map['location'] ?? '',
      points: map['points'] ?? '',
      profileImage: map['profileImage'] ?? '',
      bannerImage: map['bannerImage'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'location': location,
      'points': points,
      'profileImage': profileImage,
      'bannerImage': bannerImage,
    };
  }
}
