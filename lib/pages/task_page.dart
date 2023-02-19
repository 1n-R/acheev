import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';

class AddTask extends StatefulWidget {
  final String idFolder;
  final String idUser;
  final Task task;
  const AddTask(this.idFolder, this.idUser, this.task, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<AddTask> createState() => _AddTaskState(idFolder, idUser, task);
}

class _AddTaskState extends State<AddTask> {
  final String idFolder;
  final String idUser;
  final Task task;

  _AddTaskState(this.idFolder, this.idUser, this.task);

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _insertController = TextEditingController();
  final _dateController = TextEditingController();

  // READ
  readTaskcontroller() {
    _titleController.value = _titleController.value.copyWith(
      text: task.title,
      selection: TextSelection.collapsed(offset: task.title.toString().length),
    );

    _descriptionController.value = _descriptionController.value.copyWith(
      text: task.description,
      selection:
          TextSelection.collapsed(offset: task.description.toString().length),
    );

    _insertController.value = _insertController.value.copyWith(
      text: task.insert,
      selection: TextSelection.collapsed(offset: task.insert.toString().length),
    );

    _dateController.value = _dateController.value.copyWith(
        text: task.date != null
            ? DateFormat('yyyy-MM-dd').format(task.date as DateTime)
            : ''
        // selection: TextSelection.collapsed(offset: task.title.toString().length),
        );
  }

  // CREATE
  Future addTaskcontroller() async {
    await FirebaseFirestore.instance
        .collection('users/')
        .doc(idUser)
        .collection('/tasks')
        .doc(idFolder)
        .collection('task')
        .add({
      'title': _titleController.text.trim(),
      'description': _descriptionController.text.trim(),
      'insert': _insertController.text.trim(),
      'date': _dateController.text.trim(),
    });

    _titleController.clear();
    _descriptionController.clear();
    _insertController.clear();
    _dateController.clear();

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  // UPDATE
  Future updateTaskcontroller() async {
    await FirebaseFirestore.instance
        .collection('users/')
        .doc(idUser)
        .collection('/tasks')
        .doc(idFolder)
        .collection('task')
        .doc(task.id)
        .update({
      'title': _titleController.text.trim(),
      'description': _descriptionController.text.trim(),
      'insert': _insertController.text.trim(),
      'date': _dateController.text.trim(),
    });

    _titleController.clear();
    _descriptionController.clear();
    _insertController.clear();
    _dateController.clear();

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  // DELETE
  Future deleteTaskcontroller() async {
    await FirebaseFirestore.instance
        .collection('users/')
        .doc(idUser)
        .collection('/tasks')
        .doc(idFolder)
        .collection('task')
        .doc(task.id)
        .delete();

    _titleController.clear();
    _descriptionController.clear();
    _insertController.clear();
    _dateController.clear();

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  // READ

  @override
  void initState() {
    // _dateController.text = ""; //set the initial value of text field
    readTaskcontroller();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Colors.white,
      body: ListView(children: [
        Container(
          padding: const EdgeInsets.all(25),
          child: Column(children: [
            Padding(
                padding: const EdgeInsets.only(
                    top: 5.0, left: 20, right: 20, bottom: 20),
                child: TextField(
                  controller: _titleController,
                  //     inputFormatters: [
                  // LengthLimitingTextInputFormatter(10),
                  //     ],
                  decoration: InputDecoration(
                      labelText: 'Add Title',
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
                      // hintText: 'Name Task',
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
                padding: const EdgeInsets.only(
                    top: 5.0, left: 20, right: 20, bottom: 20),
                child: TextField(
                  controller: _descriptionController,
                  maxLines: 5,
                  minLines: 1,
                  //     inputFormatters: [
                  // LengthLimitingTextInputFormatter(10),
                  //     ],
                  decoration: InputDecoration(
                      labelText: 'Add description',
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
                      // hintText: 'Name Task',
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
                padding: const EdgeInsets.only(
                    top: 5.0, left: 20, right: 20, bottom: 20),
                child: TextField(
                  controller: _insertController,
                  maxLines: 3, // <-- SEE HERE
                  minLines: 1,
                  //     inputFormatters: [
                  // LengthLimitingTextInputFormatter(10),
                  //     ],
                  decoration: InputDecoration(
                      labelText: 'Insert submission',
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
                      // hintText: 'Name Task',
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
              padding: const EdgeInsets.only(
                  top: 5.0, left: 20, right: 20, bottom: 20),
              child: TextField(
                controller:
                    _dateController, //editing controller of this TextField
                decoration: InputDecoration(
                    labelText: 'Date',
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
                    // hintText: 'Name Task',
                    hintStyle: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    fillColor: Colors.white,
                    filled: true),
                readOnly:
                    true, //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    // print(
                    //     pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    // print(
                    //     formattedDate); //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement

                    setState(() {
                      _dateController.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {
                    // print("Date is not selected");
                  }
                },
              ),
            ),
            Visibility(
              visible: task.isnull != false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                child: GestureDetector(
                  onTap: addTaskcontroller,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          Color.fromRGBO(254, 140, 0, 1),
                          Color.fromRGBO(248, 54, 0, 1),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text('Insert',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          )),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: task.isnull == false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: deleteTaskcontroller,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),

                          border: Border.all(
                            color: const Color.fromRGBO(216, 217, 207, 1),
                            width: 1,
                          ),
                          // gradient: const LinearGradient(
                          //   begin: Alignment.center,
                          //   end: Alignment.bottomRight,
                          //   colors: <Color>[
                          //     Color.fromRGBO(254, 140, 0, 1),
                          //     Color.fromRGBO(248, 54, 0, 1),
                          //   ],
                          // ),
                        ),
                        child: Center(
                          child: Text('Delete',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 255, 0, 0),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              )),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: updateTaskcontroller,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: const LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                              Color.fromRGBO(254, 140, 0, 1),
                              Color.fromRGBO(248, 54, 0, 1),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text('Update',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ]),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: TextButton(
        // style: ButtonStyle(
        //   foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        // ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 30,
          color: Colors.black,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const SizedBox(width: 10),
          Text('Add Task',
              // textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Color.fromRGBO(60, 64, 72, 1)),
              )),
        ],
      ),
      actions: const [
        SizedBox(
          height: 50,
          width: 50,
          child: Icon(
            Icons.settings,
            size: 30,
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
