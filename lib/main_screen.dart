import 'package:address_book/list_of_infomation.dart';
import 'package:flutter/material.dart';
import 'side_menu.dart';

class MainScreen extends StatelessWidget {
  late String messageText;

  @override
  Widget build(BuildContext context) {
    // Get width and height of current screen
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: _size.width > 1340 ? 1 : 1,
            child: SideMenu(),
          ),
          Expanded(
            flex: _size.width > 1340 ? 3 : 2,
            child: ListOfInformation(),
          ),
        ],
      ),
    );
  }
}
