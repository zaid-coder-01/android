// import 'package:flutter/material.dart';
//
// class AddPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Text(
//             'What would you like to add?.',
//             style: TextStyle(
//               color: Colors.black54,
//               fontSize: 20.0,
//               fontWeight: FontWeight.bold,
//               fontStyle: FontStyle.italic,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(
//             width: 100,
//             child: ElevatedButton(
//               onPressed: () {
//                 // handle Clients button tap
//                 print('Clients');
//               },
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
//                 padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(16.0)),
//                 textStyle: MaterialStateProperty.all<TextStyle>(
//                     TextStyle(fontSize: 20)
//                 ),
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(18.0),
//                     side: BorderSide(color: Colors.blue),
//                   ),
//                 ),
//               ),
//               child: Text('Clients'),
//             ),
//           ),
//
//           SizedBox(height: 12),
//           ElevatedButton(
//             onPressed: () {
//               // handle Meetings button tap
//               print('Meetings');
//             },
//             child: Text('Meetings'),
//           ),
//           SizedBox(height: 12),
//           ElevatedButton(
//             onPressed: () {
//               // handle Leads button tap
//               print('Leads');
//             },
//             child: Text('Leads'),
//           ),
//         ],
//       ),
//     );
//   }
// }
