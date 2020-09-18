import 'package:flutter/material.dart';

final _rowHeight = 100.0;
final _borderRadius = BorderRadius.circular(_rowHeight/2);

class Category extends StatelessWidget {
  final String name;
  final ColorSwatch color;
  final IconData iconLocation;

  /// Creates a [Category].
  ///
  /// A [Category] saves the name of the Category (e.g. 'Length'), its color for
  /// the UI, and the icon that represents it (e.g. a ruler).
  // TODO: You'll need the name, color, and iconLocation from main.dart
  const Category({
    Key key,
    @required this.name,
    @required this.color,
    @required this.iconLocation,
  })  : assert(name != null),
        assert(color != null),
        assert(iconLocation != null),
        super(key: key);

  /// Builds a custom widget that shows [Category] information.
  ///
  /// This information includes the icon, name, and color for the [Category].
  @override
  // This `context` parameter describes the location of this widget in the
  // widget tree. It can be used for obtaining Theme data from the nearest
  // Theme ancestor in the tree. Below, we obtain the display1 text theme.
  // See https://docs.flutter.io/flutter/material/Theme-class.html
  Widget build(BuildContext context) {
    // TODO: Build the custom widget here, referring to the Specs.
    return Material(
      color: Colors.transparent,
      child: Container(
        height: _rowHeight,
        child: InkWell(
          borderRadius: _borderRadius,
          highlightColor: color[50],
          splashColor: color[100],
          onTap: () {
            print("I was touched");
          },
          child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: Icon(
                        iconLocation,
                        size: 60.0,  
                      ),
                    ),
                    Center(
                      child: Text(
                        name,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    )
                  ])),
        ),
      ),
    );
  }
}
