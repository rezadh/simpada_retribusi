import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  VoidCallback onPressed;
  bool bottomIcons;
  String text;
  IconData icons;

  BottomBar(
      {required this.onPressed,
      required this.bottomIcons,
      required this.text,
      required this.icons});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: widget.onPressed,
          child: widget.bottomIcons == true ? Container(
            decoration: BoxDecoration(
              color: Color(0xFF027A6D).withOpacity(0.6),
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.only(
                left: 20, right: 20, top: 4, bottom: 4),
            child: Column(
              children: [
                Icon(
                  widget.icons,
                  color: Colors.white,
                ),
                Text(
                  widget.text,
                  style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'poppins regular',
                      color: Colors.white),
                ),
              ],
            ),
          ) : Container(
            padding: EdgeInsets.only(
                left: 20, right: 20, top: 4, bottom: 4),
            child: Column(
              children: [
                Icon(
                  widget.icons,
                  color: Colors.white,
                ),
                Text(
                  widget.text,
                  style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'poppins regular',
                      color: Colors.white),
                ),
              ],
            ),
          ),
        );
  }
}
