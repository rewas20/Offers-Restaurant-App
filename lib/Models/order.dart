class OrderModel {
  String offerId;
  String timeOrder;
  String offerImageUrl;
  String nameUser;
  String phoneNumber;
  String addressUser;
  String countOfOffer;
  String note;

  OrderModel({required this.offerId,required this.timeOrder,required this.offerImageUrl,required this.nameUser,required this.phoneNumber,
     required this.addressUser,required this.countOfOffer,required this.note});

  getMap(){
    return {
      "offerId": offerId,
      "timeOrder": timeOrder,
      "offerImageUrl": offerImageUrl,
      "nameUser": nameUser,
      "phoneNumber": phoneNumber,
      "addressUser": addressUser,
      "countOfOffer": countOfOffer,
      "note": note,
    };
  }

}