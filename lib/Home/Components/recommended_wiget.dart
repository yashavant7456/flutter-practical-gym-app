import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/constant.dart';

class RecommendedWidget extends StatelessWidget {
  final String title;
  final String price;
  final String date;
  final String rating;
  final bool favorite;
  final onTap;
  const RecommendedWidget(
      {Key? key,
      required this.title,
      required this.price,
      required this.date,
      required this.rating,
      required this.favorite,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _info = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        shadowColor: Colors.black,
        elevation: 3,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: _info.size.height * 0.34,
              width: _info.size.width * 0.5 - 005,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(ImageConstraint.mapGym))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        height: _info.size.height * 0.14,
                        width: _info.size.width * 4,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15.0)),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/gym/$title.png"),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: onTap,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            favorite
                                ? ImageConstraint.favoriteSelectedSvg
                                : ImageConstraint.favoriteSvg,
                            color: favorite ? Colors.red : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: _info.size.height * 0.09,
                    width: _info.size.width * 4,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Column(
                                children: [
                                  Text(
                                    "\$$price",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: _info.size.width * 0.04),
                                  ),
                                  Text(
                                    "/day",
                                    style: TextStyle(
                                        fontSize: _info.size.width * 0.03),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber[700],
                                    size: _info.size.width * 0.06,
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    rating.toString(),
                                    style: TextStyle(
                                        fontSize: _info.size.width * 0.03),
                                  )
                                ],
                              ),
                              Text(
                                date.toString(),
                                style: TextStyle(
                                    fontSize: _info.size.width * 0.03),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _info.size.height * 0.03),
              child: SvgPicture.asset(
                ImageConstraint.locationSvg,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
