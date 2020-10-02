import 'package:DietInsight/category.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'dart:io';

import 'package:DietInsight/diet.dart';

const _padding = EdgeInsets.all(16.0);

/// Converter screen where users can input amounts to convert.
///
/// Currently, it just displays a list of mock units.

class ConverterScreen extends StatefulWidget {
  /// Units for this [Category].

  final Category category;

  /// This [ConverterScreen] requires the color and units to not be null.
  const ConverterScreen({
    @required this.category,
  }) : assert(category != null);

  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  Diet _fromValue;
  Diet _toValue;
  List<DropdownMenuItem> _unitMenuItems;
  String _convertedValue = '';
  bool _showValidationError = false;
  double _inputValue = 1;
  final _inputKey = GlobalKey(debugLabel: 'inputText');
  Map mapDiet;

  @override
  void initState() {
    super.initState();
    _getDietInfo();
    _createDropdownMenuItems();
    _setDefaults();
  }

  @override
  void didUpdateWidget(ConverterScreen old) {
    super.didUpdateWidget(old);
    // We update our [DropdownMenuItem] units when we switch [Categories].
    if (old.category != widget.category) {
      _createDropdownMenuItems();
      _setDefaults();
      _getDietInfo();
    }
  }

  /// Sets the default values for the 'from' and 'to' [Dropdown]s.
  void _setDefaults() {
    setState(() {
      _fromValue = widget.category.diets[0];
      //  _inputValue = 1;
      _convertedValue = "0";
    });
  }

  void _updateConversion() {
    setState(() {
      _convertedValue = (_inputValue * mapDiet[_fromValue.name]).toString();
      // _format(_inputValue * (_toValue.conversion / _fromValue.conversion));
    });
    print(_fromValue.name);
    // _getDietInfo();
  }

  Future _getDietInfo() async {
    mapDiet = new Map();
    for (var i = 0; i <= 3; i++) {
      String url =
          "https://api.edamam.com/api/food-database/v2/parser?ingr=${widget.category.diets[i].name}&app_id=c60c29fb&app_key=7d668a4c08838927668279a49c1a31de";

      final client = HttpClient();
      final request = await client.getUrl(Uri.parse(url));
      final response = await request.close();
      final contentAsString = await utf8.decodeStream(response);
      final map = json.decode(contentAsString);
      var calorie;

      calorie = map["hints"][0]["food"]["nutrients"]["ENERC_KCAL"];
      mapDiet[widget.category.diets[i].name] = calorie;
    }
    setState(() {
      _convertedValue = mapDiet[_fromValue.name].toString();
    });
    _updateConversion();
    print(mapDiet);
  }

  void _updateInputValue(String input) {
    setState(() {
      if (input == null || input.isEmpty) {
        _convertedValue = '';
      } else {
        // Even though we are using the numerical keyboard, we still have to check
        // for non-numerical input such as '5..0' or '6 -3'
        try {
          final inputDouble = double.parse(input);
          _showValidationError = false;
          _inputValue = inputDouble;
          _updateConversion();
        } on Exception catch (e) {
          print('Error: $e');
          _showValidationError = true;
        }
      }
    });
  }

  Diet _getUnit(String unitName) {
    return widget.category.diets.firstWhere(
      (Diet unit) {
        return unit.name == unitName;
      },
      orElse: null,
    );
  }

  void _updateFromConversion(dynamic unitName) {
    setState(() {
      _fromValue = _getUnit(unitName);
    });
    if (_inputValue != null) {
      _updateConversion();
    }
  }

  /// Creates fresh list of [DropdownMenuItem] widgets, given a list of [Unit]s.
  void _createDropdownMenuItems() {
    var newItems = <DropdownMenuItem>[];
    for (var unit in widget.category.diets) {
      newItems.add(DropdownMenuItem(
        value: unit.name,
        child: Container(
          child: Text(
            unit.name,
            softWrap: true,
          ),
        ),
      ));
    }
    setState(() {
      _unitMenuItems = newItems;
    });
  }

  Widget _createDropdown(String currentValue, ValueChanged<dynamic> onChanged) {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
        // This sets the color of the [DropdownButton] itself
        color: Colors.grey[50],
        border: Border.all(
          color: Colors.grey[400],
          width: 1.0,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Theme(
        // This sets the color of the [DropdownMenuItem]
        data: Theme.of(context).copyWith(
          canvasColor: Colors.grey[50],
        ),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              value: currentValue,
              items: _unitMenuItems,
              onChanged: onChanged,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final input = Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // This is the widget that accepts text input. In this case, it
          // accepts numbers and calls the onChanged property on update.
          // You can read more about it here: https://flutter.io/text-input
          TextField(
            key: _inputKey,
            style: Theme.of(context).textTheme.headline4,
            decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.headline4,
              errorText: _showValidationError ? 'Invalid number entered' : null,
              labelText: 'Quantity',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
            // Since we only want numerical input, we use a number keyboard. There
            // are also other keyboards for dates, emails, phone numbers, etc.
            keyboardType: TextInputType.number,
            onChanged: _updateInputValue,
          ),
          _createDropdown(_fromValue.name, _updateFromConversion),
        ],
      ),
    );

    final arrows = RotatedBox(
      quarterTurns: 1,
      child: Icon(
        Icons.compare_arrows,
        size: 40.0,
      ),
    );

    final output = Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InputDecorator(
            child: Text(
              _convertedValue,
              style: Theme.of(context).textTheme.headline4,
            ),
            decoration: InputDecoration(
              labelText: 'Calories',
              labelStyle: Theme.of(context).textTheme.headline4,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
          ),
          // _createDropdown(_toValue.name, _updateToConversion),
        ],
      ),
    );

    final converter = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        input,
        arrows,
        output,
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: LinearProgressIndicator(
            valueColor:  new AlwaysStoppedAnimation<Color>(widget.category.color),
          ),
        ),
      ],
    );

    return Padding(
      padding: _padding,
      child: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          if (orientation == Orientation.portrait) {
            return SingleChildScrollView(
              child: converter,
            );
          } else {
            return SingleChildScrollView(
              child: Center(
                child: Container(
                  width: 450.0,
                  child: converter,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
