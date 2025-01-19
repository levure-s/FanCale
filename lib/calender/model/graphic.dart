class Graphic {
  Graphic({
    required this.id,
    required this.imgURL,
    required this.month,
    this.alignmentX = 0.0,
    this.alignmentY = 0.0,
  });
  final String id;
  final String imgURL;
  final int month;
  double alignmentX;
  double alignmentY;
}
