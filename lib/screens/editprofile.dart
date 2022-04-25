import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel/API/API.dart';
import 'package:travel/components/colors.dart';
import 'package:travel/components/globals.dart' as globals;
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String name = '';
  String bio = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  File? image;
  final formkey = GlobalKey<FormState>();

  addProfile(String name, bio) async {
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
      Uri.parse('https://travel27.herokuapp.com/profile/add'),
      headers: requestHeaders,
      body: jsonEncode(
          {'name': name, 'bio': bio, 'img': responseJson['imageURL']}),
    );
    final jsonEncoder = JsonEncoder();
    jsonEncoder.convert(response_2.body);

    if (response_2.statusCode == 200 || response_2.statusCode == 201) {
      print(response_2.body);
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

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
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
                  name = nameController.text;
                  bio = bioController.text;
                  addProfile(name, bio).then((response) async {
                    if (formkey.currentState!.validate()) {
                      Navigator.pop(context);
                    }
                  });
                },
                child: Icon(
                  Icons.check_circle_outline_outlined,
                  size: 30,
                ),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Container(
                width: 150,
                height: 150,
                child: GestureDetector(
                  onTap: () {},
                  child: image != null
                      ? Image.file(image!, width: 150, height: 150)
                      : Image.network(
                          'https://static2.tripoto.com/media/filter/tst/img/311219/TripDocument/1624442336_def_prof.jpg',
                          fit: BoxFit.cover),
                ),
              ),
              TextButton(
                  onPressed: () => showDialog(
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
                  child: Text('Change profile photo',
                      style: TextStyle(color: MyColor.bgClr, fontSize: 18))),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                    height: 42,
                    width: 350,
                    padding: EdgeInsets.fromLTRB(15.0, 10.0, 5.0, 1.0),
                    decoration: BoxDecoration(
                      color: MyColor.secClr.withOpacity(0.1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Text(
                      globals.username,
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
                    width: 350,
                    padding: EdgeInsets.fromLTRB(15.0, 1.0, 5.0, 1.0),
                    decoration: BoxDecoration(
                      color: MyColor.secClr.withOpacity(0.1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: TextFormField(
                      controller: nameController,
                      style: TextStyle(
                          fontSize: 16,
                          color: MyColor.bg1Clr,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        hintText: globals.profile.length == 0
                            ? 'Name'
                            : globals.profile['name'],
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
                    height: 70,
                    width: 350,
                    padding: EdgeInsets.fromLTRB(15.0, 1.0, 5.0, 1.0),
                    decoration: BoxDecoration(
                      color: MyColor.secClr.withOpacity(0.1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: TextFormField(
                      controller: bioController,
                      style: TextStyle(
                          fontSize: 16,
                          color: MyColor.bg1Clr,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        hintText: globals.profile.length == 0
                            ? 'Bio'
                            : globals.profile['bio'],
                        hintStyle:
                            TextStyle(fontSize: 16, color: MyColor.bg1Clr),
                        suffixStyle:
                            TextStyle(color: MyColor.bg1Clr, fontSize: 13),
                        border: InputBorder.none,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
