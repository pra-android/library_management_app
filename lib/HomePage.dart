import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:library_management_app/BBS.dart';
import 'package:library_management_app/BBSTeacher.dart';
import 'package:library_management_app/BCA.dart';
import 'package:library_management_app/BCATeacher.dart';
import 'package:library_management_app/BHM.dart';
import 'package:library_management_app/BIM.dart';
import 'package:library_management_app/BIT.dart';
import 'package:library_management_app/BSCCSIT.dart';
import 'package:library_management_app/CSITTeacher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Initialing required things for first grid
  List<Icon> firstgridicons = [
    const Icon(
      Icons.computer,
      color: Colors.white,
      size: 32,
    ),
    const Icon(Icons.computer_sharp, color: Colors.white, size: 32),
    const Icon(Icons.people, color: Colors.white, size: 32)
  ];
  List<String> firstgridtext = ["BSC.CSIT", "BCA", "BBS"];
  List<String> firstgridtextfullform = [
    'Bachelor in Computer Science and Information Technology',
    'Bachelor of Computer Application',
    'Bachelor of Business Studies'
  ];
  List<Color> firstgridcolor = [Colors.teal, Colors.purple, Colors.red];

  //Initializing Required things for 2nd grid
  List<Icon> secondgridicons = [
    const Icon(
      Icons.manage_accounts,
      color: Colors.white,
      size: 32,
    ),
    const Icon(Icons.computer_sharp, color: Colors.white, size: 32),
    Icon(Icons.hotel_sharp, color: Colors.white, size: 32)
  ];
  List<String> secondgridtext = ["BIM", "BIT", "BHM"];
  List<Color> secondgridcolor = [Colors.blue, Colors.pink, Colors.green];

  //Filteredlists
  List<String> firstgridfilteredtext = [];
  List<String> secondgridfilteredtext = [];
  List<Icon> firstgridfilteredicon = [];
  List<Icon> secondgridfilteredicon = [];
  List<Color> firstgridfilteredcolor = [];
  List<Color> secondgridfilteredcolor = [];
  List<Widget> firstfilteredwidget = [];
  List<Widget> secondfilteredwidget = [];

  //List Tile Navigation pages
  List<Widget> listtilenavigation = [
    CSITTeacher(),
    BCATeacher(),
    BBSTeacher(),
  ];

  //List of pages
  List<Widget> firstgridpages = [
    BSCCSIT(),
    BCA(),
    BBS(),
  ];
  List<Widget> secondgridpages = [BIM(), BIT(), BHM()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstgridfilteredtext = firstgridtext;
    secondgridfilteredtext = secondgridtext;
    firstgridfilteredicon = firstgridicons;
    secondgridfilteredicon = secondgridicons;
    firstgridfilteredcolor = firstgridcolor;
    secondgridfilteredcolor = secondgridcolor;
    firstfilteredwidget = firstgridpages;
    secondfilteredwidget = secondgridpages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.red,
          centerTitle: true,
          leading: IconButton(
              onPressed: exitfromapp, icon: Icon(Icons.arrow_back_ios_sharp)),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10.0, bottom: 2.0),
              child: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Center(
                            child: Text(
                          "About This App",
                          style: GoogleFonts.aBeeZee(),
                        )),
                        content: const Text(
                          "This app was launched on  August 20  (20/08/2023).It was created by Prabin Bhattarai.It is the library management app which stores the datas of all faculty including both teachers and students permanently.",
                        ),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(fontSize: 17),
                              )),
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Text(
                              "Thanks a lot!",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.info,
                    color: Colors.white,
                    size: 28,
                  )),
            )
          ],
          title: const Text(
            "Library Management  App",
            style: TextStyle(fontSize: 18),
          ),
        ),
        body: CustomScrollView(slivers: [
          //TextField
          SliverToBoxAdapter(
              child: Container(
            child: Column(children: [
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 11.0),
                        child: Text("DashBoard",
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "A healthy place to store data",
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(fontSize: 12)),
                        ),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 13.0),
                    child: CircleAvatar(
                      radius: 26,
                      backgroundImage: AssetImage("assets/avatar1.png"),
                    ),
                  )
                ],
              ),
            ]),
          )),

          //Just a Text
          SliverPadding(
            padding: const EdgeInsets.only(top: 22.0),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: Container(
                  child: Text(
                    "Students Records",
                    style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
          ),

          //1st Sliver List
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverGrid.builder(
                itemCount: firstgridfilteredtext.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 4.0, crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => firstgridpages[index]));
                    },
                    child: Card(
                        color: firstgridfilteredcolor[index],
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          child: Column(children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  // color: firstgridcolor[index],
                                  borderRadius: BorderRadius.circular(40.0)),
                              child: firstgridfilteredicon[index],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              firstgridfilteredtext[index],
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 17, color: Colors.white),
                            )
                          ]),
                        )),
                  );
                }),
          ),

          //2nd Sliver List

          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverGrid.builder(
                itemCount: secondgridfilteredtext.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 4.0, crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => secondgridpages[index]));
                    },
                    child: Card(
                        color: secondgridfilteredcolor[index],
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          child: Column(children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40.0)),
                              child: secondgridfilteredicon[index],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              secondgridfilteredtext[index],
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 18, color: Colors.white),
                            )
                          ]),
                        )),
                  );
                }),
          ),

          //Just another Text
          SliverPadding(
            padding: const EdgeInsets.only(top: 7.0),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Teachers Records",
                          style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                        width: 75,
                        height: 28,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: Colors.orange,
                              width: 1,
                            )),
                        child: const Center(
                          child: Text(
                            "View All",
                            style: TextStyle(fontSize: 15),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 14.0),
            sliver: SliverList.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      listtilenavigation[index]));
                        },
                        child: ListTile(
                          title: Text(firstgridtext[index]),
                          subtitle: Text(
                            firstgridtextfullform[index],
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          leading: CircleAvatar(
                              radius: 22, child: Text("${index + 1}")),
                        ),
                      ),
                      Divider()
                    ],
                  );
                }),
          ),
          const SliverPadding(
            padding: EdgeInsets.all(14.0),
            sliver: SliverToBoxAdapter(
              child: Center(
                  child: Column(
                children: [
                  Text(
                    "Developed By:Prabin Bhattarai ©2023",
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                  Text(
                    "20/08/2023",
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ],
              )),
            ),
          )
        ]));
  }

  void exitfromapp() {
    exit(0);
  }
}
