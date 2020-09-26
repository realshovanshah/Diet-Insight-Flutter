import 'package:DietInsight/category_screen.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// @required is defined in the meta.dart package
import 'package:meta/meta.dart';

import 'package:DietInsight/converter_screen.dart';
import 'package:DietInsight/diet.dart';

// We use an underscore to indicate that these variables are private.
// See https://www.dartlang.org/guides/language/effective-dart/design#libraries
final _rowHeight = 100.0;
final _borderRadius = BorderRadius.circular(_rowHeight / 2);

/// A custom [Category] widget.
///
/// The widget is composed on an [Icon] and [Text]. Tapping on the widget shows
/// a colored [InkWell] animation.
class Category {
  final String name;
  final ColorSwatch color;
  final List<Diet> diets;
  final IconData iconLocation;

  /// Information about a [Category].
  ///
  /// A [Category] saves the name of the Category (e.g. 'Length'), a list of its
  /// its color for the UI, units for conversions (e.g. 'Millimeter', 'Meter'),
  /// and the icon that represents it (e.g. a ruler).
  const Category({
    @required this.name,
    @required this.color,
    @required this.diets,
    @required this.iconLocation,
  })  : assert(name != null),
        assert(color != null),
        assert(diets != null),
        assert(iconLocation != null);
}