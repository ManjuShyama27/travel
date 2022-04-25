library my_prj.globals;

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travel/components/globals.dart' as globals;

checkProfile() async {
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Authorization': 'Bearer ' + globals.authToken.toString(),
  };

  var response = await http.get(
    Uri.parse(''),
    headers: requestHeaders,
  );
  print(json.decode(response.body));
  globals.username = json.decode(response.body)['username'];
  print(globals.username);

  if (response.statusCode == 201 || response.statusCode == 200) {
    print('profileCheck');
  } else {
    return null;
  }
}

getProfileData() async {
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Authorization': 'Bearer ' + globals.authToken.toString(),
  };

  var response = await http.get(
    Uri.parse(''),
    headers: requestHeaders,
  );
  print(json.decode(response.body));
  var profile = json.decode(response.body)['data'];
  globals.profile = profile;
  print(globals.profile);

  if (response.statusCode == 201 || response.statusCode == 200) {
    print('profiledata');
  } else {
    return null;
  }
}

deleteTravelPost(String PostID) async {
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Authorization': 'Bearer ' + globals.authToken.toString(),
  };

  var response = await http.delete(
    Uri.parse(''),
    headers: requestHeaders,
  );
  print(json.decode(response.body));

  if (response.statusCode == 201 || response.statusCode == 200) {
    print('Post Added');
  } else {
    return null;
  }
}

updateTravelPost(String PostID, bool fav) async {
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Authorization': 'Bearer ' + globals.authToken.toString(),
  };

  var response = await http.patch(
    Uri.parse(''),
    headers: requestHeaders,
    body: jsonEncode(<String, Object>{
      'isFavourite': fav,
    }),
  );
  print(json.decode(response.body));

  if (response.statusCode == 201 || response.statusCode == 200) {
    print('Post Added');
  } else {
    return null;
  }
}

getOtherPost() async {
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Authorization': 'Bearer ' + globals.authToken.toString(),
  };

  var response = await http.get(
    Uri.parse(''),
    headers: requestHeaders,
  );
  print(json.decode(response.body));
  var otherpost = json.decode(response.body)['data'];
  globals.otherpost = otherpost;
  print(globals.otherpost);

  if (response.statusCode == 201 || response.statusCode == 200) {
    print('Other post');
  } else {
    return null;
  }
}
