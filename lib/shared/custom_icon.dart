import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final IconData iconData;
  final Color color;
  final double size;
  final double radius;
  final String imagePath;

  const CustomIcon({
    Key? key,
    required this.iconData,
    this.color = Colors.transparent,
    this.size = 24,
    this.radius = 20,
    this.imagePath = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: Colors.grey, width: 1),
          color: color,
        ),
        child: imagePath == ''
            ? Icon(iconData, color: Colors.white, size: size)
            : ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(imagePath, fit: BoxFit.cover),
              ),
      ),
    );
  }
}
