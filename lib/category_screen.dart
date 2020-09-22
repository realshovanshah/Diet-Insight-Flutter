import 'package:flutter/material.dart';

import 'package:DietInsight/category.dart';
import 'package:DietInsight/diet.dart';

final _backgroundColor = Colors.green[100];

/// Category Route (screen).
///
/// This is the 'home' screen of the Diet Converter. It shows a header and
/// a list of [Categories].
///
/// While it is named CategoryRoute, a more apt name would be CategoryScreen,
/// because it is responsible for the UI at the route's destination.

class CategoryRoute extends StatefulWidget {
  const CategoryRoute();

  @override
  _CategoryRouteState createState() => _CategoryRouteState();
}

class _CategoryRouteState extends State<CategoryRoute> {
  final _categories = <Category>[];

  static const _categoryNames = <String>[
    'Generic-foods',
    'Generic-meals',
    'Packaged-foods',
    'Fast-foods',
    'Other'
  ];

  static const _baseColors = <Color>[
    Colors.orange,
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.purpleAccent,
    Colors.redAccent,
  ];

  /// Returns a list of mock [Diet]s.
  List<Diet> _retrieveDietList(String categoryName) {
    return List.generate(10, (int i) {
      i += 1;
      return Diet(
        name: '$categoryName Diet $i',
        conversion: i.toDouble(),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < _categoryNames.length; i++) {
      _categories.add(Category(
        name: _categoryNames[i],
        color: _baseColors[i],
        iconLocation: Icons.cake,
        diets: _retrieveDietList(_categoryNames[i]),
      ));
    }
  }

  /// Makes the correct number of rows for the list view.
  ///
  /// For portrait, we use a [ListView].
  Widget _buildCategoryWidgets() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => _categories[index],
      itemCount: _categories.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final listView = Container(
      color: _backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: _buildCategoryWidgets(),
    );

    final appBar = AppBar(
      elevation: 0.0,
      title: Text(
        'Diet Converter',
        style: TextStyle(
          color: Colors.black,
          fontSize: 30.0,
        ),
      ),
      centerTitle: true,
      backgroundColor: _backgroundColor,
    );

    return Scaffold(
      appBar: appBar,
      body: listView,
    );
  }
}
