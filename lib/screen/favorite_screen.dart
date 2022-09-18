import 'package:flutter/cupertino.dart';
import 'package:travel_app/helpers/app_colors.dart';

import '../model/destination.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Destination> favoriteList;
  FavoriteScreen({
    Key? key,
    required this.favoriteList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(favoriteList.length);
    return Container(
      padding: EdgeInsets.zero,
      width: 70,
      height: MediaQuery.of(context).size.height * 0.37,
      color: AppColors.inputColor,
      child: ListView.builder(
        itemCount: favoriteList.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) => GestureDetector(
            // onTap: () => verticalListItemClicked(index),
            child: Container(
          margin: const EdgeInsets.all(1.5),
          width: 65,
          height: 65,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 1.2,
                color: AppColors.buttonBackgroundColor.withOpacity(0.4),
              )),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              // scale:3,
              favoriteList[index].photo_url[0],
              fit: BoxFit.cover,
            ),
          ),
        )),
      ),
    );
  }
}
