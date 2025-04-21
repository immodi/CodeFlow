class Category {
  String image;
  String title;
  String desc;

  Category({
    required this.image,
    required this.title,
    required this.desc,
  });
  static List<Category> categoryData = [
    Category(
      image: 'assets/images/1.png',
      title: 'Effortless Code Editing',
      desc: 'Experience a sleek, intuitive editor built for productivity and creativity.',
    ),
    Category(
      image: 'assets/images/2.png',
      title: 'Collaborate in Real-Time',
      desc: 'Code together seamlessly with live collaboration features.',
    ),
    Category(
      image: 'assets/images/3.png',
      title: 'Code in Your Favorite Language',
      desc: 'From Python to JavaScript, write and preview code effortlessly.',
    ),

  ];
}
