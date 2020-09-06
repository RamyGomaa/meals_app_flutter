import 'package:flutter/material.dart';
import 'package:meal_app/Screens/meal_details_screen.dart';
import 'package:meal_app/models/meal.dart';

import '../constant.dart';

class MealBox extends StatelessWidget {
  const MealBox({
    Key key,
    @required this.currentMeal,
    this.onTap,
  }) : super(key: key);

  final Meal currentMeal;
  final Function onTap;

  get getComplexity {
    switch (currentMeal.complexity) {
      case Complexity.Simple:
        return "Simple";
        break;
      case Complexity.Challenging:
        return "Challenging";
        break;
      case Complexity.Hard:
        return "Hard";
        break;
      default:
        return "Unkown";
    }
  }

  get getAffordability {
    switch (currentMeal.affordability) {
      case Affordability.Affordable:
        return "Affordable";
        break;
      case Affordability.Pricey:
        return "Pricey";
        break;
      case Affordability.Luxurious:
        return "Luxurious";
        break;
      default:
        return "Unkown";
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: screenSize.height * 0.02,
        horizontal: screenSize.width * 0.02,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image(
                    // you can make Image.network . easier
                    height: screenSize.height / 3,
                    width: double.infinity,
                    image: NetworkImage(
                      currentMeal.imageUrl,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  // positioned is only used in stack
                  bottom: 15,
                  right: 0,
                  child: Container(
                    color: Colors.black.withAlpha(100),
                    width: screenSize.width / 2,
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${currentMeal.title}",
                        style: TextStyle(
                          fontSize: 28,
                          color: kLightColor,
                          height: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: screenSize.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule),
                      SizedBox(
                        width: screenSize.width / 50,
                      ),
                      Text(
                        "${currentMeal.duration} min",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.all_inclusive),
                      SizedBox(
                        width: screenSize.width / 50,
                      ),
                      Text(getComplexity,
                          style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money),
                      SizedBox(
                        width: screenSize.width / 50,
                      ),
                      Text(getAffordability,
                          style: TextStyle(color: Colors.black54)),
                    ],
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
