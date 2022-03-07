import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'constants.dart';
import 'extensions.dart';
import 'side_menu_item.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

import 'package:flutter/foundation.dart' show kIsWeb;

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  late String uploadedPhotoUrl;

  void clearControllers() {
    firstnameController.clear();
    lastnameController.clear();
    emailController.clear();
    phoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
      color: kBgLightColor,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
              FlatButton.icon(
                minWidth: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: kDefaultPadding,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: kPrimaryColor,
                onPressed: () {
                  _firestore.collection('contact').add({
                    'firstname': firstnameController.text,
                    'lastname': lastnameController.text,
                    'email': emailController.text,
                    'phone': phoneController.text,
                  });
                  setState(() {
                    clearControllers();
                  });
                },
                icon: WebsafeSvg.asset("assets/Icons/Plus.svg",
                    width: 16, color: Colors.white),
                label: const Text(
                  "New Contact",
                  style: TextStyle(color: Colors.white),
                ),
              ).addNeumorphism(
                topShadowColor: Colors.white,
                bottomShadowColor: const Color(0xFF234395).withOpacity(0.2),
              ),
              const SizedBox(height: kDefaultPadding * 2),

              // Menu Items
              SideMenuItem(
                press: () {},
                title: "Contact",
                iconSrc: "assets/Icons/Inbox.svg",
                isActive: true,
              ),
              SideMenuItem(
                press: () {
                  //uploadImage();
                },
                title: "Deleted",
                iconSrc: "assets/Icons/Trash.svg",
                isActive: false,
                showBorder: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
