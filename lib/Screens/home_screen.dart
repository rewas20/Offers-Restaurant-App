import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:menu/Screens/ViewScreens/view_offer_screen.dart';
import 'package:menu/Themes/colors_themes.dart';
import 'package:menu/Widgets/offer_item.dart';

import '../Models/offer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "HOME_SCREEN";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final menu = FirebaseDatabase.instance.ref().child("Menu");
  final offers = FirebaseDatabase.instance.ref().child("Offers");
  final call = FirebaseDatabase.instance.ref().child("Call");
  Color? appBarColor = ThemesColor().getColor(9);
  final String counter="";
  Color? text = ThemesColor().getColor(8);
  List<OfferModel> offerList=[];
  List<OfferModel> allOffersList=[];
  @override
  Widget build(BuildContext context) {
    final qurHeight = (MediaQuery.of(context).size.height)/5.0;
    double appBarHeight = 50;
    return Scaffold(
      backgroundColor:  Colors.white.withOpacity(1),
      body: StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder: (context,status){
          final result=status.data;
          return result == ConnectivityResult.mobile || result == ConnectivityResult.wifi || result == ConnectivityResult.ethernet?
            Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.webp"),
                  fit: BoxFit.cover,
                  opacity: 0.2,
                ),
              ),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: appBarHeight,bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("نأنأة",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 45,color: text),),
                            /*Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //Icon(Icons.local_fire_department,color: ThemesColor().getColor(4),size: 40),

                               // Icon(Icons.local_fire_department,color: ThemesColor().getColor(4),size: 40,)
                              ],
                            ),*/
                            Container(
                              alignment: Alignment.centerRight,
                              margin: const EdgeInsets.only(top: 5,right: 20),
                              child: FloatingActionButton.extended(
                                backgroundColor: ThemesColor().getColor(34),
                                onPressed: (){
                                  try{
                                    menu.once().then((value) {
                                      if(value.snapshot.exists){
                                        final data = value.snapshot.value as Map<dynamic,dynamic>;
                                        Navigator.of(context).pushNamed(ViewOfferScreen.routeName,arguments: {
                                          "name":"المنيو",
                                          "image" : data["url"],
                                        });
                                      }else if(value.snapshot.value==null){
                                        Fluttertoast.showToast(msg: "لا يوجد منيو الان");
                                      }
                                    });

                                  }on FirebaseException catch(e){
                                    Fluttertoast.showToast(msg: "خطأ حاول مره اخري");
                                  }

                                },
                                icon: Icon(Icons.menu_book,color: text,),
                                label: const Text("المنيو",style: TextStyle(fontSize: 20,color: Colors.black),),

                              ),
                            ),

                          ],
                        ),
                      ),

                      Container(
                        height: qurHeight*3.20,
                        margin: const EdgeInsets.only(left: 13,right: 13,bottom: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: appBarColor,
                          borderRadius: BorderRadius.circular(50),


                        ),
                        child: SingleChildScrollView(
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                 Text("العروض اليومية",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900,color: text),),
                                const SizedBox(
                                  height: 20,
                                ),

                                StreamBuilder(
                                  stream: offers.onValue,
                                  builder: (context,snapshot){
                                    allOffersList.clear();
                                    if(snapshot.data!=null){
                                      final dataEvent = snapshot.data as DatabaseEvent;
                                      if(dataEvent.snapshot.exists){
                                        final data = dataEvent.snapshot.value as Map<dynamic,dynamic>;
                                        offerList.clear();

                                        data.forEach((key, result) {
                                          offerList.add(OfferModel(id: key,url: result["url"], imagePath: result["imagePath"]));

                                        });
                                        allOffersList.addAll(offerList);
                                      }
                                    }

                                    return allOffersList.isEmpty?const Text("لا عروض اليوم",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),):  Column(
                                      children: allOffersList.map((offerData) => OfferItem(id: offerData.id, url: offerData.url, imagePath: offerData.imagePath)).toList(),
                                    );


                                  },
                                ),

                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
          ):
            Center(
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  "! لا يوجد اتصال بالانترنت", style: TextStyle(fontSize: 25),),
              ),
            );
        },
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.all(15),
        child: FloatingActionButton(
          backgroundColor: ThemesColor().getColor(34),
          onPressed: (){
            try{
              call.once().then((value) async {
                if(value.snapshot.exists){
                  final data = value.snapshot.value as Map<dynamic,dynamic>;
                  await FlutterPhoneDirectCaller.callNumber(data["number"]);

                }else if(value.snapshot.value==null){
                  Fluttertoast.showToast(msg: "لا يوجد رقم الان");
                }
              });

            }on FirebaseException catch(e){
              Fluttertoast.showToast(msg: "خطأ حاول مره اخري");
            }

          },
          child: Icon(Icons.call,color: text,),


        ),
      ),
    );
  }
}
