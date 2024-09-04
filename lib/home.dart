import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pahadi_kitchen/modal.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<RecipeModal> recipeList = <RecipeModal>[];
  TextEditingController searchController = new TextEditingController();
  List recipeCat = [
    {
      "imageUrl" : "https://images.pexels.com/photos/12737916/pexels-photo-12737916.jpeg?auto=compress&cs=tinysrgb&w=600",
      "heading": "Shahi Paneer"
    },
    {
      "imageUrl": "https://images.pexels.com/photos/14882284/pexels-photo-14882284.jpeg?auto=compress&cs=tinysrgb&w=600",
      "heading" : "Pahadi dal"
    },
    {
      "imageUrl": "https://media.istockphoto.com/id/466114579/photo/varan-a-maharashtrian-dal.jpg?b=1&s=612x612&w=0&k=20&c=qIaFJFq4biZwlGm-ezd-sWBz4d0rHlDMRbWzGF--ZSw=",
      "heading": "Curry",
    },
    {
      "imageUrl": "https://media.istockphoto.com/id/1455889167/photo/healthy-nutritious-indian-comfort-food-dal-chawal-popular-food-yellow-dal-tadka-or-lentil.jpg?b=1&s=612x612&w=0&k=20&c=RE8RY6l6npcxlZW4938DWqc43AG4y9HEAz3_G5svvhw=",
      "heading" : "Dal"
    },
    {
      "imageUrl": "https://media.istockphoto.com/id/1318824826/photo/dal-chawal-with-sabji.jpg?b=1&s=612x612&w=0&k=20&c=NlFXchIzNJkkp5SCVsEwqQJj4jbt0Zd6nEOsUElxHcc=",
      "heading" : "Phadi mix bhojan"
    },
    {
      "imageUrl": "https://media.istockphoto.com/id/673858790/photo/butter-chicken-curry-with-tender-chicken-breast-cream-butter-honey.jpg?s=612x612&w=0&k=20&c=c_9bYsi6T3vnCz5_iYqdZViX3iPV4r3fL2oTGSps8W8=",
      "heading": "Chicken Curry"
      },
    {
      "imageUrl": "https://media.istockphoto.com/id/1347087219/photo/assortment-of-delicious-authentic-tacos-birria-carne-asada-adobada-cabeza-and-chicharone.jpg?s=612x612&w=0&k=20&c=8TJspKsshMc6QN8aBgnbaMgMwKKHZuLKRq8D_BYj5Tw=",
      "heading": "Mexican food"
    },
    {
      "imageUrl": "https://media.istockphoto.com/id/489728696/photo/table-full-of-mezze.jpg?s=612x612&w=0&k=20&c=Ptqi6ngyoILxnvmAKNwjVHyu8vUF9b-6TZ9Y7onpGAg=",
      "heading": "Various Arabic Cuisines Set"
    },
    {
      "imageUrl": "https://media.istockphoto.com/id/1947907612/photo/assorted-indian-thali-chicken-and-mutton-korma-set-with-biryani-plain-rice-pulao-chanay.jpg?s=612x612&w=0&k=20&c=zmA-zcLRrF0vYuV4loouNf1zx49FzdNbwT56XeejOJQ=",
      "heading": "All Indian Desi Foods"
    }

  ];

  Future<void> getData(query) async {
    String uriString =
        "https://api.edamam.com/search?q=$query&app_id=0e675bed&app_key=bd162685eb4f144a5b0ad55264fe7fba&from=0&to=3&calories=591-722&health=alcohol-free";
    Uri uri = Uri.parse(uriString);
    Response response = await get(uri);
    Map data = jsonDecode(response.body);
    // print(data);
    // log(data.toString());
    data["hits"].forEach((element) {
      RecipeModal recipeModal = new RecipeModal();
      recipeModal = RecipeModal.fromMap(element["recipe"]);
      recipeList.add(recipeModal);
      log(recipeList.toString());
    });
    recipeList.forEach((Recipe) {
      print(Recipe.appLabel);
      print(Recipe.appLabel);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData("Pizza");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xff213a50),
              Color(0xff071938),
            ])),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24)),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if ((searchController.text).replaceAll("   ", "") ==
                                "") {
                              print("Text is empty");
                            } else {
                              print("calling get data function");
                              getData(searchController.text);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(4, 0, 6, 0),
                            child: const Icon(
                              Icons.search_outlined,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: const InputDecoration(
                              hintText: "Let's cook Something..",
                              border: InputBorder.none,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What do you want to Cook Today?",
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Let's Cook Something new!",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    ],
                  ),
                ),
                Container(
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: recipeList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Card(
                            margin: EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 0.0,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    recipeList[index].appImageUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 200,
                                  ),
                                ),
                                Positioned(
                                    left: 0,
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        decoration: const BoxDecoration(
                                            color: Colors.black26),
                                        child: Text(
                                          recipeList[index].appLabel,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ))),
                                Positioned(
                                    right: 0,
                                    height: 30,
                                    width: 80,
                                    child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              bottomLeft: Radius.circular(10),
                                            )),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.local_fire_department,
                                                size: 15,
                                              ),
                                              Text(recipeList[index]
                                                  .appCalories
                                                  .toString()
                                                  .substring(0, 6)),
                                            ],
                                          ),
                                        )))
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                Container(
                    height: 200,
                    child: ListView.builder(
                        itemCount: recipeCat.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            child: InkWell(
                              onTap: () {},
                              child: Card(
                                margin: const EdgeInsets.all(15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                elevation: 0.0,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: Image.network(
                                        recipeCat[index]["imageUrl"].toString(),
                                        fit: BoxFit.cover,
                                        height: 200,
                                        width: 250,
                                        errorBuilder: (context , error,stackTree){
                                          return Container(
                                            height: 200,
                                            width: 250,
                                            color: Colors.grey,
                                            child: const Center(
                                              child:  Icon(Icons.error_rounded,color: Colors.red,size: 40,),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 5),
                                          decoration: const BoxDecoration(
                                            color: Colors.black45
                                          ),
                                            child: Text(recipeCat[index]["heading"],style: const TextStyle(color: Colors.white),)))
                                  ],
                                ),
                              ),
                            ),
                          );
                        })),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget MyWidget() {
//   return Text(
//     "My list view Builder widget here!",
//     style: TextStyle(color: Colors.white),
//   );
// }
