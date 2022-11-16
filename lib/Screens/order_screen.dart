import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:menu/Models/order.dart';
import 'package:menu/Screens/ViewScreens/view_offer_screen.dart';
import 'package:menu/Themes/colors_themes.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = "ORDER_SCREEN";
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  GlobalKey<FormState> formKeyOrder = GlobalKey<FormState>();
  String mapUrl = "https://www.google.com.eg/maps/";
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  String formatDate  = DateFormat("dd-MM-yyyy h:mm a").format(DateTime.now());
  int count = 1;
  final orders = FirebaseDatabase.instance.ref().child("Orders");
  @override
  Widget build(BuildContext context) {
    final qur = (MediaQuery.of(context).size.height-70)/5.0;
    final data = ModalRoute.of(context)!.settings.arguments as Map<dynamic,dynamic>;
    return Scaffold(
      backgroundColor: ThemesColor().getColor(8),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: ThemesColor().getColor(8),
        title: Text("الطلب",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: ThemesColor().getColor(30)),),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: qur*0.5,right: 15,left: 15),
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                height: qur*3.5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35)
                ),
                child: Center(
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKeyOrder,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(data["image"]),
                                      fit: BoxFit.fill
                                  )
                              ),
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).pushNamed(ViewOfferScreen.routeName,arguments: {
                                    "name":"العرض",
                                    "image" : data["image"],
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: nameController,
                                decoration: InputDecoration(

                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                  hintText: "الاسم",
                                  prefixIcon: const Icon(Icons.drive_file_rename_outline),
                                ),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "ادخل الاسم";
                                  } else if (value.length < 6) {
                                    return "ادخل الاسم ثنائي علي الاقل";
                                  }
                                }),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: phoneController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                hintText: "رقم الموبايل",
                                prefixIcon: const Icon(Icons.phone),
                              ),
                              keyboardType: TextInputType.phone,
                              validator: (value){
                                if(value!.isEmpty){
                                  return "رقم الموبايل مطلوب";
                                }else if(value.length<11 || value.length>11 || !value.startsWith("012") && !value.startsWith("011") && !value.startsWith("010") && !value.startsWith("015")){
                                  return "رقم خطأ";
                                }
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: addressController,
                              maxLines: null,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                hintText: "العنوان او لينك اللوكيشن",
                                prefixIcon: const Icon(Icons.map_outlined),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.add_location_alt),
                                  onPressed: () async {
                                    await launch(mapUrl);
                                  },
                                ),
                              ),
                              keyboardType: TextInputType.multiline,
                              validator: (value){
                                if(value!.isEmpty){
                                  return "العنوان مطلوب";
                                }
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: noteController,
                              maxLines: null,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                hintText: "اي ملاحظات",
                                prefixIcon: const Icon(Icons.notes),

                              ),
                              keyboardType: TextInputType.multiline,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  splashColor: Colors.black,
                                  focusColor: Colors.black,
                                  onPressed: (){
                                    if(count<15){
                                      setState(() {
                                        count++;
                                      });
                                    }

                                  },
                                  icon: const Icon(Icons.add_box,size: 30,),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text("$count",style: TextStyle(fontSize: 25,color: ThemesColor().getColor(8)),),
                                ),
                                IconButton(
                                  splashColor: Colors.black,
                                  focusColor: Colors.black,
                                  onPressed: (){
                                    if(count>1){
                                      setState(() {
                                        count--;
                                      });

                                    }
                                  },
                                  icon: const Icon(Icons.indeterminate_check_box_rounded,size: 30),
                                ),
                                Text("العدد",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: ThemesColor().getColor(8)),)
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                ),
              ),
              const SizedBox(height: 10,),
              MaterialButton(
                padding: EdgeInsets.all(8),
                onPressed: (){
                if(formKeyOrder.currentState!.validate()) {
                  formKeyOrder.currentState!.save();
                  showDialog(context: context, builder: (context)=> alertDialog(context,data,count));

                  }
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                color: ThemesColor().getColor(9),
                textColor: ThemesColor().getColor(8),
                child: const Text("اطلب",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                minWidth: 150,
              ),
            ],
          ),
        ),
      )
    );
  }
  void orderOffer(BuildContext context,data,count) {

      showDialog(context: context, builder: (ctx) => Center(
        child: CircularProgressIndicator(
          color: ThemesColor().getColor(1),
        ),
      ),barrierDismissible: false);

      try{
        orders.push().update(OrderModel(timeOrder: formatDate,offerId: data["id"], offerImageUrl: data["image"], nameUser: nameController.text.trim(), phoneNumber: phoneController.text.trim(), addressUser: addressController.text.trim(), countOfOffer: count.toString(),note: noteController.text.trim()).getMap()).then((value) {
          Navigator.of(context).pop();
          Fluttertoast.showToast(msg: "تم ارسال الطلب بنجاح");
          Navigator.of(context).pop();
        });
      }on FirebaseException catch(e){
        Fluttertoast.showToast(msg: "خطأ طلب , حاول مره اخري");
        Navigator.of(context).pop();
      }


    }



  alertDialog(context,data,count){
    return AlertDialog(
      alignment: Alignment.center,
      elevation: 1,
      title: const Text("تأكيد الطلب؟"),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      actions: [
        TextButton(onPressed: ()  {
          orderOffer(context,data,count);
          Navigator.of(context).pop();
          
        },
          child: const Text("نعم",style: TextStyle(fontSize: 20),),
        ),
        TextButton(onPressed: (){
          Navigator.of(context).pop();
          Fluttertoast.showToast(msg: "الغاء");
        },
          child: const Text("لا",style: TextStyle(fontSize: 20)),

        ),
      ],
    );
  }
}
