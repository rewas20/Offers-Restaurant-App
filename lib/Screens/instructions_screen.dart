import 'package:flutter/material.dart';
import 'package:menu/Themes/colors_themes.dart';
import 'package:menu/screens/home_screen.dart';

class InstructionsScreen extends StatefulWidget {
  static const routeName = "INSTRUCTIONS_SCREEN";
  const InstructionsScreen({Key? key}) : super(key: key);

  @override
  State<InstructionsScreen> createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen> {
  Color? textInstructions =  Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemesColor().getColor(8),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                Text("اهلا بيك في نأنأة",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color:textInstructions),),
                Text("جميع العروض هنا",style: TextStyle(fontSize: 20,color: textInstructions),),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: Container(
        width: 80,
        margin: const EdgeInsets.all(5),
        child:  TextButton(
          onPressed: (){
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("تخطي",style: TextStyle(color: textInstructions),),
              Icon(Icons.navigate_next,color: textInstructions,),
            ],
          ),
        ),
      ),
    );
  }
}
