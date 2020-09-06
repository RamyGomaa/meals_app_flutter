import 'package:flutter/material.dart';
import 'package:meal_app/constant.dart';
import 'package:meal_app/models/dummy_categories_data.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/meal_box.dart';

class MealDetails extends StatefulWidget {
  const MealDetails({
    Key key,
  }) : super(key: key);

  static final String routeName = "/meals_details_screen";

  @override
  _MealDetailsState createState() => _MealDetailsState();
}

class _MealDetailsState extends State<MealDetails> {
  bool showIngredients = false;
  bool showSteps = false;

  IconData floatingButtonIcon(List<Meal> favoriteMeals, Meal meal) {
    if (favoriteMeals.any((element) => element.id == meal.id))
      return Icons.remove_circle;
    else
      return Icons.favorite;
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    Meal meal = arguments["currentMeal"];
    Function addToFav = arguments["addToFav"];
    List<Meal> favoriteMeals = arguments["favoriteMeals"];

    return Scaffold(
      floatingActionButton: addToFav == null
          ? null
          : FloatingActionButton(
              backgroundColor: kLightColor,
              onPressed: () {
                addToFav(meal.id);
              },
              child: Icon(
                floatingButtonIcon(favoriteMeals, meal),
                color: Colors.red[900],
              ),
            ),
      backgroundColor: kDarkGreenColor,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Hero(
              tag: meal.id,
              child: MealBox(
                currentMeal: meal,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0)),
                    ),
                    child: Column(
                      children: [
                        MealDetailsSubTitle(
                          subTitle: "Ingredients",
                          dropedDown: showIngredients,
                          onPress: () {
                            setState(() {
                              showIngredients = !showIngredients;
                            });
                          },
                        ),
                        if (showIngredients)
                          MealDetialsSubTitleBody(meal: meal.ingredients),
                        SizedBox(
                          height: 2,
                        ),
                        MealDetailsSubTitle(
                          subTitle: "Steps",
                          dropedDown: showSteps,
                          onPress: () {
                            setState(() {
                              showSteps = !showSteps;
                            });
                          },
                        ),
                        if (showSteps)
                          MealDetialsSubTitleBody(meal: meal.steps),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MealDetialsSubTitleBody extends StatelessWidget {
  MealDetialsSubTitleBody({
    Key key,
    @required this.meal,
  }) : super(key: key);

  final List<String> meal;
  final ScrollController scrollController =
      ScrollController(); // to always show the scrollbar we need a controller
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        child: Scrollbar(
          isAlwaysShown: true,
          controller:
              scrollController, // we made isAlwaysShown to true, thus we need a controller
          child: ListView.builder(
            controller: scrollController,
            itemCount: meal.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 55),
                child: Column(
                  children: [
                    Container(
                      child: Center(
                        child: Text(
                          meal[index],
                          style: TextStyle(
                            fontSize: 18,
                            textBaseline: TextBaseline.alphabetic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 100,
                      height: 1,
                      color: kDarkGreenColor,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class MealDetailsSubTitle extends StatelessWidget {
  const MealDetailsSubTitle({
    @required this.subTitle,
    this.onPress,
    Key key,
    this.dropedDown,
  }) : super(key: key);
  final Function onPress;
  final String subTitle;
  final dropedDown;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        color: Colors.black.withAlpha(15),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        child: Row(
          children: [
            Spacer(),
            Text(
              subTitle.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            Spacer(),
            Icon(dropedDown ? Icons.arrow_drop_up : Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
