class Notifications {
  final String id;
  final String title;
  final String content;
  final String? imageUrl;
  final String? webUrl;
  final DateTime recievedAt;

  Notifications({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrl = '',
    this.webUrl = '',
    required this.recievedAt,
  });
}
