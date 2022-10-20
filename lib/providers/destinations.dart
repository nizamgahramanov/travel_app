import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../model/destination.dart';
import '../services/firebase_firestore_service.dart';
import '../services/firebase_storage_service.dart';

class Destinations with ChangeNotifier {
  final firestore_service = FireStoreService();
  final storage_service = FirebaseStorageService();
  var uuid = Uuid();
  final List<Destination> _destinationItems = [
    // Destination(
    //   id: '1',
    //   name: "Nohur Lake",
    //   type: DestinationType.lake,
    //   photo_url: [
    //     'https://i.picsum.photos/id/461/200/300.jpg?hmac=dIwmQxeVflRD0QrOZ_p0_q-LpAY7sVhua6FCEIR_xi8',
    //     'https://i.picsum.photos/id/277/200/200.jpg?hmac=zlHjTbiytnfBWurpKXXSvMRzVSmkgW13o4K7Q-08r68',
    //     'https://i.picsum.photos/id/12/200/200.jpg?hmac=cX-VZ_FED6NC7EKPOnEaNhQEKw6Dy85IfsKItBkkGWA'
    //   ],
    //   region: "Ismayilli",
    //   overview:
    //       "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu",
    //
    // ),
    // Destination(
    //     id: '2',
    //     name: "Mamir shelalesi",
    //     type: DestinationType.waterfall,
    //     photo_url: [
    //       'https://i.picsum.photos/id/294/200/300.jpg?hmac=37ZMLugCxZOqrLbLvaJ_09fT_uPfl3zlMkICmkVxobg',
    //     ],
    //     region: "Qax",
    //     overview:
    //         "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque p mus. Donec quam felis, ultricies nec, pellentesque eu",
    //     ),
    // Destination(
    //   id: '3',
    //   name: "Qəbələ meşəsi",
    //   type: DestinationType.waterfall,
    //   photo_url: [
    //     'https://i.picsum.photos/id/509/200/300.jpg?hmac=Y2Mtq5PEipyaFNlDH01CoNhW9to1T8GCuTf6yUSH-TY',
    //   ],
    //   region: "Sheki",
    //   overview:
    //       "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu",
    //
    // ),
    // Destination(
    //   id: '4',
    //   name: "Qəbələ meşəsi",
    //   type: DestinationType.lake,
    //   photo_url: [
    //     'https://i.picsum.photos/id/166/200/300.jpg?hmac=tt6C1FuYJwyz0in9uZ9vFTADVlaezHjouGMPh60xVVo',
    //   ],
    //   region: "Qəbələ",
    //   overview:
    //       "natis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus",
    //
    // ),
    // Destination(
    //   id: '5',
    //   name: "Qəbələ meşəsi",
    //   type: DestinationType.lake,
    //   photo_url: [
    //     'https://i.picsum.photos/id/698/200/300.jpg?hmac=2Z_fr-yUH1ByQu36MAR319aTCndT4FjG1VBksAKGVKU',
    //   ],
    //   region: "Qəbələ",
    //   overview:
    //       "natis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus",
    //
    // ),
    // Destination(
    //   id: '6',
    //   name: "Qəbələ meşəsi",
    //   type: DestinationType.place,
    //   photo_url: [
    //     'https://i.picsum.photos/id/904/200/300.jpg?hmac=t7FNdMa1LwaLz0quPrFzXgqADg_jjQ4t7PuZeig7mY8',
    //     'https://i.picsum.photos/id/402/200/200.jpg?hmac=9PZqzeq_aHvVAxvDPNfP6GuD58m4rilq-TUrG4e7V80'
    //   ],
    //   region: "Qəbələ",
    //   overview:
    //       "natis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus",
    //
    // ),
    // Destination(
    //   id: '7',
    //   name: "Qəbələ meşəsi",
    //   type: DestinationType.place,
    //   photo_url: [
    //     'https://i.picsum.photos/id/317/200/300.jpg?hmac=HdC0gWrND7JkZOjptTsv0Wgbwwbml12B2V7WejQx8Ao',
    //   ],
    //   region: "Qəbələ",
    //   overview:
    //       "natis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus",
    //
    // ),
    // Destination(
    //   id: '8',
    //   name: "Qəbələ meşəsi",
    //   type: DestinationType.forest,
    //   photo_url: [
    //     'https://i.picsum.photos/id/1016/200/300.jpg?hmac=9uxvjfyOlAv4nhGgmHDnUN3rkdGW1VumbY05RL2msEQ',
    //   ],
    //   region: "Qəbələ",
    //   overview:
    //       "natis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus",
    //
    // ),
    // Destination(
    //   id: '9',
    //   name: "Qəbələ meşəsi",
    //   type: DestinationType.place,
    //   photo_url: [
    //     'https://i.picsum.photos/id/144/200/300.jpg?hmac=Ht6BBpdvDQfimGaAl_1BbAm3Fj5fHtMwP5C6xpsUL10',
    //   ],
    //   region: "Qəbələ",
    //   overview:
    //       "natis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus",
    //
    // ),
    // Destination(
    //   id: '10',
    //   name: "Qəbələ meşəsi",
    //   type: DestinationType.place,
    //   photo_url: [
    //     'https://i.picsum.photos/id/819/200/300.jpg?hmac=QrFu2y-FbDRBR4OFiSYDWP-w2egSTjiMkeagJb0rqM0',
    //   ],
    //   region: "Mess Hall",
    //   overview:
    //       "natis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus",
    //
    // ),
    // Destination(
    //   id: '11',
    //   name: "İlusu kendi",
    //   type: DestinationType.place,
    //   photo_url: [
    //     'https://i.picsum.photos/id/596/200/300.jpg?hmac=pVPfm7n4UQpHw17xww_PzqSAFP5JYEJo6qGFtPJxxA0',
    //     'https://i.picsum.photos/id/437/200/300.jpg?hmac=qjAKcFjQXvVBX_di7_9jMlPlgfQZUK2AV1IQ6W1eIIw',
    //     'https://i.picsum.photos/id/1006/200/300.jpg?hmac=8H_lylM_UA6ot7bOUTm-ZzZkGKHmdjC-QU4yB3Xo5aQ',
    //     'https://i.picsum.photos/id/815/200/300.jpg?hmac=Vd0SL31jtPA-FMvY___e5hp84IGLTUjtVJY4qUL6hOs',
    //     'https://i.picsum.photos/id/1036/200/300.jpg?hmac=VF4u-vITiP0ezQiSbE3UBvxHDFf8ZqJDycaAIoffsCg',
    //     'https://i.picsum.photos/id/570/200/300.jpg?hmac=fMlqjNmBSgN75P_tCU-PVSGzRYQxU23Xqd593HxZSZQ',
    //     'https://i.picsum.photos/id/478/200/300.jpg?hmac=9XTsWr649TEW4EJf8V09OflQrYWLvD63zeYkUNJ8Aq4'
    //   ],
    //   region: "İlusu",
    //   overview:
    //       "natis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus",
    //
    // ),
    // Destination(
    //   id: '12',
    //   name: "Qəbələ meşəsi",
    //   type: DestinationType.place,
    //   photo_url: [
    //     'https://i.picsum.photos/id/217/200/300.jpg?hmac=3GPQ-pPnL4D8miCKA0qNqIg4zr5Ponvl9OVH83CeGuc',
    //   ],
    //   region: "China",
    //   overview:
    //       "natis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus",
    //
    // ),
    // Destination(
    //   id: '13',
    //   name: "Qəbələ meşəsi",
    //   type: DestinationType.place,
    //   photo_url: [
    //     'https://i.picsum.photos/id/238/200/300.jpg?hmac=WF3u-tnO4aoQvz_F9p7zS0Dr5LwGx74tPabQf7EjHkw',
    //   ],
    //   region: "New York",
    //   overview:
    //       "natis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus",
    //
    // ),
    // Destination(
    //   id: '14',
    //   name: "Qəbələ meşəsi",
    //   type: DestinationType.place,
    //   photo_url: [
    //     'https://i.picsum.photos/id/322/200/300.jpg?hmac=q6h4jr1n6SrXrRCeqCblcexGQCfYmSXhr8Oo5EGoHIU',
    //   ],
    //   region: "Baki, IceriSheher",
    //   overview:
    //       "natis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus",
    //
    // ),
    // Destination(
    //   id: '15',
    //   name: "Qəbələ meşəsi",
    //   type: DestinationType.place,
    //   photo_url: [
    //     'https://i.picsum.photos/id/939/200/300.jpg?hmac=cj4OIUh8I6eW-hwT25m1_dCA6ZsAmSYixKCgsbZZmXk',
    //   ],
    //   region: "London",
    //   overview:
    //       "natis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus",
    //
    // ),
    // Destination(
    //   id: '16',
    //   name: "Qəbələ meşəsi",
    //   type: DestinationType.place,
    //   photo_url: [
    //     'https://i.picsum.photos/id/380/200/300.jpg?hmac=pJ07pMQFwFxeKrY1BVtkNgjInt7SZmR0UEOx00OPvHk',
    //   ],
    //   region: "Qəbələ",
    //   overview:
    //       "natis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus",
    //
    // ),
    // Destination(
    //   id: '17',
    //   name: "Qəbələ meşəsi",
    //   type: DestinationType.place,
    //   photo_url: [
    //     'https://i.picsum.photos/id/1018/200/300.jpg?hmac=IrYgAIczHOxOgmWliW3MlASD3LdAJ_aHAdh5f2aY9Sw',
    //   ],
    //   region: "Qəbələ",
    //   overview:
    //       "natis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus",
    //
    // ),
    // Destination(
    //   id: '18',
    //   name: "Qəbələ meşəsi",
    //   type: DestinationType.lake,
    //   photo_url: [
    //     'https://i.picsum.photos/id/176/200/300.jpg?hmac=FVhRySTQhcAO5Xvxk6nE-bMsJSyIAW8Uw6zWgAh9hzY',
    //     'https://i.picsum.photos/id/362/200/200.jpg?hmac=AKqfQ8tnyGapdUtZ1f35ugad3WkJY-g1tn5hi7kF2zY'
    //   ],
    //   region: "Qəbələ",
    //   overview:
    //       "natis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus",
    //
    // ),
    // Destination(
    //   id: '19',
    //   name: "Qanli gol",
    //   type: DestinationType.lake,
    //   photo_url: [
    //     'https://i.picsum.photos/id/606/200/300.jpg?hmac=BRE2ZQWvR5ntz52bw_Js0wWKmc4kKVAAppUz4_xfewo',
    //     'https://i.picsum.photos/id/372/200/300.jpg?hmac=Ng2Fl0_1eMGEpJhcZtvsqTvSOF7vxR0fxsPI6hPm_nk'
    //   ],
    //   region: "Qəbələ",
    //   overview:
    //       "natis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus",
    //
    // ),
    // Destination(
    //   id: '20',
    //   name: "Qəbələ meşəsi",
    //   type: DestinationType.place,
    //   photo_url: [
    //     'https://i.picsum.photos/id/409/200/300.jpg?hmac=DMEn4qNc0DsvxlQ4NSDPOesRyq8VhhGEi6IXy2DblLk',
    //   ],
    //   region: "Qəbələ",
    //   overview:
    //       "natis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus",
    //
    // ),
    // Destination(
    //   id: '21',
    //   name: "Qəbələ meşəsi",
    //   type: DestinationType.lake,
    //   photo_url: [
    //     'https://i.picsum.photos/id/270/200/300.jpg?hmac=To24fO6lmJwfKPyA9r3T_t07xLNZz3q_weS3ISynEGg',
    //   ],
    //   region: "Qəbələ",
    //   overview:
    //       "natis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus",
    //
    // ),
    // Destination(
    //   id: '22',
    //   name: "Qəbələ meşəsi",
    //   type: DestinationType.lake,
    //   photo_url: [
    //     'https://i.picsum.photos/id/381/200/300.jpg?hmac=DHcGsLBoQPJC-_rudxS4AdZuSE9UoOFP2U2v2veUAok',
    //   ],
    //   region: "Qəbələ",
    //   overview:
    //       "natis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus",
    //
    // ),
    // Destination(
    //   id: '23',
    //   name: "Qəbələ meşəsi",
    //   type: DestinationType.forest,
    //   photo_url: [
    //     'https://i.picsum.photos/id/568/200/300.jpg?hmac=vQmkZRQt1uS-LMo2VtIQ7fn08mmx8Fz3Yy3lql5wkzM',
    //   ],
    //   region: "Qəbələ",
    //   overview:
    //       "natis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus",
    //
    // ),
    // Destination(
    //   id: '24',
    //   name: "Qəbələ meşəsi",
    //   type: DestinationType.forest,
    //   photo_url: [
    //     'https://i.picsum.photos/id/993/200/300.jpg?hmac=wwmtancuL0E4SpM9dBnkL-0sXQCflrwn9mJZgo0GNKo',
    //     'https://i.picsum.photos/id/557/200/200.jpg?hmac=Y3oVAxcM0NGQ6OBLGhCOaRI9_TBDXdJFB8547MBovxU',
    //     'https://i.picsum.photos/id/849/200/300.jpg?hmac=yxC3iWchW02fPkymErlcM6lg2lcTCKGxXh49nblSx9I',
    //     'https://i.picsum.photos/id/681/200/300.jpg?hmac=RrSjLfU9adr2teGTAalv7b6XXsDyaPxIWyoBm30Qn5A',
    //     'https://i.picsum.photos/id/309/200/300.jpg?hmac=gmsts4-400Ihde9dfkfZtd2pQnbZorV4nBKlLOhbuMs'
    //   ],
    //   region: "Qəbələ",
    //   overview:
    //       "natis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus",
    //
    // ),
    // Destination(
    //   id: '25',
    //   name: "Qəbələ meşəsi",
    //   type: DestinationType.forest,
    //   photo_url: [
    //     'https://i.picsum.photos/id/518/200/300.jpg?hmac=sdLCI-ReSjkDP_MZCeAGaKOTkZc1RvC1i0cKyUReAts',
    //   ],
    //   region: "Qəbələ",
    //   overview:
    //       "natis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus",
    //
    // ),
    // Destination(
    //   id: '26',
    //   name: "Qəbələ meşəsi",
    //   type: DestinationType.forest,
    //   photo_url: [
    //     'https://i.picsum.photos/id/62/200/300.jpg?hmac=Ova5b3XqMVygL4ZvFJ1MfAehiXKiM1Ol14jN_6widUY',
    //   ],
    //   region: "Shusa",
    //   overview:
    //       "natis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus",
    //
    // ),
    // Destination(
    //   id: '27',
    //   name: "Qəbələ meşəsi",
    //   type: DestinationType.forest,
    //   photo_url: [
    //     'https://i.picsum.photos/id/476/200/300.jpg?hmac=_vE--dw3keZ1r73AbtN9I362ItgpZJkRbRrJsB688Kw',
    //   ],
    //   region: "Qəbələ",
    //   overview:
    //       "natis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus",
    //
    // ),
    // Destination(
    //   id: '28',
    //   name: "Qəbələ meşəsi",
    //   type: DestinationType.forest,
    //   photo_url: [
    //     'https://i.picsum.photos/id/424/200/200.jpg?hmac=NTuJ8oj4QEYm5LnuRc3FwfhXo9bxmLLibE6TqYkk6Po',
    //   ],
    //   region: "Qəbələ",
    //   overview:
    //       "natis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus",
    //
    // ),
    // Destination(
    //   id: '29',
    //   name: "Qəbələ meşəsi",
    //   type: DestinationType.forest,
    //   photo_url: [
    //     'https://i.picsum.photos/id/19/200/300.jpg?hmac=znGSIxHtiP0JiLTKW6bT7HlcfagMutcHfeZyNkglQFM',
    //   ],
    //   region: "Zaqatala",
    //   overview:
    //       "natis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus",
    //
    // ),
  ];
  Stream<List<Destination>> get destinationItemsAll  {
     final allDestination = firestore_service.getDestinations();
     print("DESTINATIKON");
     print(allDestination.length);
    return allDestination;
  }

  Destination findById(String id) {
    return _destinationItems.firstWhere((element) => element.id == id);
  }

  void saveData(Destination newDestination,List<File?> destinationPhoto) async {
    print("Destination item");
    print(newDestination.createMap().toString());
    final urlList = await storage_service.saveDestinationImages(newDestination,destinationPhoto);
    print('url');
    newDestination.photo_url=urlList;
    await firestore_service.saveDestination(newDestination);
  }

  Stream<List<Destination>> initSearchDestination(String enteredText){
    print(enteredText);
    final s =  firestore_service.getDestinationsBySearchText(enteredText);
    print("ASDA");
    print(s);
    return s;
  }

}
