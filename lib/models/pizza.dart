import 'package:pizza/models/size.dart';

class pizza {
  final String title;
  final String subTitle;
  final String image;
  final String description;
  final List<PizzaSize> sizes;

  pizza({
    required this.title,
    required this.subTitle,
    required this.image,
    required this.description,
    required this.sizes,
  });
}
