import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_management_app/BCADatabase.dart';
import 'package:library_management_app/Model.dart';

class BCA extends StatefulWidget {
  const BCA({super.key});

  @override
  State<BCA> createState() => _BCAState();
}

class _BCAState extends State<BCA> {
  final studentnamecontroller = TextEditingController();
  final semestercontroller = TextEditingController();
  final Bookidcontroller = TextEditingController();

  List<Model> allmodels = [];
  List<Model> filteredmodels = [];
  String searchquery = '';
  @override
  void initState() {
    super.initState();
    fetchmodelfromDatabase();
  }

  Future<void> fetchmodelfromDatabase() async {
    List<Model> model = await BCADataBaseHandler.instance.bcadisplaymodel();
    setState(() {
      allmodels = model;
      filteredmodels = model;
    });
  }

  List<Model> filtermodel(List<Model> modelList, String searchQuery) {
    if (searchQuery.isEmpty) {
      return modelList; // Return the original list if the search query is empty
    }

    searchQuery = searchQuery.toLowerCase();

    return modelList.where((person) {
      return person.studentname.toLowerCase().contains(searchQuery);
    }).toList();
  }

  void updatefilteredmodel() {
    setState(() {
      filteredmodels = filtermodel(allmodels, searchquery);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("BCA"),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverToBoxAdapter(
              child: Container(
                child: TextField(
                  onChanged: (val) {
                    setState(() {
                      searchquery = val;
                      updatefilteredmodel();
                    });
                  },
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple)),
                    hintText: "Search student ",
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: filteredmodels.length,
                itemBuilder: (context, index) {
                  final model = filteredmodels[index];

                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.purple,
                        radius: 25,
                        child: Text(
                          "${index + 1}",
                          style: GoogleFonts.lato(color: Colors.white),
                        ),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            bcadeletemodel(model.id!);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.purple,
                          )),
                      title: Text("Name:${model.studentname}"),
                      subtitle: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 138.0),
                            child: Text(
                              'Semester: ${model.semester}',
                              style: GoogleFonts.lato(color: Colors.black),
                            ),
                          ),
                          Text(
                            "Book Id:${model.Bookid}",
                            style: GoogleFonts.lato(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Enter the Details",
                        style: GoogleFonts.pacifico(
                            fontSize: 16, color: Colors.black),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, left: 14.0, right: 14.0),
                        child: TextField(
                          controller: studentnamecontroller,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 3.0, horizontal: 10.0),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black)),
                              hintText: "Enter student Name"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 14.0, left: 14.0, right: 14.0),
                        child: TextField(
                          controller: semestercontroller,
                          decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black)),
                              hintText: "Enter Semester"),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Book Id He/She has Taken:",
                        style: GoogleFonts.pacifico(
                            fontSize: 16, color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, left: 14.0, right: 14.0),
                        child: TextField(
                          controller: Bookidcontroller,
                          decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black)),
                              hintText: "Book Id"),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              fixedSize: const Size(200, 55)),
                          onPressed: () {
                            Navigator.pop(context);
                            _onsave();
                          },
                          child: Text("Save Data"))
                    ],
                  ),
                );
              });
        },
        child: const Text(
          "+",
          style: TextStyle(fontSize: 34),
        ),
      ),
    );
  }

  void _onsave() async {
    final String stuname = studentnamecontroller.text;
    final int sem = int.parse(semestercontroller.text);
    final String bid = Bookidcontroller.text;
    if (stuname.isEmpty || sem <= 0 || bid.isEmpty) {
      return;
    }

    final model = Model(studentname: stuname, semester: sem, Bookid: bid);
    await BCADataBaseHandler.instance.bcainsertmodel(model);
    studentnamecontroller.clear();
    semestercontroller.clear();
    Bookidcontroller.clear();

    print(model.Bookid);

    print("Data stored Successfully");
    fetchmodelfromDatabase();

    setState(() {});
  }

  void bcadeletemodel(int id) async {
    await BCADataBaseHandler.instance.bcadeletemodel(id);
    fetchmodelfromDatabase();

    setState(() {});
  }
}
