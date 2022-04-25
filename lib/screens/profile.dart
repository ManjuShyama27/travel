import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:travel/API/API.dart';
import 'package:travel/components/colors.dart';
import 'package:travel/screens/addpost.dart';
import 'package:travel/screens/editprofile.dart';
import 'package:travel/screens/post.dart';
import 'package:travel/components/globals.dart' as globals;
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isFavorite = false;
  bool loading = false;
  var ownpost;

  getOwnPost() async {
    setState(() {
      loading = true;
    });
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ' + globals.authToken.toString(),
    };

    var response = await http.get(
      Uri.parse('https://travel27.herokuapp.com/travelPost/getOwnPost'),
      headers: requestHeaders,
    );
    print(json.decode(response.body));
    ownpost = json.decode(response.body)['data'];

    if (response.statusCode == 201 || response.statusCode == 200) {
      setState(() {
        loading = false;
        ownpost = json.decode(response.body)['data'];
      });
      globals.ownpost = json.decode(response.body)['data'];
      ownpost = json.decode(response.body)['data'];
      print('Own post');
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    getProfileData();
    getOwnPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'My Profile',
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
          ),
          elevation: 0,
          backgroundColor: MyColor.secClr,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddPost()),
                    );
                  },
                  child: Icon(Icons.add_circle_outline_outlined, size: 30),
                )),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfile()),
                          );
                        },
                        child: globals.profile.length == 0
                            ? Image.network(
                                'https://static2.tripoto.com/media/filter/tst/img/311219/TripDocument/1624442336_def_prof.jpg',
                                fit: BoxFit.cover)
                            : Image.network(globals.profile['img'].toString(),
                                fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(globals.username,
                            style: TextStyle(
                                color: MyColor.bg1Clr,
                                fontWeight: FontWeight.w500,
                                fontSize: 20)),
                        Text(
                            globals.profile.length == 0
                                ? ''
                                : globals.profile['name'],
                            style: TextStyle(
                                color: MyColor.bg1Clr,
                                fontWeight: FontWeight.w500,
                                fontSize: 18)),
                        Container(
                          width: 200,
                          child: Text(
                              globals.profile.length == 0
                                  ? ''
                                  : globals.profile['bio'],
                              style: TextStyle(
                                  color: MyColor.bg1Clr,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Container(
                    height: 40,
                    width: 320,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile()),
                        );
                      },
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                            color: MyColor.bgClr,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 15, bottom: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('My Posts ',
                        style: TextStyle(
                            color: MyColor.bgClr,
                            fontWeight: FontWeight.w500,
                            fontSize: 20)),
                    Text(ownpost == null ? '' : ownpost.length.toString(),
                        style: TextStyle(
                            color: MyColor.bgClr,
                            fontWeight: FontWeight.w500,
                            fontSize: 20)),
                  ],
                ),
              ),
              loading
                  ? Padding(
                      padding: const EdgeInsets.only(top: 250.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: MyColor.secClr,
                        ),
                      ),
                    )
                  : ownpost == null
                      ? Expanded(child: Text('No posts'))
                      : Expanded(
                          child: ListView.builder(
                          itemCount: ownpost.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PostScreen(
                                        ownpost[index]['location'].toString(),
                                        ownpost[index]['experience'].toString(),
                                        ownpost[index]['coverImage'].toString(),
                                        ownpost[index]['date'].toString(),
                                        ownpost[index]['cost'].toString(),
                                        ownpost[index]['heritages'].toString(),
                                        ownpost[index]['placestovisit']
                                            .toString(),
                                        ownpost[index]['accessofcommunity']
                                            .toString(),
                                        ownpost[index]['easeoftransport']
                                            .toString(),
                                        ownpost[index]['safety'].toString(),
                                        ownpost[index]['accomodation']
                                            .toString(),
                                        ownpost[index]['rating'].toString())),
                              );
                            },
                            child: Card(
                              elevation: 5,
                              child: Column(
                                children: [
                                  ListTile(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    tileColor: Colors.white,
                                    title: Text(globals.username,
                                        style: TextStyle(
                                            color: MyColor.bg1Clr,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20)),
                                    trailing: IconButton(
                                      icon: Icon(Icons.delete),
                                      color: Colors.red,
                                      onPressed: () {
                                        AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.WARNING,
                                                animType: AnimType.TOPSLIDE,
                                                title: 'Are you sure?',
                                                btnOkOnPress: () {
                                                  deleteTravelPost(
                                                      ownpost[index]['_id']
                                                          .toString());
                                                  setState(() {});
                                                },
                                                btnOkColor: Colors.green,
                                                btnOkText: 'Yes',
                                                btnCancelText: 'No',
                                                btnCancelColor: Colors.red,
                                                btnCancelOnPress: () {})
                                            .show();
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 320,
                                    height: 270,
                                    child: Image.network(
                                      ownpost[index]['coverImage'].toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  ListTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20)),
                                      ),
                                      tileColor: Colors.transparent,
                                      title: Text(ownpost[index]['location'],
                                          style: TextStyle(
                                              color: MyColor.bg1Clr,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20)),
                                      trailing: IconButton(
                                        icon: Icon(
                                          ownpost[index]['isFavourite']
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                        ),
                                        color: Colors.pinkAccent,
                                        onPressed: () {
                                          setState(() {
                                            ownpost[index]['isFavourite'] =
                                                !ownpost[index]['isFavourite'];
                                            print(
                                                ownpost[index]['isFavourite']);
                                          });
                                          updateTravelPost(
                                              ownpost[index]['_id'].toString(),
                                              ownpost[index]['isFavourite']);
                                        },
                                      )),
                                ],
                              ),
                            ),
                          ),
                        )),
            ],
          ),
        ));
  }
}
