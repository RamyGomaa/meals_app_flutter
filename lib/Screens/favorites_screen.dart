import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/meal_box.dart';

import 'meal_details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen(
      {Key key,
      this.favoriteMeals,
      this.addFavoriteMeal,
      this.removeMealFromFavorites})
      : super(key: key);
  final List<Meal> favoriteMeals;
  final addFavoriteMeal;
  final removeMealFromFavorites;

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widget.favoriteMeals.isEmpty
            ? Text("You didnot add any favorites yet!")
            : ListView.builder(
                itemCount: widget.favoriteMeals.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onLongPress: () {
                      setState(() {
                        widget.removeMealFromFavorites(index);
                      });
                    },
                    child: MealBox(
                      currentMeal: widget.favoriteMeals[index],
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          MealDetails.routeName,
                          arguments: {
                            "currentMeal": widget.favoriteMeals[index],
                            "addToFav": widget.addFavoriteMeal,
                            "favoriteMeals": widget.favoriteMeals,
                          },
                        ).then((value) {
                          setState(() {});
                        });
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
