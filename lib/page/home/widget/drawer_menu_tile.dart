import 'package:flutter/material.dart';

class DrawerMenuTile {
  build({Widget? title, VoidCallback? onTap}) {
    return DrawerTile(
      title: title,
      onTap: onTap
    );
  }
}

class DrawerTile {
  Widget? title;
  VoidCallback? onTap;
  factory DrawerTile({title,onTap}){
    return DrawerTile(
      title: title,
      onTap: onTap
    );
  }
}