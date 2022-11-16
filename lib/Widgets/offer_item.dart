import 'package:flutter/material.dart';

import '../Screens/ViewScreens/view_offer_screen.dart';
import '../Screens/order_screen.dart';
import '../Themes/colors_themes.dart';

class OfferItem extends StatelessWidget {
  String id;
  String url;
  String imagePath;


  OfferItem({Key? key, required this.id,required this.url,required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? appBarColor = ThemesColor().getColor(9);
    final qurHeight = (MediaQuery.of(context).size.height)/5.0;
    final qurWidth = (MediaQuery.of(context).size.width)/4;
    return Container(
        width: qurWidth*3.5,
        margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(color: Colors.white,spreadRadius: 5)
          ],
        ),
        child: Column(

          children: [
            Container(
              height: qurHeight*2,
              width: qurWidth*3.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      image: NetworkImage(url),
                      fit: BoxFit.fill
                  )
              ),
              child: InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed(ViewOfferScreen.routeName,arguments: {
                    "name":"العرض",
                    "image" : url
                  });
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: MaterialButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(OrderScreen.routeName,arguments: {
                    "id" : id,
                    "image": url,
                  });
                },
                height: 50,
                color: appBarColor,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add,color: ThemesColor().getColor(8),),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("اطلب الان",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: ThemesColor().getColor(8)),),
                  ],
                ),
              )
            ),


          ],
        )
    );
  }
}
