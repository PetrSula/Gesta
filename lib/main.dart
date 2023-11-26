import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app_2/models/user.dart';
import 'package:my_app_2/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_app_2/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      catchError: (_, __) => null,
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: Wraper(),
      ),
    );
  }
}


// class NinjaCard extends StatelessWidget {
//   const NinjaCard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Ninja ID Card'),
//         centerTitle: true,
//         backgroundColor: Colors.green[900],
//       ),
//       body: Padding(
//         padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               'NAME',
//               style: TextStyle(
//                 color: Colors.red[500],
//                 letterSpacing: 2,
//               ),
//             ),
//             SizedBox(height: 10,),
//             Text(
//               'Chun-Li',
//               style: TextStyle(
//                 color: Colors.amberAccent[200],
//                 letterSpacing: 2,
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold
//               ),
//             ),
//             SizedBox(height: 30,),
//             Text(
//               'CURRENT NINJA LEVEL',
//               style: TextStyle(
//                 color: Colors.red[500],
//                 letterSpacing: 2,
//               ),
//             ),
//             SizedBox(height: 10,),
//             Text(
//               '8',
//               style: TextStyle(
//                   color: Colors.amberAccent[200],
//                   letterSpacing: 2,
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold
//               ),
//             ),
//             SizedBox(height: 30,),
//             Row(
//               children: <Widget> [
//                 Icon(
//                     Icons.email,
//                   color: Colors.lightGreenAccent,
//                 ),
//                 Text(
//                   'chun.li@gmail.com',
//                 style: TextStyle(
//                   color: Colors.amberAccent[200],
//                   fontSize: 18,
//                   letterSpacing: 1
//                 ),)
//               ],
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Text('+',
//           style: TextStyle(
//               fontSize: 28.0
//           ),
//         ),
//         onPressed: () {},
//         backgroundColor: Colors.green[700],
//       ),
//     );
//   }
// }


