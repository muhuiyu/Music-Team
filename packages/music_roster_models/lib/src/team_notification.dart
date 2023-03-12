class TeamNotification {
  final String id;
  final String title;
  final String content;
  Function()? onPressed;
  bool hasRead;

  TeamNotification({
    required this.id,
    required this.title,
    required this.content,
    this.onPressed,
    this.hasRead = false,
  });
}
