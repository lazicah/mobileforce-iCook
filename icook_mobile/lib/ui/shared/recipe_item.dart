import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icook_mobile/models/response/Dish/getmydishes.dart';
import 'package:icook_mobile/ui/shared/recipe_item_model.dart';
import 'package:stacked/stacked.dart';
import 'package:carousel_pro/carousel_pro.dart';

class RecipeItem extends StatelessWidget {
  final Dishe dish;

  const RecipeItem({Key key, this.dish}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RecipeItemModel>.reactive(
      viewModelBuilder: () => RecipeItemModel(),
      onModelReady: (model) => model.setData(dish),
      builder: (context, model, child) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Divider(),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => model.seeUserInfo(),
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/chefavatar1.png'),
                            radius: 25,
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => model.seeUserInfo(),
                            child: Text(dish.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(model.time),
                ],
              ),
            ),
            SizedBox(
              height: 17,
            ),
            Container(
              height: 248,
              width: MediaQuery.of(context).size.width,
              child: Carousel(
                images: dish.dishImages.map((e) => AssetImage(e)).toList(),
                dotSize: 6.0,
                dotIncreaseSize: 1.5,
                dotSpacing: 20.0,
                dotColor: Colors.white,
                dotIncreasedColor: Colors.blue,
                autoplay: false,
                indicatorBgPadding: 5.0,
                dotVerticalPadding: 20,
                defaultImage: AssetImage('assets/images/icook_logo.png'),
                dotBgColor: Colors.transparent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 0, top: 11.5),
                        child: GestureDetector(
                            onTap: () => model.like(),
                            child: model.isLiked
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 32,
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                    size: 32,
                                  )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 19, top: 15),
                        child: GestureDetector(
                            onTap: () {},
                            child: ImageIcon(AssetImage(
                                'assets/images/message-circle.png'))),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, top: 11.5),
                    child:
                        GestureDetector(onTap: () {}, child: Icon(Icons.menu)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "${model.likes} likes",
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: GestureDetector(
                onTap: () => model.seeDetails(dish),
                child: Text(
                  dish.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: GestureDetector(
                onTap: () => model.seeDetails(dish),
                child: Text(
                  dish.healthBenefits.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      color: Color(0xFF828282),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
