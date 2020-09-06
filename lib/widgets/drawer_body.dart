import 'package:flutter/material.dart';
import 'package:meal_app/Screens/filter_screen.dart';

import '../constant.dart';

class DrawerBody extends StatelessWidget {
  const DrawerBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.15,
            color: kDarkGreenColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 14, top: 50),
              child: Text(
                "Start Cooking!!",
                style: TextStyle(fontSize: 28, color: kLightColor),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                buildListTile(
                  title: "Meals",
                  icon: Icons.restaurant,
                  onTap: () {
                    Navigator.pushReplacementNamed(context, "/");
                  },
                ),
                buildListTile(
                  title: "Filter",
                  icon: Icons.settings,
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, FilterScreen.routeName);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  ListTile buildListTile({String title, IconData icon, Function onTap}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: 28,
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 26),
      ),
    );
  }
}
