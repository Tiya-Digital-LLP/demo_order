import 'package:demoorder/generated/assets.dart';

List<String> mlmList = [
  "Leader",
  "Trainer",
  "Company",
  "Software Developer",
  "Product Supplier",
  "Consultant",
  "Employee",
  "Non MLM Person",
];

List<String> companyList = [
  "Binford Ltd.",
  "Barone LLC.",
  "Acme Co.",
  "Biffco Enterprises Ltd.",
  "Big Kahuna Burger Ltd.",
  "Consultant",
  "Acme Co.",
  "Abstergo Ltd.",
];

List<String> planList = [
  "Affiliate Plan",
  "Australian Binary Plan",
  "Autofill Plan",
  "Autopool Plan",
  "Binary",
];

List<String> subCategoryList = [
  "Sub Category 1",
  "Sub Category 2",
  "Sub Category 3",
  "Sub Category 4",
  "Sub Category 5",
  "Sub Category 6",
];

List<String> userTypeList = [
  "UserType 1",
  "UserType 2",
  "UserType 3",
  "UserType 4",
  "UserType 5",
  "UserType 6",
];

class BottomBarItem {
  final String imageAsset;
  final String name;

  BottomBarItem({required this.imageAsset, required this.name});
}

List<String> bottomBarImages = [
  Assets.svgHome,
  Assets.svgClassified,
  Assets.svgDatabase,
  Assets.svgBannerAd,
  Assets.svgIcons8Menu,
];

List<String> bottomBarTexts = [
  'Home',
  'Classified',
  'Database',
  'Banner Ads',
  'Menu',
];

// List suggestedAUserList = [
//   UserSuggestionDetails(
//       userImage: Assets.imagesIcon,
//       name: "Rutvik Korat",
//       post: "Flutter Developer"),
//   UserSuggestionDetails(
//       userImage: Assets.imagesIcon,
//       name: "Rutvik Korat",
//       post: "Flutter Developer"),
//   UserSuggestionDetails(
//       userImage: Assets.imagesIcon,
//       name: "Rutvik Korat",
//       post: "Flutter Developer"),
//   UserSuggestionDetails(
//       userImage: Assets.imagesIcon,
//       name: "Rutvik Korat",
//       post: "Flutter Developer"),
//   UserSuggestionDetails(
//       userImage: Assets.imagesIcon,
//       name: "Rutvik Korat",
//       post: "Flutter Developer"),
//   UserSuggestionDetails(
//       userImage: Assets.imagesIcon,
//       name: "Rutvik Korat",
//       post: "Flutter Developer"),
// ];

// List postList = [
//   PostClass(
//       userImage: Assets.imagesIcon,
//       userName: "Rutvik Korat",
//       postCaption:
//           "Look my collection, i really want to share about my last trip to bail.",
//       postImage: Assets.imagesPostImage),
//   PostClass(
//       userImage: Assets.imagesIcon,
//       userName: "Vijay Makwana",
//       postCaption: "Look my collection!",
//       postImage: Assets.imagesPostImage),
//   PostClass(
//       userImage: Assets.imagesIcon,
//       userName: "Rutvik Korat",
//       postCaption:
//           "Look my collection, i really want to share about my last trip to bail. Please check guys!",
//       postImage: Assets.imagesPostImage),
//   PostClass(
//       userImage: Assets.imagesIcon,
//       userName: "Rutvik Korat",
//       postCaption:
//           "Look my collection, i really want to share about my last trip to bail. Please check guys!",
//       postImage: Assets.imagesPostImage),
//   PostClass(
//       userImage: Assets.imagesIcon,
//       userName: "Rutvik Korat",
//       postCaption:
//           "Look my collection, i really want to share about my last trip to bail. Please check guys!",
//       postImage: Assets.imagesPostImage),
// ];

// List newsListclassifiedList = [
//   ClassifiedList(
//       userImage: Assets.imagesIcon,
//       userName: "Aman Talaviya",
//       postTitle: "Hello all here we are selling",
//       postCaption:
//           "Look my collection, i really want to share about my last trip to bail. Please check guys!",
//       postImage: Assets.imagesProductImage),
//   ClassifiedList(
//       userImage: Assets.imagesIcon,
//       userName: "Vijay Makwana",
//       postTitle: "Hello all here we are selling",
//       postCaption:
//           "Look my collection, i really want to share about my last trip to bail. Please check guys!",
//       postImage: Assets.imagesProductImage),
//   ClassifiedList(
//       userImage: Assets.imagesIcon,
//       userName: "Rutvik Korat",
//       postTitle: "Hello all here we are selling",
//       postCaption:
//           "Look my collection, i really want to share about my last trip to bail. Please check guys!",
//       postImage: Assets.imagesProductImage),
//   ClassifiedList(
//       userImage: Assets.imagesIcon,
//       userName: "Rutvik Korat",
//       postTitle: "Hello all here we are selling",
//       postCaption:
//           "Look my collection, i really want to share about my last trip to bail. Please check guys!",
//       postImage: Assets.imagesProductImage),
//   ClassifiedList(
//       userImage: Assets.imagesIcon,
//       userName: "Rutvik Korat",
//       postTitle: "Hello all here we are selling",
//       postCaption:
//           "Look my collection, i really want to share about my last trip to bail. Please check guys!",
//       postImage: Assets.imagesProductImage),
// ];

// List newsList = [
//   NewsClassList(
//       userImage: Assets.imagesIcon,
//       userName: "Aman Talaviya",
//       postTitle: "Hello all here we are selling",
//       postCaption:
//           "Look my collection, i really want to share about my last trip to bail. Please check guys!",
//       postImage: Assets.imagesProductImage),
//   NewsClassList(
//       userImage: Assets.imagesIcon,
//       userName: "Vijay Makwana",
//       postTitle: "Hello all here we are selling",
//       postCaption:
//           "Look my collection, i really want to share about my last trip to bail. Please check guys!",
//       postImage: Assets.imagesProductImage),
//   NewsClassList(
//       userImage: Assets.imagesIcon,
//       userName: "Shubham Khatari",
//       postTitle: "Hello all here we are selling",
//       postCaption:
//           "Look my collection, i really want to share about my last trip to bail. Please check guys!",
//       postImage: Assets.imagesProductImage),
//   NewsClassList(
//       userImage: Assets.imagesIcon,
//       userName: "Nisarg",
//       postTitle: "Hello all here we are selling",
//       postCaption:
//           "Look my collection, i really want to share about my last trip to bail. Please check guys!",
//       postImage: Assets.imagesProductImage),
//   NewsClassList(
//       userImage: Assets.imagesIcon,
//       userName: "Ajay Pate;",
//       postTitle: "Hello all here we are selling",
//       postCaption:
//           "Look my collection, i really want to share about my last trip to bail. Please check guys!",
//       postImage: Assets.imagesProductImage),
// ];

// List manageQuationAnswerList = [
//   ManageQuation(
//     userImage: Assets.imagesEllipse,
//     userName: "Ralph Edwards",
//     postCaption:
//         "What role does brand positioning and reputation play in pricing strategies on Amazon?",
//   ),
//   ManageQuation(
//     userImage: Assets.imagesEllipse,
//     userName: "Ralph Edwards",
//     postCaption:
//         "What role does brand positioning and reputation play in pricing strategies on Amazon?",
//   ),
//   ManageQuation(
//     userImage: Assets.imagesEllipse,
//     userName: "Ralph Edwards",
//     postCaption:
//         "What role does brand positioning and reputation play in pricing strategies on Amazon?",
//   ),
//   ManageQuation(
//     userImage: Assets.imagesEllipse,
//     userName: "Ralph Edwards",
//     postCaption:
//         "What role does brand positioning and reputation play in pricing strategies on Amazon?",
//   ),
//   ManageQuation(
//     userImage: Assets.imagesEllipse,
//     userName: "Ralph Edwards",
//     postCaption:
//         "What role does brand positioning and reputation play in pricing strategies on Amazon?",
//   ),
//   ManageQuation(
//     userImage: Assets.imagesEllipse,
//     userName: "Ralph Edwards",
//     postCaption:
//         "What role does brand positioning and reputation play in pricing strategies on Amazon?",
//   ),
// ];

// List companyListData = [
//   MlmCompanyList(
//     userImage: Assets.imagesIcon,
//     postTitle: "Seacret Direct LLC",
//     location: "Dhanbad, Jharkhand",
//     postCaption:
//         "A multi-level marketing business with headquarters in the United States called Seacret (Seacret Spa International/Seacret Direct) distributes cosmetics and other personal care items derived from Dead Sea minerals, mud, and nutrients.",
//   ),
//   MlmCompanyList(
//     userImage: Assets.imagesIcon,
//     postTitle: "Jio",
//     postCaption:
//         "A multi-level marketing business with headquarters in the United States called Seacret (Seacret Spa International/Seacret Direct) distributes cosmetics and other personal care items derived from Dead Sea minerals, mud, and nutrients.",
//     location: 'Mumbai, Maharashtra ',
//   ),
//   MlmCompanyList(
//     userImage: Assets.imagesIcon,
//     postTitle: "Pepsi",
//     postCaption:
//         "A multi-level marketing business with headquarters in the United States called Seacret (Seacret Spa International/Seacret Direct) distributes cosmetics and other personal care items derived from Dead Sea minerals, mud, and nutrients.",
//     location: 'Dhanbad, Jharkhand',
//   ),
//   MlmCompanyList(
//     userImage: Assets.imagesIcon,
//     postTitle: "Har Impex",
//     postCaption:
//         "A multi-level marketing business with headquarters in the United States called Seacret (Seacret Spa International/Seacret Direct) distributes cosmetics and other personal care items derived from Dead Sea minerals, mud, and nutrients.",
//     location: 'Ahmedabad , SouthBopal',
//   ),
//   MlmCompanyList(
//     userImage: Assets.imagesIcon,
//     postTitle: "Google",
//     postCaption:
//         "A multi-level marketing business with headquarters in the United States called Seacret (Seacret Spa International/Seacret Direct) distributes cosmetics and other personal care items derived from Dead Sea minerals, mud, and nutrients.",
//     location: 'Gandhinagar',
//   ),
// ];

// List userList = [
//   UserClass(
//     userImage: Assets.imagesIcon,
//     userName: "Rutvik Korat",
//     location: "Surat, India",
//     designation: "Flutter Developer",
//     plan: "Silver",
//   ),
//   UserClass(
//     userImage: Assets.imagesIcon,
//     userName: "Rutvik Korat",
//     location: "Surat, India",
//     designation: "Flutter Developer",
//     plan: "Silver",
//   ),
//   UserClass(
//     userImage: Assets.imagesIcon,
//     userName: "Rutvik Korat",
//     location: "Surat, India",
//     designation: "Flutter Developer",
//     plan: "Silver",
//   ),
//   UserClass(
//     userImage: Assets.imagesIcon,
//     userName: "Rutvik Korat",
//     location: "Surat, India",
//     designation: "Flutter Developer",
//     plan: "Silver",
//   ),
//   UserClass(
//     userImage: Assets.imagesIcon,
//     userName: "Rutvik Korat",
//     location: "Surat, India",
//     designation: "Flutter Developer",
//     plan: "Silver",
//   ),
//   UserClass(
//     userImage: Assets.imagesIcon,
//     userName: "Rutvik Korat",
//     location: "Surat, India",
//     designation: "Flutter Developer",
//     plan: "Silver",
//   ),
//   UserClass(
//     userImage: Assets.imagesIcon,
//     userName: "Rutvik Korat",
//     location: "Surat, India",
//     designation: "Flutter Developer",
//     plan: "Silver",
//   ),
//   UserClass(
//     userImage: Assets.imagesIcon,
//     userName: "Rutvik Korat",
//     location: "Surat, India",
//     designation: "Flutter Developer",
//     plan: "Silver",
//   ),
//   UserClass(
//     userImage: Assets.imagesIcon,
//     userName: "Rutvik Korat",
//     location: "Surat, India",
//     designation: "Flutter Developer",
//     plan: "Silver",
//   ),
// ];
