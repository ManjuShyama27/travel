class Config {
  static const String baseUrl = '';
  static const String localUrl = 'http://localhost:5000/';
  static const String registerUser = baseUrl + 'user/register';
  static const String login = baseUrl + 'user/login';
  static const String otherpost = baseUrl + 'travelPost/getOtherPost';
  static const String favpost = baseUrl + 'travelPost/getFavouritePost';
  static const String ownpost = baseUrl + 'travelPost/getOwnPost';
  static const String addpost = baseUrl + 'travelPost/Add';
  static const String deletepost = baseUrl + 'travelPost/delete/';
  static const String updatepost = baseUrl + 'travelPost/update/';
  static const String editprofile = baseUrl + 'profile/add';
  static const String checkprofile = baseUrl + 'profile/checkProfile';
  static const String getprofiledata = baseUrl + 'profile/getData';
  static const String uploadImage = baseUrl + 'image/add';
}
