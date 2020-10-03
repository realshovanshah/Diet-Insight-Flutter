
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// @required is defined in the meta.dart package
import 'package:meta/meta.dart';

import 'package:DietInsight/diet.dart';

/// A custom [Category] widget.
///
/// The widget is composed on an [Icon] and [Text]. Tapping on the widget shows
/// a colored [InkWell] animation.
class Category {
  final String name;
  final ColorSwatch color;
  final List<Diet> diets;
  final String iconLocation;

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