import 'package:travel_app/model/user.dart';

class Review {
  final String review_content;
  final DateTime date;
  final User user;
  Review({
    required this.review_content,
    required this.date,
    required this.user,
  });
}
