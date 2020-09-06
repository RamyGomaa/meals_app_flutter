import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:meal_app/models/dummy_categories_data.dart';
import 'package:meal_app/widgets/category_box.dart';

class MealsCategoriesScreen extends StatelessWidget {
  static String routeName = '/Meals_Categories_Screen';
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: MealsCategoriesBody(screenSize: screenSize),
    );
  }
}

class MealsCategoriesBody extends StatelessWidget {
  const MealsCategoriesBody({
    Key key,
    @required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.height,
      child: GridView.count(
        padding: const EdgeInsets.all(10.0),
        crossAxisCount: 2,
        children: categoriesBoxes,
      ),
    );
  }

  get categoriesBoxes {
    return List.generate(
      DummyData.DUMMY_CATEGORIES.length,
      (index) {
        final category = DummyData.DUMMY_CATEGORIES[index];
        return CategoryBox(screenSize: screenSize, category: category);
      },
    );
  }
}
