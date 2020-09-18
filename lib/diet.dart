import 'package:meta/meta.dart';

/// Information about a [Unit].
class Diet {
  final String name;
  final double conversion;

  /// A [Unit] stores its name and conversion factor.
  ///
  /// An example would be 'Meter' and '1.0'.
  const Diet({
    @required this.name,
    @required this.conversion,
  })  : assert(name != null),
        assert(conversion != null);

  /// Creates a [Unit] from a JSON object.
  Diet.fromJson(Map jsonMap)
      : assert(jsonMap['name'] != null),
        assert(jsonMap['conversion'] != null),
        name = jsonMap['name'],
        conversion = jsonMap['conversion'].toDouble();
}