import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meal_app/Screens/meals_of_type_screen.dart';
import 'package:meal_app/models/category.dart';

import '../constant.dart';

class CategoryBox extends StatelessWidget {
  const CategoryBox({
    Key key,
    @required this.screenSize,
    @required this.category,
  }) : super(key: key);

  final Size screenSize;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(screenSize.height * 0.015),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, MealsOfTypeScreen.routeName, arguments: {
            'id': category.id,
            'title': category.title,
          });
        },
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: category.coverImage,
                fit: BoxFit.cover,
                // colorFilter: ColorFilter.mode(
                //   Colors.red.withAlpha(15),
                //   BlendMode.color,
                // ),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: Container(
                  decoration: new BoxDecoration(
                    color: Colors.red.withOpacity(0.04),
                  ),
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        category.title,
                        style: TextStyle(
                          color: kLightColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
