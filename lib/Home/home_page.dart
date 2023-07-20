import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Home/Components/gym_sub_widget.dart';
import 'package:flutter_app/Home/Model/gym_response_model.dart';
import 'package:flutter_app/constants/constant.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Components/recommended_wiget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future? _future;

  List<Gyms> gymsList = [];
  int _selectedIndex = 0;
  List popularList = [];
  int _popularSelected = 0;
  String _listName = "";

  @override
  void initState() {
    super.initState();
    _future = _jsonToData();
    popularList = [
      ImageConstraint.aerobicsPopular,
      ImageConstraint.boxPopular,
      ImageConstraint.childrenSelectionPopular,
      ImageConstraint.dancesPopular,
      ImageConstraint.runPopular,
      ImageConstraint.swimmingPopular,
      ImageConstraint.wrestlingPopular,
      ImageConstraint.yogaPopular,
    ];
  }

  var prefs;

  @override
  Widget build(BuildContext context) {
    var _info = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: SvgPicture.asset(
              ImageConstraint.dumbbellSvg,
              color: Colors.white,
            ),
          ),
          leadingWidth: 33,
          actions: [
            SvgPicture.asset(
              ImageConstraint.boxPopular,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SvgPicture.asset(
                ImageConstraint.searchSvg,
                color: Colors.white,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: SizedBox(
                width: 25,
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage(ImageConstraint.userProfile),
                  // child: Image.asset(name),
                ),
              ),
            )
          ],
        ),
        body: FutureBuilder(
            future: _future,
            builder: (context, snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///Recommended List
                        Text(
                          AppString.recommended,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: _info.size.width * 0.05),
                        ),
                        _recommendedList(),
                        SizedBox(height: _info.size.height * 0.02),

                        ///Popular List
                        Text(
                          AppString.popular,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: _info.size.width * 0.05),
                        ),
                        _popularClasses(),

                        ///Gym subList
                        SizedBox(height: _info.size.height * 0.02),
                        _subList()
                      ],
                    ),
                  ),
                );
              }
            }));
  }

  ///Recommended List
  _recommendedList() {
    var _info = MediaQuery.of(context);
    return SizedBox(
      height: _info.size.height * 0.34,
      child: ListView.builder(
          itemCount: gymsList.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var recommendedList = gymsList[index];
            gymsList[index].favorite =
                prefs.getBool(recommendedList.title.toString()) ?? false;
            return InkWell(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                  _listName = recommendedList.title.toString();
                });
              },
              child: RecommendedWidget(
                title: recommendedList.title.toString(),
                date: recommendedList.date.toString(),
                favorite: recommendedList.favorite!,
                price: recommendedList.price.toString(),
                rating: recommendedList.rating.toString(),
                onTap: () async {
                  setState(() {
                    if (gymsList[index].favorite!) {
                      gymsList[index].favorite = false;
                      prefs.setBool(gymsList[index].title.toString(), false);
                    } else {
                      gymsList[index].favorite = true;
                      prefs.setBool(gymsList[index].title.toString(), true);
                    }
                  });
                },
              ),
            );
          }),
    );
  }

  ///Popular List
  _popularClasses() {
    var _info = MediaQuery.of(context);
    return SizedBox(
      height: _info.size.height * 0.09,
      child: ListView.builder(
          itemCount: popularList.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  _popularSelected = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  height: _info.size.height * 0.09,
                  width: _info.size.height * 0.08,
                  child: Card(
                    elevation: 3,
                    color:
                        _popularSelected == index ? Colors.blue : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        popularList[index],
                        color: _popularSelected == index
                            ? Colors.white
                            : Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  ///Sub List
  _subList() {
    return gymsList[_selectedIndex].popularClasess!.isEmpty
        ? const Center(
            child: Text(
            "Data not Found!",
            style: TextStyle(fontWeight: FontWeight.bold),
          ))
        : ListView.builder(
            itemCount: gymsList[_selectedIndex].popularClasess!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var subList = gymsList[_selectedIndex].popularClasess![index];

              subList.favorite =
                  prefs.getBool("${subList.title.toString()}$_listName") ??
                      false;
              return GymSubListWidget(
                title: subList.title.toString(),
                price: subList.price.toString(),
                time: subList.time.toString(),
                location: subList.location.toString(),
                favorite: subList.favorite!,
                onTap: () {
                  setState(() {
                    if (subList.favorite!) {
                      subList.favorite = false;
                      prefs.setBool(
                          "${subList.title.toString()}$_listName", false);
                    } else {
                      subList.favorite = true;
                      prefs.setBool(
                          "${subList.title.toString()}$_listName", true);
                    }
                  });
                },
              );
            });
  }

  _jsonToData() async {
    prefs = await SharedPreferences.getInstance();
    final String response =
        await rootBundle.loadString('assets/class/data.json');
    var data = jsonDecode(response);
    var resModel = GymResponse.fromJson(data);
    gymsList = resModel.gyms!.toList();
  }
}
