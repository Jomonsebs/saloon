import 'package:flutter/material.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({
    super.key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = true,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  //device_utility.dart
  static double getAppBarHeight() {
    return kToolbarHeight;
  }

  @override
  Widget build(BuildContext context) {
    return
      Padding(
          padding: EdgeInsets.symmetric(horizontal: TSizes.md),
          child: AppBar(
            automaticallyImplyLeading: false,
            leading: showBackArrow
                ? IconButton(
                onPressed: () => Navigator.pop(context),
                icon:const Icon(Icons.arrow_left_outlined),
            )
                : leadingOnPressed != null ? IconButton(
                onPressed: leadingOnPressed, icon: Icon(leadingIcon)): null,
            title: title,
            actions: actions,
          )
      );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(getAppBarHeight());
}



//sizes.dart
class TSizes {
  static const double md = 16.0;
  static const double cardRadiusLg = 16.0;
  //default spacing betwn sections
  static const double defaultSpace = 24.0;
  static const double spaceBtwSections = 32.0;
  static const double spaceBtwItems = 16.0;
  //padding & margin sizes
  static const double sm = 8.0;
  //Product dimensions
  static const double productImageRadius = 16.0;
  static const double productImageSize = 120.0;
  static const double productItemHeight = 160.0;
  //card sizes
  static const double cardRadiusMd = 12.0;
  static const double cardRadiusSm = 10.0;
  static const double cardRadiusXs = 6.0;
  static const double cardElevation = 2.0;
}
