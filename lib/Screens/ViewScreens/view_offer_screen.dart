import 'package:flutter/material.dart';

class ViewOfferScreen extends StatefulWidget {
  static const routeName = "VIEW_OFFER_SCREEN";
  const ViewOfferScreen({Key? key}) : super(key: key);

  @override
  State<ViewOfferScreen> createState() => _ViewOfferScreenState();
}

class _ViewOfferScreenState extends State<ViewOfferScreen> {

  @override
  Widget build(BuildContext context) {
    final qur = MediaQuery.of(context).size.height/3;
    final details = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(details["name"]),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: InteractiveViewer(
        clipBehavior: Clip.none,
        panEnabled: false,
        maxScale: 4,
        minScale: 1,
        child: Center(
          child: Container(
            alignment: Alignment.center,
            height: qur*2,
            width: double.infinity,
            child: details["image"].toString().contains("http")?Image.network(details["image"],fit: BoxFit.fill,):const Text("لايوجد صورة",style: TextStyle(fontSize: 30),),
          ),
        )
      )
    );
  }
}
