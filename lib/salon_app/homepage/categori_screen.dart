
import 'package:estilo_salon/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widgets/appbar.dart';
import '../saloon_profils/categori_details_views.dart';

class CategoriScreen extends StatelessWidget {
  const CategoriScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: AppStyles.bold(title: AppStrings.category),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              mainAxisExtent: 170,
            ),
            itemCount: 10,
            itemBuilder: (BuildContext context,int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(
                      builder: (context) => CategoriDetailsViews()));

                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.bgDarkColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(iconsList[index],
                          width:60,
                          color: Vx.randomPrimaryColor,
                        ),
                      ),

                      Divider(
                        color: Colors.white,
                      ),

                      SizedBox(height: TSizes.spaceBtwItems),
                      AppStyles.bold(title: iconsTitleList[index],
                        color: AppColors.textColor,
                      ),
                      SizedBox(height: 10,),
                      AppStyles.normal(title: "3 Specialists",
                        color: AppColors.textColor.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
