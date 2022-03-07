import 'package:flutter/material.dart';
import 'side_menu.dart';

//import 'package:outlook/screens/email/email_screen.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'extensions.dart';
import 'constants.dart';
import 'info_card.dart';
import 'information.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';

class ListOfInformation extends StatefulWidget {
  // Press "Command + ."
  const ListOfInformation({
    Key? key,
  }) : super(key: key);

  @override
  _ListOfInformationState createState() => _ListOfInformationState();
}

class _ListOfInformationState extends State<ListOfInformation> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('contact').snapshots();
  final CollectionReference _db =
      FirebaseFirestore.instance.collection('contact');

  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  Future<void> deleteContact(String id) {
    return _db.doc(id).delete();
  }

  Future<void> editContact(String id) {
    return _db.doc(id).update({
      'firstname': firstnameController.text,
      'lastname': lastnameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
    });
  }

  void clearControllers() {
    firstnameController.clear();
    lastnameController.clear();
    emailController.clear();
    phoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 250),
        child: SideMenu(),
      ),
      body: Container(
        padding: EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
        color: kBgDarkColor,
        child: SafeArea(
          right: false,
          child: Column(
            children: [
              // This is our Seearch bar
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          hintText: "Search",
                          fillColor: kBgLightColor,
                          filled: true,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(
                                kDefaultPadding * 0.75), //15
                            child: WebsafeSvg.asset(
                              "assets/Icons/Search.svg",
                              width: 24,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: kDefaultPadding),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Row(
                  children: [
                    WebsafeSvg.asset(
                      "assets/Icons/Angle down.svg",
                      width: 16,
                      color: Colors.black,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Sort by name",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    MaterialButton(
                      minWidth: 20,
                      onPressed: () {},
                      child: WebsafeSvg.asset(
                        "assets/Icons/Sort.svg",
                        width: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: kDefaultPadding),
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                stream: _usersStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      Information info = Information(
                        firstname: data['firstname'],
                        lastname: data['lastname'],
                        email: data['email'],
                        phone: data['phone'],
                        imageURL: "assets/images/profile.png",
                      );
                      firstnameController.text = info.firstname;
                      lastnameController.text = info.lastname;
                      emailController.text = info.email;
                      phoneController.text = info.phone;
                      return InfoCard(
                        info: info,
                        editPress: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Container(
                                    constraints: BoxConstraints(
                                      maxHeight: 350,
                                      minWidth: 500,
                                      maxWidth: 800,
                                    ),
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller: firstnameController,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'First Name',
                                          ),
                                        ),
                                        kHeightSpace,
                                        TextField(
                                          controller: lastnameController,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Last Name',
                                          ),
                                        ),
                                        kHeightSpace,
                                        TextField(
                                          controller: emailController,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Email',
                                          ),
                                        ),
                                        kHeightSpace,
                                        TextField(
                                          controller: phoneController,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Phone',
                                          ),
                                        ),
                                        kHeightSpace,
                                        FlatButton(
                                          minWidth: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: kDefaultPadding,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          color: kPrimaryColor,
                                          onPressed: () {
                                            editContact(document.id);
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Submit",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ).addNeumorphism(
                                          topShadowColor: Colors.white,
                                          bottomShadowColor:
                                              const Color(0xFF234395)
                                                  .withOpacity(0.2),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        deletePress: () {
                          deleteContact(document.id);
                        },
                      );
                    }).toList(),
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
