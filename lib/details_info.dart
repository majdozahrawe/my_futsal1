class DetailsClass{


  String id;
  String imgUrl;
  String price;
  double rating ;
  String total_review;
  String title;
  String categorie;

  DetailsClass({this.id, this.imgUrl, this.price, this.rating, this.total_review,
      this.title, this.categorie});

}


List<DetailsClass> listSuitable=[  // [d(),d,d,d] listsut.add(b,c,v)
// 0
  DetailsClass(
    id: "1",
    imgUrl: 'http://192.168.8.100/flutter_api/uploads/image_picker3880172380653800557.jpg',
    price: "20",
    categorie: "خماسي",
    rating: 4,
    total_review: "220",
    title: "ملعب الاتحاد",
  ),
//1
  DetailsClass(
    id: "2",
    imgUrl: "http://192.168.8.100/flutter_api/uploads/image_picker8501138390503957364.jpg",
    price: "25",
    categorie: "سداسي",
    rating: 3,
    total_review: "520",
    title: "ملعب النخيل",
  ),

  DetailsClass(
    id: "3",
    imgUrl: "http://192.168.8.100/flutter_api/uploads/image_picker8832726494292056689.jpg",
    price: "25",
    categorie: "سداسي",
    rating: 3.5,
    total_review: "70",
    title: "ملعب جامعة اليرموك",


  ),

  DetailsClass(
    id: "4",
    imgUrl: "http://192.168.8.100/flutter_api/uploads/image_picker818641614619514306.jpg",
    price: "20",
    categorie: "سداسي",
    rating: 2.5,
    total_review: "140",
    title: "ملعب نادي الشباب",
  ),
];
//
// List<String> listString =[
//   "Category",
//   "Service",
//   "Reviews",
//   "Nearby",
// ];