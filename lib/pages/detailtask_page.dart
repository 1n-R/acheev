import 'package:acheev/models/task.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DetailTask extends StatefulWidget {
  final Task task;
  const DetailTask(this.task, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<DetailTask> createState() => _DetailTaskState(task);
}

class _DetailTaskState extends State<DetailTask> {
  final _dateController = TextEditingController();
  Task task;

  _DetailTaskState(this.task);

  read() {
    _dateController.value = _dateController.value.copyWith(
        text: task.date != null
            ? DateFormat('yyyy-MM-dd').format(task.date as DateTime)
            : ''
        // selection: TextSelection.collapsed(offset: task.title.toString().length),
        );
  }

  @override
  void initState() {
    read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ListView(children: [
        Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/taskImage.png',
          width: 414,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: SizedBox(
            width: 640,
            child: Text(task.title.toString(),
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Color.fromRGBO(60, 64, 72, 1),
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Description',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  )),
              const SizedBox(
                height: 13,
              ),
              Container(
                // padding: EdgeInsets.only(Top:13),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(216, 217, 207, 1),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  // color: Colors.orange
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(task.description.toString(),
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      )),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Insert Submission',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  )),
              const SizedBox(
                height: 13,
              ),
              Container(
                // padding: EdgeInsets.only(Top:13),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(216, 217, 207, 1),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  // color: Colors.orange
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(task.insert.toString(),
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      )),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Date',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  )),
              const SizedBox(
                height: 13,
              ),
              Container(
                // padding: EdgeInsets.only(Top:13),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(216, 217, 207, 1),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  // color: Colors.orange
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller:
                        _dateController, //editing controller of this TextField
                    decoration: InputDecoration(
                        // labelText: 'Date',
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
                    },
                  ),
                ),
              )
            ],
          ),
        )
      ],
        )
      ]),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 30,
        ),
      ),
    );
  }
}
