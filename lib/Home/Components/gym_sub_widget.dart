import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/constant.dart';

class GymSubListWidget extends StatelessWidget {
  final String title;
  final String price;
  final String time;
  final String location;
  final bool favorite;
  final onTap;

  const GymSubListWidget({
    Key? key,
    required this.title,
    required this.price,
    required this.time,
    required this.location,
    required this.favorite,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _info = MediaQuery.of(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      shadowColor: Colors.black,
      elevation: 3,
      child: SizedBox(
        height: _info.size.height * 0.16,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  height: _info.size.height * 0.16,
                  width: _info.size.width * 0.33,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/class/$title.png")),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10))),
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
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            title.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
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
                          ),
                        )
                      ],
                    ),
                    Text(
                      "Gym \"Seven\"",
                      style: TextStyle(fontSize: _info.size.width * 0.04),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          ImageConstraint.locationSvg,
                          height: _info.size.height * 0.02,
                          color: Colors.blue,
                        ),
                        Flexible(
                            child: Text(
                          location.toString(),
                          style: TextStyle(fontSize: _info.size.width * 0.03),
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          ImageConstraint.watchSvg,
                          height: _info.size.height * 0.02,
                          color: Colors.blue,
                        ),
                        Text(
                          time.toString(),
                          style: TextStyle(fontSize: _info.size.width * 0.03),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
