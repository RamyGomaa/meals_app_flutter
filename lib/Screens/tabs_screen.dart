import 'package:flutter/material.dart';
import 'package:meal_app/Screens/favorites_screen.dart';
import 'package:meal_app/Screens/meals_categories_screen.dart';
import 'package:meal_app/constant.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widgets/drawer_body.dart';

class TabsScreen extends StatefulWidget {
  TabsScreen(
      {Key key,
      this.favoriteMeals,
      this.addFavoriteMeal,
      this.removeMealFromFavorites})
      : super(key: key);
  final List<Meal> favoriteMeals;
  static String routeName = "/";
  final addFavoriteMeal;
  final removeMealFromFavorites;
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedTap = 0;
  List<Map<String, Object>> _navBarScreens;
  void initState() {
    _navBarScreens = [
      {'page': MealsCategoriesScreen(), "title": "Categories"},
      {
        'page': FavoritesScreen(
          favoriteMeals: widget.favoriteMeals,
          addFavoriteMeal: widget.addFavoriteMeal,
          removeMealFromFavorites: widget.removeMealFromFavorites,
        ),
        "title": "Favorites"
      },
    ];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildBottomNavigationBar();
  }

// for bottom bar
  Scaffold buildBottomNavigationBar() {
    return Scaffold(
      appBar: AppBar(
        title: Text(_navBarScreens[_selectedTap]['title']),
      ),
      drawer: DrawerBody(),
      body: _navBarScreens[_selectedTap]["page"],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTap,
        onTap: (value) {
          setState(() {
            _selectedTap = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text("Categories"),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: Colors.redAccent,
              ),
              title: Text("Favorits")),
        ],
      ),
    );
  }

  //for top tabbar
  DefaultTabController buildTopNavigationBar() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Meals App"),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: kLightColor,
            labelColor: kLightColor,
            unselectedLabelColor: Colors.black.withAlpha(130),
            onTap: (value) {
              setState(() {
                _selectedTap = value;
              });
            },
            tabs: [
              Tab(
                icon: Icon(
                  Icons.category,
                  color: _selectedTap == 0 ? kPrimaryColor : Colors.black45,
                ),
                text: "Categories",
              ),
              Tab(
                icon: Icon(
                  Icons.favorite,
                  color: _selectedTap == 1 ? Colors.redAccent : Colors.black45,
                ),
                text: "Favorites",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MealsCategoriesScreen(),
            FavoritesScreen(),
          ],
        ),
      ),
    );
  }
}
