class OfferModel {
  String id;
  String url;
  String imagePath;

  OfferModel({required this.id,required this.url,required this.imagePath});

  getMap(){
    return {
      "url":url,
      "imagePath":imagePath
    };
  }
}