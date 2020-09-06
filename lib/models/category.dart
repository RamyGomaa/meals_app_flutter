import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final AssetImage coverImage;

  const Category({@required this.title, @required this.id, this.coverImage});
}
