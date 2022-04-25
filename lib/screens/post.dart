import 'package:flutter/material.dart';
import 'package:travel/components/colors.dart';

class PostScreen extends StatefulWidget {
  String location;
  String experience;
  String coverImage;
  String date;
  String cost;
  String heritages;
  String placestovisit;
  String accessofcommunity;
  String easeoftransport;
  String safety;
  String accomodation;
  String rating;
  PostScreen(
      this.location,
      this.experience,
      this.coverImage,
      this.date,
      this.cost,
      this.heritages,
      this.placestovisit,
      this.accessofcommunity,
      this.easeoftransport,
      this.safety,
      this.accomodation,
      this.rating);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 450,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Hero(
                    tag: widget.coverImage,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child:
                          Image.network(widget.coverImage, fit: BoxFit.cover),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FloatingActionButton(
                        mini: true,
                        backgroundColor: Colors.white.withOpacity(0.9),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Icon(
                          Icons.keyboard_arrow_left,
                          size: 30,
                          color: MyColor.bgClr,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      // FloatingActionButton(
                      //   mini: true,
                      //   backgroundColor: Colors.white.withOpacity(0.9),
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.all(Radius.circular(10))),
                      //   child: Icon(
                      //     Icons.share,
                      //     size: 20,
                      //     color: MyColor.bgClr,
                      //   ),
                      //   onPressed: () {},
                      // ),
                    ],
                  ),
                ),
                // Positioned(
                //     right: 20.0,
                //     bottom: 20.0,
                //     child: Container(
                //       height: 50,
                //       width: 50,
                //       decoration: BoxDecoration(
                //         color: Colors.white.withOpacity(0.9),
                //         borderRadius: BorderRadius.circular(15.0),
                //       ),
                //       child: IconButton(
                //         icon: Icon(
                //           isFavorite ? Icons.favorite : Icons.favorite_border,
                //         ),
                //         color: Colors.pinkAccent,
                //         onPressed: () {
                //           setState(() {
                //             isFavorite = !isFavorite;
                //           });
                //         },
                //       ),
                //     )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(17.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.location,
                    style: TextStyle(
                      color: MyColor.bgClr,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 24),
                            SizedBox(width: 10),
                            Text(
                              widget.rating,
                              style: TextStyle(
                                color: MyColor.bg1Clr,
                                fontSize: 17.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 25),
                        Row(
                          children: [
                            Icon(Icons.money,
                                color: Colors.green[400], size: 24),
                            SizedBox(width: 5),
                            Text(
                              widget.cost,
                              style: TextStyle(
                                color: MyColor.bg1Clr,
                                fontSize: 17.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.date_range, color: Colors.blue, size: 24),
                      SizedBox(width: 10),
                      Text(
                        widget.date,
                        style: TextStyle(
                          color: MyColor.bg1Clr,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 10.0),
                    child: Text(
                      'Experience',
                      style: TextStyle(
                        color: MyColor.bgClr,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    widget.experience,
                    style: TextStyle(
                      color: MyColor.bg1Clr,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 10.0),
                    child: Text(
                      'Places to Visit',
                      style: TextStyle(
                        color: MyColor.bgClr,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 300,
                        decoration: BoxDecoration(
                          color: MyColor.secClr.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Center(
                            child: Text(
                          widget.placestovisit,
                          style: TextStyle(
                            color: MyColor.bg1Clr,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 10.0),
                    child: Text(
                      'Heritages',
                      style: TextStyle(
                        color: MyColor.bgClr,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 300,
                        decoration: BoxDecoration(
                          color: MyColor.secClr.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Center(
                            child: Text(
                          widget.heritages,
                          style: TextStyle(
                            color: MyColor.bg1Clr,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 10.0),
                    child: Text(
                      'Access of Community',
                      style: TextStyle(
                        color: MyColor.bgClr,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    widget.accessofcommunity,
                    style: TextStyle(
                      color: MyColor.bg1Clr,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 10.0),
                    child: Text(
                      'Ease of transportation',
                      style: TextStyle(
                        color: MyColor.bgClr,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    widget.easeoftransport,
                    style: TextStyle(
                      color: MyColor.bg1Clr,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 10.0),
                    child: Text(
                      'Safety',
                      style: TextStyle(
                        color: MyColor.bgClr,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    widget.safety,
                    style: TextStyle(
                      color: MyColor.bg1Clr,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 10.0),
                    child: Text(
                      'Accomodation',
                      style: TextStyle(
                        color: MyColor.bgClr,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    widget.accomodation,
                    style: TextStyle(
                      color: MyColor.bg1Clr,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
