import 'package:flutter/material.dart';

import 'container_homepage.dart';
import 'curved_edges_widget.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key, required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
      child: Container(
        color: Colors.purple[300],
        padding: EdgeInsets.all(0),

        child:
        SizedBox(height: 400,
          child : Stack(
            children: [
               Positioned(top:-150,right:-250,
    child: TCircularContainer(backgroundColor: Colors.white.withOpacity(0.1)),),
                Positioned(top:100,right:300,
                  child: TCircularContainer(backgroundColor: Colors.white.withOpacity(0.1)),),
          child,
                ],

          ),
        ),
      ),
    );
  }
}