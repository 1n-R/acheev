import 'package:acheev/widgets/tasks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final _newtaxtController = TextEditingController();
  late String iduser;

  Future addFoldercontroller() async {
    final userdata = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user.email.toString())
        .get()
        .then((snapshot) => iduser = snapshot.docs.first.reference.id);

    final newtaxt = await FirebaseFirestore.instance
        .collection('users/' + iduser + '/tasks')
        .add({'name': _newtaxtController.text.trim()});
  }

  // Future addUserDetails(String Email) async {
  //   await FirebaseFirestore.instance.collection('users').add({
  //     'email': Email //, 'folder': []
  //   });
  //   // FirebaseFirestore.instance.collection('users').
  // }

  @override
  void dispose() {
    _newtaxtController.dispose();
    super.dispose();
  }

  Future addFolderView() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Folder name',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: Color.fromRGBO(248, 54, 0, 1)),
                )),
            content: TextField(
              controller: _newtaxtController,
              autofocus: true,
              decoration: InputDecoration(hintText: 'Folder name'),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    addFoldercontroller();
                  },
                  child: Text('Create')),
              // TextButton(onPressed: () {}, child: Text('Create')),
            ],
          ));

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
            child: Tasks(),
          ),
          // MaterialButton(onPressed: FirebaseAuth.instance.signOut();
          // )
          GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              child: Text(
                user.email.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color.fromRGBO(248, 54, 0, 1),
                ),
                // textAlign: TextAlign.left,
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
}
