import 'package:flutter/material.dart';

import '../salon_app/homepage/homepage_screen.dart';
import 'appbar.dart';
import 'cart_menu_icon.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(TTexts.homeAppbarTitle,
          //     style: Theme.of(context)
          //         .textTheme
          //         .labelMedium!
          //         .apply(color: Colors.grey)),
          // Text(TTexts.homeAppbarSubTitle,
          //     style: Theme.of(context)
          //         .textTheme
          //         .headlineSmall!
          //         .apply(color: Colors.black)),
        ],
      ),
      actions: [
        TCartCounterIcon(
          onPressed: () {},
          iconColor: Colors.white,
        )
      ],
    );
  }
}