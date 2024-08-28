import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = new TextEditingController();
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
          Column(
            children: [
              SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 25),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24)),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if ((searchController.text).replaceAll("   ", "") ==
                              "") {
                          } else {
                            Navigator.pushReplacementNamed(context, "/loading",
                                arguments: {
                                  "search_text": searchController.text,
                                });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                          child: const Icon(Icons.search_outlined),
                        ),
                      ),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
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
                     Text("What do you want to Cook Today?",style: TextStyle(fontSize: 40,color: Colors.white),),
                     SizedBox(height: 10,),
                     Text("Let's Cook Something new!",style: TextStyle(fontSize: 20,color: Colors.white),)
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
