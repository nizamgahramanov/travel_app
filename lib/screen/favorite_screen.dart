import 'package:flutter/cupertino.dart';
import 'package:travel_app/helpers/app_colors.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Favorite Screen",
          style: TextStyle(color: AppColors.textColor2),
        ),
      ),
    );
  }
}
