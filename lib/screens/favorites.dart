import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:travel/components/colors.dart';
import 'package:travel/screens/post.dart';
import 'package:travel/components/globals.dart' as globals;
import 'package:http/http.dart' as http;

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  bool isFavorite = true;
  bool loading = false;
  var favpost;

  getFavouritePost() async {
    setState(() {
      loading = true;
    });
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ' + globals.authToken.toString(),
    };

    var response = await http.get(
      Uri.parse('https://travel27.herokuapp.com/travelPost/getFavouritePost'),
      headers: requestHeaders,
    );
    print(json.decode(response.body));
    favpost = json.decode(response.body)['data'];
    if (response.statusCode == 201 || response.statusCode == 200) {
      setState(() {
        loading = false;
      });
      favpost = json.decode(response.body)['data'];
      print('Favourite post');
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    getFavouritePost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Your Favorites',
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
          ),
          elevation: 0,
          backgroundColor: MyColor.secClr,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              loading
                  ? Padding(
                      padding: const EdgeInsets.only(top: 250.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: MyColor.secClr,
                        ),
                      ),
                    )
                  : favpost.length == 0
                      ? const Expanded(
                          child: Center(
                          child: Text('No Favourite Posts',
                              style: TextStyle(
                                  color: MyColor.bgClr,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20)),
                        ))
                      : Expanded(
                          child: ListView.builder(
                          itemCount: favpost.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PostScreen(
                                        favpost[index]['location'].toString(),
                                        favpost[index]['experience'].toString(),
                                        favpost[index]['coverImage'].toString(),
                                        favpost[index]['date'].toString(),
                                        favpost[index]['cost'].toString(),
                                        favpost[index]['heritages'].toString(),
                                        favpost[index]['placestovisit']
                                            .toString(),
                                        favpost[index]['accessofcommunity']
                                            .toString(),
                                        favpost[index]['easeoftransport']
                                            .toString(),
                                        favpost[index]['safety'].toString(),
                                        favpost[index]['accomodation']
                                            .toString(),
                                        favpost[index]['rating'].toString())),
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
                                            color: MyColor.bgClr,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20)),
                                    // trailing: IconButton(
                                    //   icon: Icon(Icons.share),
                                    //   color: MyColor.bgClr,
                                    //   onPressed: () {},
                                    // ),
                                  ),
                                  Container(
                                    width: 320,
                                    height: 270,
                                    child: Image.network(
                                      favpost[index]['coverImage'].toString(),
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
                                    title: Text(favpost[index]['location'],
                                        style: TextStyle(
                                            color: MyColor.bgClr,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20)),
                                    // trailing: IconButton(
                                    //   icon: Icon(
                                    //     isFavorite
                                    //         ? Icons.favorite
                                    //         : Icons.favorite_border,
                                    //   ),
                                    //   color: Colors.pinkAccent,
                                    //   onPressed: () {
                                    //     setState(() {
                                    //       isFavorite = !isFavorite;
                                    //     });
                                    //   },
                                    // )
                                    trailing: Icon(
                                      Icons.favorite,
                                      color: Colors.pinkAccent,
                                    ),
                                  ),
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
