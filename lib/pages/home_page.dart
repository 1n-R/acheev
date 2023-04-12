import 'package:acheev/pages/foldertasks_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acheev/models/foldertask.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
// import 'package:path/path.dart';
import 'dart:io';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:acheev/constants/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final _newtaskController = TextEditingController();
  final _emailController = TextEditingController();
  int _selectedIndex = 0;
  bool isObscurePassword = true;
  String iduser = '';
  String imagePath = "";
  List<FolderTask> allFolderTasks = [];
  int lengthFolderTasks = 0;

  // GET IMAGE
  // Future<File> getImage() async {
  //   return await ImagePicker.pickImage(source: ImageSource.gallery);
  // }

  // // UPLOAD IMAGE
  // Future uploadImage(File imageFile) async {
  //   String fileName = imageFile.path;

  //   Reference ref = FirebaseStorage.instance.ref().child('profil');
  //   await ref.putFile(imageFile);
  //   ref.getDownloadURL().then((value) {
  //     print(value);
  //   });
  // }

  // void pickUploadImage() async {
  //   final image = await ImagePicker().pickImage(
  //       source: ImageSource.gallery,
  //       maxWidth: 512,
  //       maxHeight: 512,
  //       imageQuality: 75);

  //   Reference ref = FirebaseStorage.instance.ref().child('profile.jpg');
  //   await ref.putFile(File(image!.path));
  //   ref.getDownloadURL().then((value) {
  //     print(value);
  //   });
  // }

  // GET USER
  Future getIdUser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user.email.toString())
        .get()
        .then((snapshot) => iduser = snapshot.docs.first.reference.id);
  }

  // GET ALL FOLDER TASK
  Future getallFolderTasks() async {
    allFolderTasks = [];
    await getIdUser();
    await FirebaseFirestore.instance
        .collection('users/')
        .doc(iduser)
        .collection('/tasks')
        .get()
        // ignore: avoid_function_literals_in_foreach_calls
        .then((task) => task.docs.forEach((element) {
              allFolderTasks.add(FolderTask(
                id: element.id,
                iconData: Icons.folder_copy,
                title: element['name'].toString(),
                bgColor: Color(element['bgColor']),
                iconColor: Color(element['iconColor']),
                notes: 0,
              ));
            }));
    _emailController.value = _emailController.value.copyWith(
      text: user.email.toString(),
      selection: TextSelection.collapsed(offset: user.email.toString().length),
    );
  }

  // Dialog
  Future editFolderView(String id, String nameFolder) {
    String title;
    bool create;
    bool update;
    bool delete;

    _newtaskController.value = _newtaskController.value.copyWith(
      text: nameFolder,
      selection: TextSelection.collapsed(offset: nameFolder.length),
    );

    if (id != '' && nameFolder != '') {
      title = 'Edit';
      create = false;
      update = true;
      delete = true;
    } else {
      title = 'Add';
      create = true;
      update = false;
      delete = false;
    }

    return showDialog(
        context: context,
        builder: (context) => DialogTask(
            id, nameFolder, title, create, update, delete, _newtaskController));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
      body: _selectedIndex == 0
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.all(15),
                    child: const Text(
                      'My Schedule',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    )),
                Expanded(
                    child: FutureBuilder(
                  future: getallFolderTasks(),
                  builder: (context, snapshot) {
                    return GridView.builder(
                        padding: const EdgeInsets.all(10),
                        itemCount: allFolderTasks.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemBuilder: (context, index) =>
                            _buildTask(context, allFolderTasks[index]));
                  },
                )),
              ],
            )
          : Container(
              padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          imagePath != ""
                              ? (Container(
                                  width: 130,
                                  height: 130,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 4, color: Colors.white),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            color:
                                                Colors.black.withOpacity(0.1))
                                      ],
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(imagePath))),
                                ))
                              : (Container(
                                  width: 130,
                                  height: 130,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 4, color: Colors.white),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            color:
                                                Colors.black.withOpacity(0.1))
                                      ],
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image:
                                              AssetImage('assets/avatar.png'))),
                                )),
                          GestureDetector(
                            onTap: () async {
                              // File file = await getImage();
                              // imagePath =
                              setState(() {});
                              // pickUploadImage();
                            },
                            child: Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 4, color: Colors.white),
                                      color: Colors.white),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Color(0xFF303030),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text('Email',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ))
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, left: 20, right: 20, bottom: 20),
                        child: TextField(
                          readOnly: true,
                          controller: _emailController,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(187, 187, 187, 0.35)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(187, 187, 187, 1)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              hintText: 'Enter Email',
                              hintStyle: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                              fillColor: Colors.white,
                              filled: true),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: <Color>[
                                Color.fromRGBO(254, 140, 0, 1),
                                Color.fromRGBO(248, 54, 0, 1),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text('Sign Out',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                )),
                          ),
                        ),
                      ),
                    )
                    // const SizedBox(height: 30),
                    // buildTextField("Your Name", "", false),
                    // buildTextField("Email", "", false),
                    // buildTextField("password", "", true),
                    // const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _selectedIndex == 0
          ? SizedBox(
              height: 64,
              width: 64,
              child: FittedBox(
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  elevation: 0,
                  child: Container(
                    height: 64,
                    width: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      gradient: const LinearGradient(
                        begin: Alignment.center,
                        end: Alignment(1.0, 0.0),
                        colors: <Color>[
                          Color.fromRGBO(254, 140, 0, 1),
                          Color.fromRGBO(248, 54, 0, 1),
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    await editFolderView('', '');
                    setState(() {});
                  },
                ),
              ),
            )
          : null,
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
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            backgroundColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: const Color.fromRGBO(239, 67, 44, 1),
            unselectedItemColor: Colors.grey.withOpacity(0.5),
            items: const [
              BottomNavigationBarItem(
                  // activeIcon: HomePage(),
                  label: 'Home',
                  icon: Icon(
                    Icons.home_rounded,
                    size: 30,
                  )),
              BottomNavigationBarItem(
                  // activeIcon: Profill(),
                  label: 'Person',
                  icon: Icon(
                    Icons.person_rounded,
                    size: 30,
                  ))
            ],
          ),
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
          // const SizedBox(
          //   width: 190,
          // ),
          // SizedBox(
          //     height: 40,
          //     width: 40,
          //     child: GestureDetector(
          //       onTap: () {
          //         FirebaseAuth.instance.signOut();
          //       },
          //       child: ClipRRect(
          //         borderRadius: BorderRadius.circular(10),
          //         child: Image.asset('assets/avatar.png'),
          //       ),
          //     )),
        ],
      ),
    );
  }

  Widget _buildTask(BuildContext context, FolderTask task) {
    return GestureDetector(
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (context) {
        return FolderTasksPage(task.id.toString(), iduser.toString());
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
                    GestureDetector(
                      onTap: () async {
                        await editFolderView(
                            task.id.toString(), task.title.toString());
                        setState(() {});
                      },
                      child: const Icon(
                        Icons.more_vert,
                        size: 25,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
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
                _buildTaskStatus(task.bgColor!, '${task.notes} notes'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTaskStatus(Color bgColor, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(20)),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color.fromRGBO(0, 0, 0, 0.5)),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextField(
          obscureText: isPasswordTextField ? isObscurePassword : false,
          decoration: InputDecoration(
              suffixIcon: isPasswordTextField
                  ? IconButton(
                      icon: const Icon(
                        Icons.remove_red_eye,
                        color: Color(0xFFEF6c00),
                      ),
                      onPressed: () {
                        setState(() {
                          isObscurePassword = !isObscurePassword;
                        });
                      },
                    )
                  : null,
              contentPadding: const EdgeInsets.only(bottom: 5),
              labelText: labelText,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: placeholder,
              hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey))),
    );
  }
}

class DialogTask extends StatefulWidget {
  final String id;
  final String nameFolder;
  final String title;
  final bool create;
  final bool update;
  final bool delete;
  final TextEditingController _newtaskController;
  const DialogTask(this.id, this.nameFolder, this.title, this.create,
      this.update, this.delete, this._newtaskController,
      {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<DialogTask> createState() => DialogTaskState(
      id, nameFolder, title, create, update, delete, _newtaskController);
}

class DialogTaskState extends State<DialogTask> {
  final String id;
  final String nameFolder;
  final String title;
  final bool create;
  final bool update;
  final bool delete;
  final TextEditingController _newtaskController;

  DialogTaskState(this.id, this.nameFolder, this.title, this.create,
      this.update, this.delete, this._newtaskController);

  late int bgcolor = 0x260078AA;
  late int iconcolor = 0xFF0078AA;
  String themepick = 'blue';
  String iduser = '';
  final user = FirebaseAuth.instance.currentUser!;

  Future getIdUser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user.email.toString())
        .get()
        .then((snapshot) => iduser = snapshot.docs.first.reference.id);
  }

  Future addFoldercontroller() async {
    await getIdUser();
    await FirebaseFirestore.instance
        .collection('users/')
        .doc(iduser)
        .collection('/tasks')
        .add({
      'name': _newtaskController.text.trim(),
      'iconColor': iconcolor,
      'bgColor': bgcolor
    });

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
        .update({
      'name': _newtaskController.text.trim(),
      'iconColor': iconcolor,
      'bgColor': bgcolor
    });

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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('$title Folder',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: Color.fromRGBO(0, 0, 0, 1)),
          )),
      content: TextField(
        controller: _newtaskController,
        inputFormatters: [
          LengthLimitingTextInputFormatter(9),
        ],
        autofocus: true,
        decoration: const InputDecoration(hintText: 'Folder name'),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      themepick = 'blue';
                      bgcolor = 0x260078AA;
                      iconcolor = 0xFF0078AA;
                    });
                    // pickbgColor(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color.fromRGBO(0, 120, 170, 1)),
                    height: 30,
                    width: 30,
                    child: Visibility(
                      visible: themepick == 'blue',
                      child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color.fromRGBO(255, 255, 255, 1)),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      themepick = 'red';
                      bgcolor = 0x26EB1D36;
                      iconcolor = 0xFFEB1D36;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color.fromRGBO(235, 29, 54, 1)),
                    height: 30,
                    width: 30,
                    child: Visibility(
                      visible: themepick == 'red',
                      child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color.fromRGBO(255, 255, 255, 1)),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      themepick = 'purpel';
                      bgcolor = 0x267900FF;
                      iconcolor = 0xFF7900FF;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color.fromRGBO(121, 0, 255, 1)),
                    height: 30,
                    width: 30,
                    child: Visibility(
                      visible: themepick == 'purpel',
                      child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color.fromRGBO(255, 255, 255, 1)),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      themepick = 'yellow';
                      bgcolor = 0x26D4D925;
                      iconcolor = 0xFFD4D925;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color.fromRGBO(212, 217, 37, 1)),
                    height: 30,
                    width: 30,
                    child: Visibility(
                      visible: themepick == 'yellow',
                      child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color.fromRGBO(255, 255, 255, 1)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: delete,
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      // allFolderTasks = [];
                      deleteFoldercontroller(id);
                      Navigator.pop(context, 'Delete');
                    });
                  },
                  child: const Text('Delete')),
            ),
            Visibility(
              visible: update,
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      // allFolderTasks = [];
                      updateFoldercontroller(id, nameFolder);
                      Navigator.pop(context, 'Update');
                    });
                  },
                  child: const Text('Update')),
            ),
            Visibility(
              visible: create,
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      // allFolderTasks = [];
                      addFoldercontroller();
                      Navigator.pop(context, 'Create');
                    });
                  },
                  child: const Text('Create')),
            ),
          ],
        ),
      ],
    );
  }
}
