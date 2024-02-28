import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/fonts.dart';
import '../../utils/image_strings.dart';
import '../../widgets/appbar.dart';

class CategoriDetailsViews extends StatelessWidget {
  const CategoriDetailsViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppStyles.bold(
            title: "Category Name",color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 170,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: 10,
            itemBuilder: (BuildContext context,int index) {
              return Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: AppColors.bgDarkColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.only(right: 8),
                 height: 100,
                 width: 150,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      color: Colors.lightBlue,
                      child: Image.asset(TImages.saloon1,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),

                    SizedBox(height: TSizes.spaceBtwItems),
                    AppStyles.normal(title:"Saloon Name"),
                    VxRating(
                      selectionColor: AppColors.yellowColor,
                      onRatingUpdate: (value) {},
                      maxRating: 5,
                      count: 5,
                      value: 4,
                      stepInt: true,
                    )
                  ],
                ),
              ) ;
            }
        ),
      ),
    );
  }
}
