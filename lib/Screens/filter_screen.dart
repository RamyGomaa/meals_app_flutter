import 'package:flutter/material.dart';
import 'package:meal_app/constant.dart';
import 'package:meal_app/widgets/drawer_body.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key key, this.filters, this.setFilters})
      : super(key: key);
  static final String routeName = "/filter_screen";
  final Map<String, bool> filters;
  final Function setFilters;

  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool isGlutenFree;
  bool isLactoseFree;
  bool isVegan;
  bool isVegetarian;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isGlutenFree = widget.filters["GlutenFree"];
      isLactoseFree = widget.filters["LactoseFree"];
      isVegan = widget.filters["Vegan"];
      isVegetarian = widget.filters["Vegetarian"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: DrawerBody(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Center(
                    child: Text(
                  "Filter Your Meals!",
                  style: TextStyle(fontSize: 30, color: kDarkGreenColor),
                )),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 25.0, right: 25.0, bottom: 0),
                child: ListView(
                  children: [
                    SwitchListTile(
                      activeColor: kPrimaryColor,
                      title: Text("Gluten-Free"),
                      onChanged: (value) {
                        setState(() {
                          isGlutenFree = value;
                        });
                      },
                      value: isGlutenFree,
                    ),
                    SwitchListTile(
                      activeColor: kPrimaryColor,
                      title: Text("Lactose-Free"),
                      onChanged: (value) {
                        setState(() {
                          isLactoseFree = value;
                        });
                      },
                      value: isLactoseFree,
                    ),
                    SwitchListTile(
                      activeColor: kPrimaryColor,
                      title: Text("Vegan"),
                      onChanged: (value) {
                        setState(() {
                          isVegan = value;
                        });
                      },
                      value: isVegan,
                    ),
                    SwitchListTile(
                      activeColor: kPrimaryColor,
                      title: Text("Vegetarian"),
                      onChanged: (value) {
                        setState(() {
                          isVegetarian = value;
                        });
                      },
                      value: isVegetarian,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.1),
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.3,
              child: RaisedButton(
                child: Text("Save"),
                onPressed: () {
                  final newFilters = {
                    "GlutenFree": isGlutenFree,
                    "LactoseFree": isLactoseFree,
                    "Vegan": isVegan,
                    "Vegetarian": isVegetarian
                  };
                  ;
                  widget.setFilters(newFilters);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
