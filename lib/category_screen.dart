import 'package:DietInsight/backdrop.dart';
import 'package:DietInsight/converter_screen.dart';
import 'package:flutter/material.dart';

import 'package:DietInsight/category.dart';
import 'package:DietInsight/diet.dart';

import 'category_widget.dart';


/// Category Route (screen).
///
/// This is the 'home' screen of the Diet Converter. It shows a header and
/// a list of [Categories].
///
/// While it is named CategoryRoute, a more apt name would be CategoryScreen,
/// because it is responsible for the UI at the route's destination.

class CategoryScreen extends StatefulWidget {
  const CategoryScreen();

  @override
  _CategoryRouteState createState() => _CategoryRouteState();
}

class _CategoryRouteState extends State<CategoryScreen> {
  final _categories = <Category>[];
  Category _defaultCategory;
  Category _currentCategory;

  static const _categoryNames = <String>[
    'Generic-foods',
    'Generic-meals',
    'Packaged-foods',
    'Fast-foods',
    'Other'
  ];

  static const _baseColors = <ColorSwatch>[
    ColorSwatch(0xFF6AB7A8, {
      'highlight': Color(0xFF6AB7A8),
      'splash': Color(0xFF0ABC9B),
    }),
    ColorSwatch(0xFFFFD28E, {
      'highlight': Color(0xFFFFD28E),
      'splash': Color(0xFFFFA41C),
    }),
    ColorSwatch(0xFFFFB7DE, {
      'highlight': Color(0xFFFFB7DE),
      'splash': Color(0xFFF94CBF),
    }),
    ColorSwatch(0xFF8899A8, {
      'highlight': Color(0xFF8899A8),
      'splash': Color(0xFFA9CAE8),
    }),
    ColorSwatch(0xFFEAD37E, {
      'highlight': Color(0xFFEAD37E),
      'splash': Color(0xFFFFE070),
    }),
    ColorSwatch(0xFF81A56F, {
      'highlight': Color(0xFF81A56F),
      'splash': Color(0xFF7CC159),
    }),
    ColorSwatch(0xFFD7C0E2, {
      'highlight': Color(0xFFD7C0E2),
      'splash': Color(0xFFCA90E5),
    }),
    ColorSwatch(0xFFCE9A9A, {
      'highlight': Color(0xFFCE9A9A),
      'splash': Color(0xFFF94D56),
      'error': Color(0xFF912D2D),
    }),
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
      var category = Category(
        name: _categoryNames[i],
        color: _baseColors[i],
        iconLocation: Icons.cake,
        diets: _retrieveDietList(_categoryNames[i]),
      );
      if (i == 0) {
        _defaultCategory = category;
      }
      _categories.add(category);
    }
  }

  void _onCategoryTap(Category category) {
    setState(() {
      _currentCategory = category;
    });
  }

  /// Makes the correct number of rows for the list view.
  ///
  /// For portrait, we use a [ListView].
  Widget _buildCategoryWidgets(Orientation deviceOrientation) {
    if(deviceOrientation == Orientation.portrait){
      return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return CategoryWidget(
          category: _categories[index],
          onTap: _onCategoryTap,
        );
      },
      itemCount: _categories.length,
    );
    }else{
      return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 3.0,
        children: _categories.map((Category c){
          return CategoryWidget(
            category: c, 
            onTap: _onCategoryTap,);
        }).toList(),
      );
    }
    
  }

  @override
  Widget build(BuildContext context) {
    final listView = Padding(
      padding: EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 48.0,
      ),
      child: _buildCategoryWidgets(MediaQuery.of(context).orientation),
    );

    return Backdrop(
      backPanel: listView, 
      currentCategory: _currentCategory == null ? _defaultCategory : _currentCategory, 
      frontPanel: _currentCategory == null
          ? ConverterScreen(category: _defaultCategory)
          : ConverterScreen(category: _currentCategory),
      backTitle: Text("Select a category"), 
      frontTitle: Text('Diet Converter'),
    );
  }
}
