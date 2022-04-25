import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:travel/API/API.dart';
import 'package:travel/components/colors.dart';
import 'package:travel/components/globals.dart' as globals;
import 'package:http/http.dart' as http;

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController locationController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController heritageController = TextEditingController();
  TextEditingController placesController = TextEditingController();
  TextEditingController accessController = TextEditingController();
  TextEditingController transportController = TextEditingController();
  TextEditingController safetyController = TextEditingController();
  TextEditingController accomodationController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  File? image;
  final formkey = GlobalKey<FormState>();
  String location = '';
  String experience = '';
  String date = '';
  String cost = '';
  String heritages = '';
  String placestovisit = '';
  String accessofcommunity = '';
  String easeoftransport = '';
  String safety = '';
  String accomodation = '';
  String rat = '2';

  DateTimeRange dateRange =
      DateTimeRange(end: DateTime.now(), start: DateTime(2000, 1, 1));

  addTravelPost(
      String location,
      experience,
      date,
      cost,
      heritages,
      placestovisit,
      accessofcommunity,
      easeoftransport,
      safety,
      accomodation,
      rating) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ' + globals.authToken.toString(),
    };
    if (image == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Upload photo',
          textAlign: TextAlign.center,
        ),
        duration: Duration(milliseconds: 300),
      ));
      return;
    }
    var request = http.MultipartRequest(
        "POST", Uri.parse('https://travel27.herokuapp.com/image/add'));
    var pic = await http.MultipartFile.fromPath("image", image!.path);
    //add multipart to request
    request.files.add(pic);
    var response = await request.send();
    // Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    final responseJson = json.decode(responseString);
    print(responseJson);

    var resp = responseJson['imageURL'];
    print(responseJson['imageURL']);

    var response_2 = await http.post(
      Uri.parse('https://travel27.herokuapp.com/travelPost/Add'),
      headers: requestHeaders,
      body: jsonEncode(<String, Object>{
        'location': location,
        'experience': experience,
        'coverImage': responseJson['imageURL'],
        'isFavourite': false,
        'date': date,
        'cost': cost,
        'heritages': heritages,
        'placestovisit': placestovisit,
        'accessofcommunity': accessofcommunity,
        'easeoftransport': easeoftransport,
        'safety': safety,
        'accomodation': accomodation,
        'rating': rating
      }),
    );
    print(json.decode(response_2.body));

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Post Added');
      print(json.decode(response_2.body));
    } else {
      return null;
    }
  }

  Future pickImagefromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() => this.image = imageTemporary);
    Navigator.of(context).pop();
  }

  Future pickImagefromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() => this.image = imageTemporary);
    Navigator.of(context).pop();
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        initialDateRange: dateRange,
        firstDate: DateTime(2000),
        lastDate: DateTime.now());
    if (newDateRange == null) return;
    setState(() => dateRange = newDateRange);
  }

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    final Duration = dateRange.duration;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'New Post',
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
          ),
          elevation: 0,
          backgroundColor: MyColor.secClr,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: GestureDetector(
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(children: [
                              SimpleDialogOption(
                                onPressed: () {
                                  pickImagefromCamera();
                                },
                                child: Text(
                                  'Take Photo',
                                  style: TextStyle(
                                      color: MyColor.bg1Clr,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Divider(),
                              SimpleDialogOption(
                                onPressed: () {
                                  pickImagefromGallery();
                                },
                                child: Text(
                                  'Photo Gallery',
                                  style: TextStyle(
                                      color: MyColor.bg1Clr,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ]);
                          }),
                      child: Container(
                          width: 340,
                          height: 200,
                          decoration: BoxDecoration(
                            color: MyColor.secClr.withOpacity(0.1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: image != null
                              ? Image.file(image!, width: 340, height: 140)
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add,
                                        color: MyColor.bg1Clr, size: 40),
                                    Text(
                                      'Upload Photos',
                                      style: TextStyle(
                                          fontSize: 16, color: MyColor.bg1Clr),
                                    )
                                  ],
                                )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                        height: 42,
                        width: 340.0,
                        padding: EdgeInsets.fromLTRB(15.0, 1.0, 5.0, 1.0),
                        decoration: BoxDecoration(
                          color: MyColor.secClr.withOpacity(0.1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: TextFormField(
                          controller: locationController,
                          style: TextStyle(
                              fontSize: 16,
                              color: MyColor.bg1Clr,
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            hintText: "Location",
                            hintStyle:
                                TextStyle(fontSize: 16, color: MyColor.bg1Clr),
                            suffixStyle:
                                TextStyle(color: MyColor.bg1Clr, fontSize: 13),
                            border: InputBorder.none,
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      width: 340,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 42,
                              width: 115.0,
                              decoration: BoxDecoration(
                                color: MyColor.secClr.withOpacity(0.1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  DateFormat('dd MMM yyyy').format(start),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: MyColor.bg1Clr,
                                      fontWeight: FontWeight.w500),
                                ),
                              )),
                          Text('To',
                              style: TextStyle(
                                  fontSize: 16, color: MyColor.bg1Clr)),
                          Container(
                              height: 42,
                              width: 115.0,
                              decoration: BoxDecoration(
                                color: MyColor.secClr.withOpacity(0.1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  DateFormat('dd MMM yyyy').format(end),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: MyColor.bg1Clr,
                                      fontWeight: FontWeight.w500),
                                ),
                              )),
                          IconButton(
                              icon: Icon(Icons.date_range,
                                  size: 24, color: MyColor.bg1Clr),
                              onPressed: pickDateRange)
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                        height: 42,
                        width: 340.0,
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 5.0, 1.0),
                        decoration: BoxDecoration(
                          color: MyColor.secClr.withOpacity(0.1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Text(
                          'Duration: ' + '${Duration.inDays}' + ' Days',
                          style: TextStyle(
                              fontSize: 16,
                              color: MyColor.bg1Clr,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                        height: 42,
                        width: 340.0,
                        padding: EdgeInsets.fromLTRB(15.0, 1.0, 5.0, 1.0),
                        decoration: BoxDecoration(
                          color: MyColor.secClr.withOpacity(0.1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: costController,
                          style: TextStyle(
                              fontSize: 16,
                              color: MyColor.bg1Clr,
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            hintText: "Cost of Travel",
                            hintStyle:
                                TextStyle(fontSize: 16, color: MyColor.bg1Clr),
                            suffixStyle:
                                TextStyle(color: MyColor.bg1Clr, fontSize: 13),
                            border: InputBorder.none,
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                        height: 42,
                        width: 340.0,
                        padding: EdgeInsets.fromLTRB(15.0, 1.0, 5.0, 1.0),
                        decoration: BoxDecoration(
                          color: MyColor.secClr.withOpacity(0.1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: TextFormField(
                          controller: heritageController,
                          style: TextStyle(
                              fontSize: 16,
                              color: MyColor.bg1Clr,
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            hintText: "Heritages ",
                            hintStyle:
                                TextStyle(fontSize: 16, color: MyColor.bg1Clr),
                            suffixStyle:
                                TextStyle(color: MyColor.bg1Clr, fontSize: 13),
                            border: InputBorder.none,
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                        height: 42,
                        width: 340.0,
                        padding: EdgeInsets.fromLTRB(15.0, 1.0, 5.0, 1.0),
                        decoration: BoxDecoration(
                          color: MyColor.secClr.withOpacity(0.1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: TextFormField(
                          controller: placesController,
                          style: TextStyle(
                              fontSize: 16,
                              color: MyColor.bg1Clr,
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            hintText: "Places to visit",
                            hintStyle:
                                TextStyle(fontSize: 16, color: MyColor.bg1Clr),
                            suffixStyle:
                                TextStyle(color: MyColor.bg1Clr, fontSize: 13),
                            border: InputBorder.none,
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                        height: 42,
                        width: 340.0,
                        padding: EdgeInsets.fromLTRB(15.0, 1.0, 5.0, 1.0),
                        decoration: BoxDecoration(
                          color: MyColor.secClr.withOpacity(0.1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: TextFormField(
                          controller: accessController,
                          style: TextStyle(
                              fontSize: 16,
                              color: MyColor.bg1Clr,
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            hintText: "Access of Community",
                            hintStyle:
                                TextStyle(fontSize: 16, color: MyColor.bg1Clr),
                            suffixStyle:
                                TextStyle(color: MyColor.bg1Clr, fontSize: 13),
                            border: InputBorder.none,
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                        height: 42,
                        width: 340.0,
                        padding: EdgeInsets.fromLTRB(15.0, 1.0, 5.0, 1.0),
                        decoration: BoxDecoration(
                          color: MyColor.secClr.withOpacity(0.1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: TextFormField(
                          controller: transportController,
                          style: TextStyle(
                              fontSize: 16,
                              color: MyColor.bg1Clr,
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            hintText: "Ease of Transportation",
                            hintStyle:
                                TextStyle(fontSize: 16, color: MyColor.bg1Clr),
                            suffixStyle:
                                TextStyle(color: MyColor.bg1Clr, fontSize: 13),
                            border: InputBorder.none,
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                        height: 42,
                        width: 340.0,
                        padding: EdgeInsets.fromLTRB(15.0, 1.0, 5.0, 1.0),
                        decoration: BoxDecoration(
                          color: MyColor.secClr.withOpacity(0.1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: TextFormField(
                          controller: safetyController,
                          style: TextStyle(
                              fontSize: 16,
                              color: MyColor.bg1Clr,
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            hintText: "Safety",
                            hintStyle:
                                TextStyle(fontSize: 16, color: MyColor.bg1Clr),
                            suffixStyle:
                                TextStyle(color: MyColor.bg1Clr, fontSize: 13),
                            border: InputBorder.none,
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                        height: 42,
                        width: 340.0,
                        padding: EdgeInsets.fromLTRB(15.0, 1.0, 5.0, 1.0),
                        decoration: BoxDecoration(
                          color: MyColor.secClr.withOpacity(0.1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: TextFormField(
                          controller: accomodationController,
                          style: TextStyle(
                              fontSize: 16,
                              color: MyColor.bg1Clr,
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            hintText: "Accomodation",
                            hintStyle:
                                TextStyle(fontSize: 16, color: MyColor.bg1Clr),
                            suffixStyle:
                                TextStyle(color: MyColor.bg1Clr, fontSize: 13),
                            border: InputBorder.none,
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                        height: 90,
                        width: 340.0,
                        padding: EdgeInsets.fromLTRB(15.0, 1.0, 5.0, 1.0),
                        decoration: BoxDecoration(
                          color: MyColor.secClr.withOpacity(0.1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: TextFormField(
                          controller: experienceController,
                          style: TextStyle(
                              fontSize: 16,
                              color: MyColor.bg1Clr,
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            hintText: "Experience",
                            hintStyle:
                                TextStyle(fontSize: 16, color: MyColor.bg1Clr),
                            suffixStyle:
                                TextStyle(color: MyColor.bg1Clr, fontSize: 13),
                            border: InputBorder.none,
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      height: 90,
                      width: 340.0,
                      padding: EdgeInsets.fromLTRB(15.0, 1.0, 5.0, 1.0),
                      decoration: BoxDecoration(
                        color: MyColor.secClr.withOpacity(0.1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Rating',
                                  style: TextStyle(
                                      fontSize: 16, color: MyColor.bg1Clr)),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RatingBar.builder(
                            initialRating: 2,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                              rat = rating.toString();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                    child: Container(
                      height: 42,
                      width: 290,
                      child: ElevatedButton(
                        onPressed: () {
                          location = locationController.text;
                          experience = experienceController.text;
                          date = DateFormat('dd MMM yyyy').format(start) +
                              '-' +
                              DateFormat('dd MMM yyyy').format(end);
                          cost = 'Rs.' + costController.text;
                          heritages = heritageController.text;
                          placestovisit = placesController.text;
                          easeoftransport = transportController.text;
                          safety = safetyController.text;
                          accessofcommunity = accessController.text;
                          accomodation = accomodationController.text;
                          addTravelPost(
                                  location,
                                  experience,
                                  date,
                                  cost,
                                  heritages,
                                  placestovisit,
                                  accessofcommunity,
                                  easeoftransport,
                                  safety,
                                  accomodation,
                                  rat)
                              .then((response) async {
                            if (formkey.currentState!.validate()) {
                              //getOwnPost();
                              Navigator.pop(context);
                            }
                          });
                        },
                        child: Text(
                          'Post',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: MyColor.secClr,
                          onPrimary: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
