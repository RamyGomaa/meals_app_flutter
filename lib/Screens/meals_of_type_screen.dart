import 'package:flutter/material.dart';

import 'package:meal_app/models/dummy_categories_data.dart';
import 'package:meal_app/models/meal.dart';

import 'package:meal_app/widgets/meal_box.dart';

import 'meal_details_screen.dart';

class MealsOfTypeScreen extends StatefulWidget {
  const MealsOfTypeScreen({
    Key key,
    this.filters,
    this.addToFav,
    this.favoriteMeals,
  }) : super(key: key);

  static String routeName = '/meals_of_type_screen';
  final filters;
  final addToFav;
  final favoriteMeals;
  @override
  _MealsOfTypeScreenState createState() => _MealsOfTypeScreenState();
}

class _MealsOfTypeScreenState extends State<MealsOfTypeScreen> {
  List<Meal> availableMeals;
  var categoryTitle;
  List<Meal> mealsToShow;
  bool didChange = false;
  @override
  void didChangeDependencies() {
    if (didChange == false) {
      final arguments =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      final categoryId = arguments['id'];
      categoryTitle = arguments['title'];

      availableMeals = DummyData.DUMMY_MEALS.where(
        (meal) {
          return meal.categories.contains(categoryId);
        },
      ).toList();

      mealsToShow = availableMeals.where((meal) {
        if (!meal.isGlutenFree && widget.filters["GlutenFree"]) {
          return false;
        }
        if (!meal.isLactoseFree && widget.filters["LactoseFree"]) {
          return false;
        }
        if (!meal.isVegan && widget.filters["Vegan"]) {
          return false;
        }
        if (!meal.isVegetarian && widget.filters["Vegetarian"]) {
          return false;
        }

        return true;
      }).toList();

      didChange = true;
    }
    super.didChangeDependencies();
  }

  removeMeal(selectedMealId) {
    setState(() {
      mealsToShow.removeWhere((meal) => meal.id == selectedMealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "$categoryTitle",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          final currentMeal = mealsToShow[index];
          return Hero(
            tag: mealsToShow[index].id,
            child: MealBox(
              currentMeal: currentMeal,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MealDetails.routeName,
                  arguments: {
                    "currentMeal": currentMeal,
                    "addToFav": widget.addToFav,
                    "favoriteMeals": widget.favoriteMeals,
                  },
                ).then((value) {
                  if (value != null) removeMeal(value);
                });
              },
            ),
          );
        },
        itemCount: mealsToShow.length,
      ),
    );
  }
}
