// import 'package:acheev/pages/login_page.dart';
// import 'dart:ui' as ui;

// import 'package:acheev/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';

class TasksPage extends StatefulWidget {
  final String idTask;
  final String idUser;
  const TasksPage(this.idTask, this.idUser, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<TasksPage> createState() => _TasksPageState(idTask, idUser);
}

class _TasksPageState extends State<TasksPage> {
  final String idTask;
  final String idUser;
  _TasksPageState(this.idTask, this.idUser);

  String nameTasks = '';
  Future getallTasks() async {
    await FirebaseFirestore.instance
        .collection('users/')
        .doc(idUser)
        .collection('/tasks')
        .doc(idTask)
        .get()
        .then((value) {
      setState(() {
        nameTasks = value['name'];
      });
    });
    // ignore: avoid_function_literals_in_foreach_calls
    // .then((task) => task.docs.forEach((element) {
    //       allTasks.add(Task(
    //         id: element.id,
    //         iconData: Icons.folder_copy,
    //         title: element['name'].toString(),
    //         bgColor: kBlueLight,
    //         iconColor: kBlueDark,
    //         notes: 7,
    //       ));
    //       // print(element["name"]);
    // }
    // ));
    // return allTasks;
  }

  @override
  void initState() {
    getallTasks();
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
            Expanded(
                child: ListView.builder(
              itemCount: 40,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset.fromDirection(0, 10),
                          blurRadius: 10.0,
                          color: const Color.fromRGBO(0, 0, 0, 0.02)
                          // blurStyle: BlurStyle.solid
                          // spreadRadius: 100.0,
                          ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 11.0),
                    child: Container(
                      // color: Colors.red,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      // margin: EdgeInsets.all(10),
                      // color: Colors.white,
                      child: GestureDetector(
                        // onTap: signIn,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/taskImage.png',
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  children: const [
                                    Icon(
                                      Icons.more_vert,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                  ],
                                ),
                                const Text('School website project'),
                                const Text('Deadline Oct, 28'),
                                const Icon(
                                  Icons.access_time_filled,
                                  color: Colors.black,
                                  size: 19.0,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          isExtended: true,
          onPressed: () {
            // Add your onPressed code here!
          },
          backgroundColor: const Color.fromRGBO(254, 140, 0, 1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: GestureDetector(
            // onTap: signIn,
            child: Container(
              // padding: const EdgeInsets.all(1),
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
                child: Text('Add Task',
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
        // extended(
        //   onPressed: () {
        //     // Add your onPressed code here!
        //   },
        //   backgroundColor: const Color.fromRGBO(254, 140, 0, 1),
        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        //   label: GestureDetector(
        //     // onTap: signIn,
        //     child: Container(
        //       // padding: const EdgeInsets.all(1),
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(5),
        //         gradient: const LinearGradient(
        //           begin: Alignment.topLeft,
        //           end: Alignment.bottomRight,
        //           colors: <Color>[
        //             Color.fromRGBO(254, 140, 0, 1),
        //             Color.fromRGBO(248, 54, 0, 1),
        //           ],
        //         ),
        //       ),
        //       child: Center(
        //         child: Text('Add Task',
        //             style: GoogleFonts.poppins(
        //               textStyle: const TextStyle(
        //                   color: Color.fromARGB(255, 255, 255, 255),
        //                   fontWeight: FontWeight.w600,
        //                   fontSize: 15),
        //             )),
        //       ),
        //     ),
        //   ),
        // ),
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // const SizedBox(width: 10),

          Text(nameTasks,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Color.fromRGBO(60, 64, 72, 1)),
              )),
        ],
      ),
      actions: [
        SizedBox(
          height: 50,
          width: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset('assets/avatar.png'),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
// class TasksPage extends StatelessWidget {
//   final String idTask;
//   final String idUser;
//   const TasksPage(this.idTask, this.idUser, {super.key});

//   // final String a;
//   // static const String title= '';
  
//   Future getallTasks() async {
//     await FirebaseFirestore.instance
//         .collection('users/')
//         .doc(idUser)
//         .collection('/tasks')
//         .doc(idTask)
//         .get();
//     // ignore: avoid_function_literals_in_foreach_calls
//     // .then((task) => task.docs.forEach((element) {
//     //       allTasks.add(Task(
//     //         id: element.id,
//     //         iconData: Icons.folder_copy,
//     //         title: element['name'].toString(),
//     //         bgColor: kBlueLight,
//     //         iconColor: kBlueDark,
//     //         notes: 7,
//     //       ));
//     //       // print(element["name"]);
//     // }
//     // ));
//     // return allTasks;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: _buildAppBar(),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//               child: ListView.builder(
//             itemCount: 40,
//             itemBuilder: (context, index) {
//               return Container(
//                 padding: EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                         offset: Offset.fromDirection(0, 10),
//                         blurRadius: 10.0,
//                         color: Color.fromRGBO(0, 0, 0, 0.02)
//                         // blurStyle: BlurStyle.solid
//                         // spreadRadius: 100.0,
//                         ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 15.0, vertical: 11.0),
//                   child: Container(
//                     // color: Colors.red,
//                     padding: EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colors.white),
//                     // margin: EdgeInsets.all(10),
//                     // color: Colors.white,
//                     child: GestureDetector(
//                       // onTap: signIn,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Image.asset(
//                             'assets/taskImage.png',
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 // crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Icon(
//                                     Icons.more_vert,
//                                     color: Colors.black,
//                                     size: 25,
//                                   ),
//                                 ],
//                               ),
//                               Text('School website project'),
//                               Text('Deadline Oct, 28'),
//                               Icon(
//                                 Icons.access_time_filled,
//                                 color: Colors.black,
//                                 size: 19.0,
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           )),
//         ],
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           // Add your onPressed code here!
//         },
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         label: GestureDetector(
//           // onTap: signIn,
//           child: Container(
//             padding: const EdgeInsets.all(1),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(5),
//               gradient: const LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: <Color>[
//                   Color.fromRGBO(254, 140, 0, 1),
//                   Color.fromRGBO(248, 54, 0, 1),
//                 ],
//               ),
//             ),
//             child: Center(
//               child: Text('Add Task',
//                   style: GoogleFonts.poppins(
//                     textStyle: const TextStyle(
//                         color: Color.fromARGB(255, 255, 255, 255),
//                         fontWeight: FontWeight.w600,
//                         fontSize: 15),
//                   )),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   AppBar _buildAppBar() {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       leading: TextButton(
//         style: ButtonStyle(
//           foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
//         ),
//         onPressed: () {},
//         child: const Icon(
//           Icons.arrow_back_ios_new_rounded,
//           size: 30,
//         ),
//       ),
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           // const SizedBox(width: 10),

//           Text('Project',
//               style: GoogleFonts.poppins(
//                 textStyle: const TextStyle(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 20,
//                     color: Color.fromRGBO(60, 64, 72, 1)),
//               )),
//         ],
//       ),
//       actions: [
//         SizedBox(
//           height: 50,
//           width: 50,
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: Image.asset('assets/avatar.png'),
//           ),
//         ),
//         SizedBox(
//           width: 10,
//         ),
//       ],
//     );
//   }
// }
