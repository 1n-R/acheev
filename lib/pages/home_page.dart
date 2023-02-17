import 'package:acheev/pages/tasks_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acheev/models/task.dart';
import 'package:acheev/constants/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final _newtaskController = TextEditingController();
  String iduser = '';
  List<Task> allTasks = [];

  // GET USER
  Future getIdUser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user.email.toString())
        .get()
        .then((snapshot) => iduser = snapshot.docs.first.reference.id);
  }

  // CREATE
  Future addFoldercontroller() async {
    await getIdUser();
    await FirebaseFirestore.instance
        .collection('users/')
        .doc(iduser)
        .collection('/tasks')
        .add({'name': _newtaskController.text.trim()});

    _newtaskController.clear();
  }

  // UPDATE

  Future updateFoldercontroller(String id, String nameFolder) async {
    await getIdUser();
    await FirebaseFirestore.instance
        .collection('users/')
        .doc(iduser)
        .collection('/tasks')
        .doc(id)
        .update({'name': _newtaskController.text.trim()});

    _newtaskController.clear();
  }

  // DELETE
  Future deleteFoldercontroller(id) async {
    await getIdUser();
    await FirebaseFirestore.instance
        .collection('users/')
        .doc(iduser)
        .collection('/tasks')
        .doc(id)
        .delete();

    _newtaskController.clear();
  }

  // GET ALL FOLDER TASK
  Future getallTasks() async {
    await getIdUser();
    await FirebaseFirestore.instance
        .collection('users/')
        .doc(iduser)
        .collection('/tasks')
        .get()
        // ignore: avoid_function_literals_in_foreach_calls
        .then((task) => task.docs.forEach((element) {
              allTasks.add(Task(
                id: element.id,
                iconData: Icons.folder_copy,
                title: element['name'].toString(),
                bgColor: kBlueLight,
                iconColor: kBlueDark,
                notes: 7,
              ));
            }));
  }

  // Dialog CREATE
  Future addFolderView() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Add Folder',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: Color.fromRGBO(248, 54, 0, 1)),
                  )),
              content: TextField(
                controller: _newtaskController,
                autofocus: true,
                decoration: const InputDecoration(hintText: 'Folder name'),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        allTasks = [];
                        addFoldercontroller();
                        Navigator.pop(context, 'Create');
                      });
                    },
                    child: const Text('Create')),
                // TextButton(onPressed: () {}, child: Text('Create')),
              ],
            ));
  }

  // Dialog Edit
  Future editFolderView(String id, String nameFolder) {
    var newText = nameFolder;

    _newtaskController.value = _newtaskController.value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );

    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Edit Folder',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: Color.fromRGBO(248, 54, 0, 1)),
                  )),
              content: TextField(
                controller: _newtaskController,
                autofocus: true,
                decoration: const InputDecoration(hintText: 'Folder name'),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        allTasks = [];
                        deleteFoldercontroller(id);
                        Navigator.pop(context, 'Delete');
                      });
                    },
                    child: const Text('Delete')),
                TextButton(
                    onPressed: () {
                      setState(() {
                        allTasks = [];
                        updateFoldercontroller(id, nameFolder);
                        Navigator.pop(context, 'Update');
                      });
                    },
                    child: const Text('Update')),
              ],
            ));
  }

  @override
  void dispose() {
    _newtaskController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.all(15),
              child: const Text(
                'My Schedule',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              )),
          Expanded(
              child: FutureBuilder(
            future: getallTasks(),
            builder: (context, snapshot) {
              return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: allTasks.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) =>
                      _buildTask(context, allTasks[index]));
            },
          )),
          GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              child: Text(
                user.email.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color.fromRGBO(248, 54, 0, 1),
                ),
              ))
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 0,
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color.fromRGBO(254, 140, 0, 1),
                Color.fromRGBO(248, 54, 0, 1),
              ],
            ),
          ),
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
        onPressed: () {
          addFolderView();
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10)
            ]),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          child: BottomNavigationBar(
              backgroundColor: Colors.white,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: Colors.blueAccent,
              unselectedItemColor: Colors.grey.withOpacity(0.5),
              items: const [
                BottomNavigationBarItem(
                    label: 'Home',
                    icon: Icon(
                      Icons.home_rounded,
                      size: 30,
                    )),
                BottomNavigationBarItem(
                    label: 'Person',
                    icon: Icon(
                      Icons.person_rounded,
                      size: 30,
                    ))
              ]),
        ));
  }

  AppBar _buildAppBar() {
    var now = DateTime.now();
    var formatter = DateFormat('MMM d, ' 'yyyy');
    String formattedDate = formatter.format(now);

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          const SizedBox(width: 10),
          Text(
            // formattedDate.toString(),
            formattedDate,
            style: const TextStyle(
                color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 190,
          ),
          SizedBox(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset('assets/avatar.png'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTask(BuildContext context, Task task) {
    return GestureDetector(
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (context) {
        return TasksPage(task.id.toString(), iduser.toString());
      })),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: task.bgColor, borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      task.iconData,
                      color: task.iconColor,
                      size: 35,
                    ),
                    TextButton(
                      style: ButtonStyle(
                        alignment: Alignment.topRight,
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      onPressed: () {
                        editFolderView(
                            task.id.toString(), task.title.toString());
                      },
                      child: const Icon(
                        Icons.more_vert,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      task.title.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildTaskStatus(
                    task.bgColor!, task.iconColor!, '${task.notes} notes'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTaskStatus(Color bgColor, Color txColor, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(20)),
      child: Text(
        text,
        style: TextStyle(color: txColor),
      ),
    );
  }
}
