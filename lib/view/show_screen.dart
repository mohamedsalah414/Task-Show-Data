import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../model/data_model.dart';

class ShowData extends StatefulWidget {
  const ShowData({Key? key}) : super(key: key);

  @override
  _ShowDataState createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  late Future<DataModel> futureData;
  int _current = 0;

  Future<DataModel> getData() async {
    // String body = json.encode(data);

    var response = await http.get(
      Uri.parse("https://run.mocky.io/v3/3a1ec9ff-6a95-43cf-8be7-f5daa2122a34"),
    );
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);
    // print(response.body);
    print(response.statusCode);

    print(response.body);

    return DataModel.fromJson(jsonResponse);
  }

  @override
  void initState() {
    futureData = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<DataModel>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Text('Error');

            }
            if (snapshot.hasData) {
              var str = snapshot.data!.date;
              var newStr = str.substring(0, 10) + ' ' + str.substring(11, 23);
              DateTime dt = DateTime.parse(newStr);
              return Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.share_outlined),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(snapshot.data!.isLiked
                          ? Icons.star
                          : Icons.star_border),
                    ),
                  ],
                ),
                extendBody: true,
                extendBodyBehindAppBar: true,
                body: ListView(
                  padding: EdgeInsets.zero,
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: size.height / 3.5,
                      child: _buildCarouselSlider(size, snapshot),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '# ${snapshot.data!.interest}',
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w300,
                                fontSize: 17),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            snapshot.data!.title,
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.calendar,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                DateFormat("EEE, d MMM yyyy hh:mm a", 'ar')
                                    .format(dt),
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    color: Colors.grey.shade400,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.pin,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(snapshot.data!.address,
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      color: Colors.grey.shade400,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          Divider(
                            color: Colors.grey.shade200,
                            height: 30,
                            thickness: 2,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                child: ClipOval(
                                  child: Image.network(
                                    snapshot.data!.trainerImg,
                                    fit: BoxFit.fill,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: size.width,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle),
                                        child: Image.asset(
                                          'assets/images/error-image-generic.png',
                                          fit: BoxFit.fill,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              buildTextTitle(snapshot.data!.trainerName),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          buildTextSubTitle(snapshot.data!.trainerInfo),
                          Divider(
                            color: Colors.grey.shade200,
                            height: 30,
                            thickness: 2,
                          ),
                          buildTextTitle('عن المغامرة'),
                          const SizedBox(
                            height: 5,
                          ),
                          buildTextSubTitle(snapshot.data!.occasionDetail),
                          Divider(
                            color: Colors.grey.shade200,
                            height: 30,
                            thickness: 2,
                          ),
                          buildTextTitle('سعر المغامرة'),
                          const SizedBox(
                            height: 5,
                          ),
                          buildTextSubTitle(snapshot.data!.price.toString()),
                          const SizedBox(
                            height: 25,
                          ),
                          Divider(
                            color: Colors.grey.shade200,
                            height: 30,
                            thickness: 2,
                          ),
                          buildTextTitle('انواع الحجز'),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 120,
                            width: size.width,
                            child:ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.reservTypes.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index)
                                {
                                  return Card(
                                    elevation: 2,
                                    child: ListTile(
                                      title: buildTextTitle(snapshot.data!.reservTypes[index].name),
                                      subtitle:buildTextSubTitle(' العدد : ${snapshot.data!.reservTypes[index].count.toString()}'),
                                      trailing: buildTextSubTitle(' السعر : ${snapshot.data!.reservTypes[index].price.toString()}'),

                                    ),
                                  );
                                }),
                          ),

                          SizedBox(
                            height: 65,
                            width: size.width,
                            child: ElevatedButton(
                                onPressed: () {},
                                child: const Text(
                                  'قم بالحجز الان',
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  Text buildTextSubTitle(String txt) {
    return Text(txt,

        style: TextStyle(
          fontFamily: 'Cairo',
            color: Colors.grey.shade400,
            fontWeight: FontWeight.w600,
            fontSize: 16));
  }

  Text buildTextTitle(String txt) {
    return Text(txt,
        style: TextStyle(
            fontFamily: 'Cairo',
            color: Colors.grey.shade500,
            fontWeight: FontWeight.bold,
            fontSize: 18));
  }

  Widget _buildCarouselSlider(size, AsyncSnapshot snapshot) {
    return Stack(
      children: [
        CarouselSlider.builder(
          // itemCount: snapshot.data!.directors.length,
          itemCount: snapshot.data!.img.length,
          options: CarouselOptions(
            height: size.height / 2,
            enlargeCenterPage: false,
            initialPage: _current,
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 2),
            reverse: false,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),

          itemBuilder: (context, i, id) {
            return Container(
              width: size.width,

              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(15),
              // ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                      // borderRadius: BorderRadius.circular(15),
                      child: SizedBox(
                        width: size.width,
                        child: Image.network(
                          snapshot.data!.img[i],
                          width: size.width,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: size.width,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: Image.asset(
                                'assets/images/error-image-generic.png',
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        // Positioned(
        //   bottom: 30,
        //   left: 130,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: AppConstants.salonImages.asMap().entries.map((entry) {
        //       return GestureDetector(
        //         onTap: () => _controller.animateToPage(entry.key),
        //         child: Container(
        //           width: 12.0,
        //           height: 12.0,
        //           margin: const EdgeInsets.symmetric(
        //               vertical: 8.0, horizontal: 4.0),
        //           decoration: BoxDecoration(
        //               shape: BoxShape.circle,
        //               color: (Colors.white)
        //                   .withOpacity(_current == entry.key ? 0.9 : 0.4)),
        //         ),
        //       );
        //     }).toList(),
        //   ),
        // ),
      ],
    );
  }
}
