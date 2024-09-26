// ignore_for_file: public_member_api_docs, sort_constructors_first
class CustomNotification {
  final int id;
  final String? title;
  final String? body;
  final String? payload;

  CustomNotification({
    required this.id,
    this.title,
    this.body,
    this.payload,
  });
}
