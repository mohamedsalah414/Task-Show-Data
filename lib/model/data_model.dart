class DataModel {
  DataModel({
    required this.id,
    required this.title,
    required this.img,
    required this.interest,
    required this.price,
    required this.date,
    required this.address,
    required this.trainerName,
    required this.trainerImg,
    required this.trainerInfo,
    required this.occasionDetail,
    required this.latitude,
    required this.longitude,
    required this.isLiked,
    required this.isSold,
    required this.isPrivateEvent,
    required this.hiddenCashPayment,
    required this.specialForm,
    this.questionnaire,
    this.questExplanation,
    required this.reservTypes,
  });
  late final int id;
  late final String title;
  late final List<String> img;
  late final String interest;
  late final int price;
  late final String date;
  late final String address;
  late final String trainerName;
  late final String trainerImg;
  late final String trainerInfo;
  late final String occasionDetail;
  late final String latitude;
  late final String longitude;
  late final bool isLiked;
  late final bool isSold;
  late final bool isPrivateEvent;
  late final bool hiddenCashPayment;
  late final int specialForm;
  late var questionnaire;
  late var questExplanation;
  late final List<ReservTypes> reservTypes;

  DataModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    img = List.castFrom<dynamic, String>(json['img']);
    interest = json['interest'];
    price = json['price'];
    date = json['date'];
    address = json['address'];
    trainerName = json['trainerName'];
    trainerImg = json['trainerImg'];
    trainerInfo = json['trainerInfo'];
    occasionDetail = json['occasionDetail'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isLiked = json['isLiked'];
    isSold = json['isSold'];
    isPrivateEvent = json['isPrivateEvent'];
    hiddenCashPayment = json['hiddenCashPayment'];
    specialForm = json['specialForm'];
    questionnaire = null;
    questExplanation = null;
    reservTypes = List.from(json['reservTypes']).map((e)=>ReservTypes.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['img'] = img;
    _data['interest'] = interest;
    _data['price'] = price;
    _data['date'] = date;
    _data['address'] = address;
    _data['trainerName'] = trainerName;
    _data['trainerImg'] = trainerImg;
    _data['trainerInfo'] = trainerInfo;
    _data['occasionDetail'] = occasionDetail;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['isLiked'] = isLiked;
    _data['isSold'] = isSold;
    _data['isPrivateEvent'] = isPrivateEvent;
    _data['hiddenCashPayment'] = hiddenCashPayment;
    _data['specialForm'] = specialForm;
    _data['questionnaire'] = questionnaire;
    _data['questExplanation'] = questExplanation;
    _data['reservTypes'] = reservTypes.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class ReservTypes {
  ReservTypes({
    required this.id,
    required this.name,
    required this.count,
    required this.price,
  });
  late final int id;
  late final String name;
  late final int count;
  late final int price;

  ReservTypes.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    count = json['count'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['count'] = count;
    _data['price'] = price;
    return _data;
  }
}