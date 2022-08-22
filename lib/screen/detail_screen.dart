import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_app/widgets/detail_info.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/detail';

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(data['name']!),
      // ),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 400,
                margin: EdgeInsets.zero,
                width: double.infinity,
                child: Image.network(
                  'https://source.unsplash.com/random',
                  fit: BoxFit.cover,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15),
                  ),
                ),
                clipBehavior: Clip.antiAlias,
              ),
              Positioned(
                left: 15,
                top: 20,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                ),
              ),
              Positioned(
                top: 20,
                right: 15,
                child: IconButton(
                  icon: Icon(
                    Icons.favorite_border_outlined,
                  ),
                  color: Colors.white,
                  onPressed: () {},
                ),
              ),
              Positioned(
                left: 25,
                bottom: 25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['name']!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.place,
                          color: Colors.white,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Qax seheri, Agcay kendi',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 25,
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    width: 70,
                    height: 270,
                    color: Colors.white,
                    child: ListView.builder(
                      itemCount: 7,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.all(5.0),
                        width: 60,
                        height: 60,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Image.network(
                          'https://source.unsplash.com/random',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DetailInfo(
                title: 'Distance',
                info: "54 km",
              ),
              DetailInfo(
                title: "Duration",
                info: "2.6 h",
              ),
              DetailInfo(
                title: "Rating",
                info: "3.6 k",
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 12),
                child: const Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 12, right: 12),
                child: Text(
                  "Beautiful place with its amazing nature.Live a life. You can take simple cotage here. Just relac and take a ... Read more",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
