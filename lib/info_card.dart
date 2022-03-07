import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'information.dart';

import 'package:websafe_svg/websafe_svg.dart';

import '../../../constants.dart';
import '../../../extensions.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    required this.info,
    required this.editPress,
    required this.deletePress,
  }) : super(key: key);

  final Information info;
  final VoidCallback editPress;
  final VoidCallback deletePress;

  @override
  Widget build(BuildContext context) {
    //  Here the shadow is not showing properly
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(kDefaultPadding),
          decoration: BoxDecoration(
            color: kBgDarkColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SizedBox(
                    width: 32,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: info.imageURL != null
                          ? AssetImage(info.imageURL!)
                          : null,
                    ),
                  ),
                  SizedBox(
                    width: kDefaultPadding,
                  ),
                  Text.rich(
                    TextSpan(
                      text: "${info.firstname + " " + info.lastname}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: kTextColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: kDefaultPadding,
                  ),
                  Text(
                    info.email,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: kDefaultPadding,
                  ),
                  Text(
                    info.phone,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.deepOrange,
                    ),
                  ),
                  Spacer(),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: 100,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: deletePress,
                          icon: WebsafeSvg.asset(
                            "assets/Icons/Trash.svg",
                            width: 24,
                            color: Colors.black
                          ),
                        ),
                        IconButton(
                          onPressed: editPress,
                          icon: WebsafeSvg.asset(
                            "assets/Icons/Edit.svg",
                            width: 24,
                            color: Colors.black
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ).addNeumorphism(
          blurRadius: 15,
          borderRadius: 15,
          offset: Offset(5, 5),
          topShadowColor: Colors.white60,
          bottomShadowColor: Color(0xFF234395).withOpacity(0.15),
        ),
      ),
    );
  }
}
