import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meal_app/Screens/filter_screen.dart';
import 'package:meal_app/Screens/meal_details_screen.dart';
import 'package:meal_app/Screens/meals_of_type_screen.dart';
import 'package:meal_app/Screens/tabs_screen.dart';
import 'package:meal_app/models/dummy_categories_data.dart';
import 'package:meal_app/models/meal.dart';
import 'Screens/meals_categories_screen.dart';
import 'constant.dart';

void main() {
  // to make the app run only on portrait mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyMealsApp());
}

class MyMealsApp extends StatefulWidget {
  const MyMealsApp({Key key}) : super(key: key);

  @override
  _MyMealsAppState createState() => _MyMealsAppState();
}

class _MyMealsAppState extends State<MyMealsApp> {
  List<Meal> favoriteMeals = [];

  Map<String, bool> _filters = {
    "GlutenFree": false,
    "LactoseFree": false,
    "Vegan": false,
    "Vegetarian": false
  };

  setFilters(Map<String, bool> newFilters) {
    setState(
      () {
        _filters = newFilters;
      },
    );
  }

  addFavoriteMeal(String mealID) {
    int mealIndex = favoriteMeals.indexWhere((element) => element.id == mealID);

    setState(() {
      if (mealIndex == -1) {
        favoriteMeals.add(DummyData.DUMMY_MEALS
            .firstWhere((element) => element.id == mealID));
      } else {
        favoriteMeals.removeAt(mealIndex);
      }
    });
  }

  removeMealFromFavorites(index) {
    setState(() {
      favoriteMeals.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        accentColor: kAccentColor,
        scaffoldBackgroundColor: kLightColor,
        appBarTheme: AppBarTheme().copyWith(color: kDarkGreenColor),
      ),
      routes: {
        TabsScreen.routeName: (ctx) => TabsScreen(
              favoriteMeals: favoriteMeals,
              addFavoriteMeal: addFavoriteMeal,
              removeMealFromFavorites: removeMealFromFavorites,
            ),
        MealsCategoriesScreen.routeName: (ctx) => MealsCategoriesScreen(),
        MealsOfTypeScreen.routeName: (ctx) => MealsOfTypeScreen(
              filters: _filters,
              addToFav: addFavoriteMeal,
              favoriteMeals: favoriteMeals,
            ),
        MealDetails.routeName: (ctx) => MealDetails(),
        FilterScreen.routeName: (ctx) => FilterScreen(
              filters: _filters,
              setFilters: setFilters,
            ),
      },
      // initialRoute: TabsScreen.routeName,
    );
  }
}
