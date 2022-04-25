import 'package:flutter/material.dart';
import 'package:travel/components/colors.dart';
import 'package:travel/screens/post.dart';
import 'package:travel/components/globals.dart' as globals;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool visible1 = true;
  bool visible2 = false;
  bool isFavorite = false;
  List<dynamic> allPosts = globals.otherpost;
  List<dynamic> foundPosts = [];
  var entries;
  var found;

  void _runFilter(String enteredKeyword) {
    List<dynamic> results = [];
    setState(() {
      allPosts = globals.otherpost;
    });
    print(allPosts);
    if (enteredKeyword.isEmpty) {
      setState(() {
        visible1 = true;
        visible2 = false;
      });
      results = allPosts;
    } else {
      setState(() {
        visible1 = false;
        visible2 = true;
      });
      results = allPosts
          .where((user) => user['location']
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      found = foundPosts.length;
    }
    setState(() {
      foundPosts = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(alignment: Alignment.topCenter, children: [
      Container(
        height: 90,
        decoration: BoxDecoration(
          color: MyColor.secClr,
        ),
      ),
      Positioned(
        top: 60,
        left: 24,
        right: 24,
        child: Container(
          height: 50,
          width: 310,
          padding: EdgeInsets.fromLTRB(15.0, 1.0, 5.0, 1.0),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 3,
              blurRadius: 15,
              offset: Offset(0, 3),
            ),
          ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: TextField(
            onChanged: (value) => _runFilter(value),
            decoration: InputDecoration(
              hintText: "Search ",
              hintStyle: TextStyle(
                  color: MyColor.bg1Clr,
                  fontWeight: FontWeight.w300,
                  fontSize: 16),
              border: InputBorder.none,
              suffixIcon: Icon(
                Icons.search,
                color: MyColor.bg1Clr,
                size: 20,
              ),
            ),
          ),
        ),
      ),
      Visibility(
          visible: visible1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(top: 120, left: 20, right: 20.0),
                child: ListView.builder(
                  itemCount: allPosts.length,
                  itemBuilder: (context, index) => Card(
                    color: MyColor.secClr.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text(allPosts[index]['location'],
                          style: TextStyle(
                              fontSize: 16,
                              color: MyColor.bg1Clr,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),
              )),
            ],
          )),
      Visibility(
        visible: visible2,
        child: foundPosts.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Padding(
                    padding:
                        const EdgeInsets.only(top: 130, left: 15, right: 15.0),
                    child: ListView.builder(
                      itemCount: foundPosts.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostScreen(
                                    foundPosts[index]['location'].toString(),
                                    foundPosts[index]['experience'].toString(),
                                    foundPosts[index]['coverImage'].toString(),
                                    foundPosts[index]['date'].toString(),
                                    foundPosts[index]['cost'].toString(),
                                    foundPosts[index]['heritages'].toString(),
                                    foundPosts[index]['placestovisit']
                                        .toString(),
                                    foundPosts[index]['accessofcommunity']
                                        .toString(),
                                    foundPosts[index]['easeoftransport']
                                        .toString(),
                                    foundPosts[index]['safety'].toString(),
                                    foundPosts[index]['accomodation']
                                        .toString(),
                                    foundPosts[index]['rating'].toString())),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          elevation: 5,
                          child: Column(
                            children: [
                              ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                ),
                                tileColor: Colors.white,
                                title: Text(foundPosts[index]['username'],
                                    style: TextStyle(
                                        color: MyColor.bg1Clr,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20)),
                                // trailing: IconButton(
                                //   icon: Icon(Icons.share),
                                //   color: MyColor.bg1Clr,
                                //   onPressed: () {},
                                // ),
                              ),
                              Container(
                                width: 320,
                                height: 270,
                                child: Image.network(
                                  foundPosts[index]['coverImage'].toString(),
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
                                title: Text(foundPosts[index]['location'],
                                    style: TextStyle(
                                        color: MyColor.bg1Clr,
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
                ],
              )
            : Padding(
                padding: const EdgeInsets.only(top: 130.0, left: 28),
                child: Text(
                  "No results found! ",
                  style: TextStyle(
                      fontSize: 18, color: Colors.black54 //MyColor.hintTxtClr
                      ),
                ),
              ),
      )
    ])
        // } else {
        //   return Center(child: CircularProgressIndicator());
        // }
        // }

        );
  }
}
