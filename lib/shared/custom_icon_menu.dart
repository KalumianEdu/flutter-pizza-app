import 'package:flutter/material.dart';
import 'package:pizza/shared/custom_icon.dart';

class CustomIconMenu extends StatefulWidget {
  int menuIndex;
  ValueNotifier<int> currentMenuIndex;
  String imagePath;
  String name;
  void Function()? onTap;
  IconData? iconData;
  CustomIconMenu({
    super.key,
    this.menuIndex = -1,
    required this.currentMenuIndex,
    required this.imagePath,
    required this.name,
    required this.onTap,
    this.iconData,
  });

  @override
  State<CustomIconMenu> createState() => _CustomIconMenuState();
}

class _CustomIconMenuState extends State<CustomIconMenu> {
  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: widget.menuIndex == widget.currentMenuIndex.value ? 1.1 : 1,
      duration: Duration(milliseconds: 300),
      child: Column(
        children: [
          InkWell(
            onTap: widget.onTap,
            child: widget.iconData == null
                ? CustomIcon(
                    iconData: Icons.grid_view,
                    size: MediaQuery.of(context).size.width / 8.5,
                    imagePath: widget.imagePath,
                  )
                : CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey.shade100,
                    child: Icon(widget.iconData, color: Colors.black),
                  ),
          ),
          SizedBox(height: 3),

          Text(
            widget.name,
            style: TextStyle(
              fontSize: 10,
              fontWeight: widget.menuIndex == widget.currentMenuIndex.value
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),

          SizedBox(height: 5),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 3,
            width: widget.menuIndex == widget.currentMenuIndex.value ? 25 : 0,

            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}
