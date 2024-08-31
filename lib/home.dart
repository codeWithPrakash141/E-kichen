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
  Future<void>getData(query) async {
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
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
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
                  padding: EdgeInsets.symmetric(horizontal: 28),
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
                                        )
                                      ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.local_fire_department,size: 15,),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget MyWidget() {
  return Text(
    "My list view Builder widget here!",
    style: TextStyle(color: Colors.white),
  );
}
